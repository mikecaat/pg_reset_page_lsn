# pg_reset_page_lsn
pg_reset_page_lsn resets LSN of every pages in relation files.

pg_cheat_funcs is released under the [PostgreSQL License](https://opensource.org/licenses/postgresql), a liberal Open Source license, similar to the BSD or MIT licenses.

## Synopsis
pg_reset_page_lsn [*options*...]

## Description
pg_reset_page_lsn scans the specified directory, finds all the relation files in it, and forcibly resets LSN of every pages in them to the specified LSN. The server must be shut down cleanly before running pg_reset_page_lsn.

## Options
The following command-line options are available:

* -D, --directory=DIR
  * Specifies the directory where relation files are stored.
* -l, --lsn=LSN
  * Specifies LSN that pg_reset_page_lsn resets page LSN to.
* -k, --data-checksums
  * Update checksums of every pages in relation files.
* -N, --no-sync
  * By default, pg_reset_page_lsn will wait for all files to be written safely to disk. This option causes pg_reset_page_lsn to return without waiting, which is faster, but means that a subsequent operating system crash can leave the updated data directory corrupt. Generally, this option is useful for testing but should not be used on a production installation.
* -V, --version
  * Print the pg_reset_page_lsn version and exit.
* -?, --help
  * Show help about pg_reset_page_lsn command line arguments, and exit.

## Install
Download the source archive of pg_reset_page_lsn from [here](https://github.com/MasaoFujii/pg_reset_page_lsn), and then build and install it.

    $ cd pg_reset_page_lsn
    $ make USE_PGXS=1 PG_CONFIG=/opt/pgsql-X.Y.Z/bin/pg_config
    $ su
    # make USE_PGXS=1 PG_CONFIG=/opt/pgsql-X.Y.Z/bin/pg_config install
    # exit

USE_PGXS=1 must be always specified when building pg_reset_page_lsn. The path to [pg_config](http://www.postgresql.org/docs/devel/static/app-pgconfig.html) (which exists in the bin directory of PostgreSQL installation) needs be specified in PG_CONFIG. However, if the PATH environment variable contains the path to pg_config, PG_CONFIG doesn't need to be specified.

## Example
Find all the relation files in the tablespace directory and reset the LSN of every pages in them to the LSN `0/327B9A0`.

    $ pg_reset_page_lsn -D data/pg_tblspc/16384/ -l 0/327B9A0
