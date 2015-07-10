Name:		echotest
Version:	0.0.0
Release:	1%{?dist}
Summary:	test for echo

Group:		thegroup
License:	NOONECARESL
URL:		http://example.com
Source0:	echotest-0.0.0.tar.gz

BuildRoot:	%{_tmppath}/%{name}-buildroot

# BuildRequires:	
# Requires:	

%description
Just echo a damned thing

%prep
# isnt enough to comment out macros, need to double the %
%setup -q

%build
# isnt enough to comment out macros, need to double the %
# %%configure
# make %{?_smp_mflags}

%install
# if we needed to create a dir

rm -rf $RPM_BUILD_ROOT

install -m 0755 -d $RPM_BUILD_ROOT/usr/local/bin
install -m 0755 echotest.sh $RPM_BUILD_ROOT/usr/local/bin/echotest.sh


%clean
echo CLEANING
rm -rf $RPM_BUILD_ROOT

%files
# %doc README
/usr/local/bin/echotest.sh

%changelog

%post
echo It was installed?
