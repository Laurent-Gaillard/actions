#! /bin/bash

pwd
mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
cp springboot.* rpmbuild/SOURCES/
cp selinux_springboot.spec rpmbuild/SPECS/
echo "SPEC_FILE_LOCATION: ${SPEC_FILE_LOCATION}"
echo "SELINUX_FILES_LOCATION: ${SELINUX_FILES_LOCATION}"
#ls -lR

echo "This is where we are"
pwd

/usr/bin/rpmbuild -bb rpmbuild/SPECS/selinux_springboot.spec

#We can work in /root/rpmbuild and then copy file to the workspace. This has to be decided.

#echo "Second LS ${1}"
#ls -lR

echo "::set-output name=rpmbuild_output_file::titi/toto.rpm"