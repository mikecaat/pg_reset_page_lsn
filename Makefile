PGFILEDESC = "pg_reset_page_lsn - reset page lsn"
PGAPPICON=win32

PROGRAM = pg_reset_page_lsn
OBJS = \
	$(WIN32RES) \
	pg_reset_page_lsn.o

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/pg_reset_page_lsn
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
