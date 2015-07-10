This repo has been expanded to include a skeleton rpmbuild folder. If you already have this folder structure, just copy the tarball in `SOURCES` and the specfile.

 - Build molly-guard with `rpmbuild -ba SPECS/$PACKAGE.spec`
 - Assuming all goes well, you should have a package in `RPMS/noarch`!
