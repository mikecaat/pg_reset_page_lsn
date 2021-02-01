CREATE EXTENSION pageinspect;

CREATE OR REPLACE FUNCTION verify_page_lsn () RETURNS void AS $$
DECLARE
    pgversion INTEGER;
    fork TEXT;
    rec RECORD;
    hdr RECORD;
BEGIN
    SELECT current_setting('server_version_num')::INTEGER INTO pgversion;
    FOR fork IN SELECT unnest(ARRAY['main', 'fsm', 'vm', 'init']) LOOP
        FOR rec IN SELECT n.nspname || '.' || c.relname AS tbl,
            generate_series(0, pg_relation_size(c.oid, fork) /
            current_setting('block_size')::bigint - 1) blkno
            FROM pg_class c, pg_namespace n
            WHERE c.relnamespace = n.oid AND
            n.nspname NOT IN ('pg_catalog', 'information_schema') LOOP
            IF pgversion >= 140000 THEN
                SELECT * INTO hdr FROM
                    page_header(get_raw_page(rec.tbl, fork, rec.blkno));
            ELSE
                SELECT * INTO hdr FROM
                    page_header(get_raw_page(rec.tbl, fork, rec.blkno::INTEGER));
            END IF;
            IF hdr.lsn <> '0/1'::pg_lsn AND hdr.upper <> 0 THEN
                RAISE EXCEPTION 'Invalid LSN "%" found in page % in table %',
                    hdr.lsn, rec.blkno, rec.tbl;
            END IF;
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
