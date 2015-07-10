Name:		molly-guard
Version:	0.5.1
Release:	1%{?dist}
Summary:	protects machines from accidental shutdowns/reboots

Group:		System administration tools
License:	MIT
URL:		http://github.com/tjcelaya/molly-guard
Source:		molly-guard-0.5.1.tar.gz

BuildRoot:	%{_tmppath}/%{name}-buildroot
BuildArch:	noarch

%description
The package installs a shell script that overrides the existing shutdown/reboot/halt/poweroff commands and first runs a set of scripts, which all have to exit successfully, before molly-guard invokes the real command.

One of the scripts checks for existing SSH sessions. If any of the four commands are called interactively over an SSH session, the shell script prompts you to enter the name of the host you wish to shut down. This should adequately prevent you from accidental shutdowns and reboots.

molly-guard diverts the real binaries to /lib/molly-guard/. You can bypass molly-guard by running those binaries directly.

%prep
%setup -q

%build
make %{?_smp_mflags}

%install
%make_install
%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/local/lib/molly-guard/molly-guard
/usr/local/share/man/man8/molly-guard.8.gz
/usr/local/etc/molly-guard/*

%changelog

%post
mkdir -m755 --parent /usr/local/sbin
ln -sf /usr/local/lib/molly-guard/molly-guard $RPM_BUILD_ROOT/usr/local/sbin/poweroff
ln -sf /usr/local/lib/molly-guard/molly-guard $RPM_BUILD_ROOT/usr/local/sbin/halt
ln -sf /usr/local/lib/molly-guard/molly-guard $RPM_BUILD_ROOT/usr/local/sbin/reboot
ln -sf /usr/local/lib/molly-guard/molly-guard $RPM_BUILD_ROOT/usr/local/sbin/shutdown

echo "\
=====================\
molly-guard is installed, but be aware that it can't detect certain scenarios!\
Details available in the man page\
\
Additionally, molly-guard installs shutdown scripts into /usr/local/sbin,\
which must come earlier in your path, this program will not run if you use an\
absolute path to your shutdown script.\
====================="
