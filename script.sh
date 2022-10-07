#! /bin/bash

WORKDIR=/github/workspace

pwd
mkdir -p ${WORKDIR}/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

cp *.te *.if *.fc ${WORKDIR}/rpmbuild/SOURCES/
cp *.spec ${WORKDIR}/rpmbuild/SPECS/

echo "First LS"
ls -lR

echo "This is where we are"

pwd



RC=0

for specfile in $( find ${WORKDIR}/rpmbuild/SPECS/ -type f)
do
  /usr/bin/rpmbuild -bb -D "_topdir ${WORKDIR}/rpmbuild" ${specfile}
  RC=$(($RC + $? ))
done

echo"::set-output name=rpm_dir::rpmbuild/RPMS"

find rpmbuild/RPMS

exit $RC