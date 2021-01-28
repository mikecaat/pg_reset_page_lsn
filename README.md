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
* -V, --version
  * Print the pg_reset_page_lsn version and exit.
* -?, --help
  * Show help about pg_reset_page_lsn command line arguments, and exit.
