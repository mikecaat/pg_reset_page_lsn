# SPEC file for pg_reset_page_lsn

%define _pgdir   /usr/pgsql-13
%define _bindir  %{_pgdir}/bin
%define debug_package %{nil}

## Set general information for pg_reset_page_lsn.
Name:       pg_reset_page_lsn
Version:    13.2
Release:    1%{?dist}
Summary:    A tool for PostgreSQL to reset LSN of every pages in relation files
Group:      Applications/Databases
License:    PostgreSQL License
Source0:    %{name}-%{version}.tar.gz
BuildRoot:  %{_tmppath}/%{name}-%{version}-%{release}-%(%{__id_u} -n)

## We use postgresql-devel package
BuildRequires:  postgresql13-devel

%description
pg_reset_page_lsn scans the specified directory, finds all the relation files in it,
and forcibly resets LSN of every pages in them to the specified LSN. The server must
be shut down cleanly before running pg_reset_page_lsn.

## pre work for build pg_reset_page_lsn
%prep
%setup -q -n %{name}-%{version}

## Set variables for build environment
%build
make USE_PGXS=1 %{?_smp_mflags}

## Set variables for install
%install
rm -rf %{buildroot}
make USE_PGXS=1 DESTDIR=%{buildroot} install

%clean
rm -rf %{buildroot}

## Set files for this packages
%files
%defattr(-,root,root)
%{_bindir}/pg_reset_page_lsn

# History of pg_reset_page_lsn RPM.
%changelog
* Mon Mar 22 2021 - 13.2
- pg_reset_page_lsn-13.2 released
