This repo has been expanded to include a skeleton rpmbuild folder. If you already have this folder structure, just copy the tarball in `SOURCES` and the specfile.

 - Build molly-guard with `rpmbuild -ba SPECS/molly-guard.spec`
 - Assuming all goes well, you should have a package in `RPMS/noarch`!

Yes, the patches were discarded and the specfile was made much simpler and probably less flexible, but at least you can read it.
