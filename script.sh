#! /bin/bash

WORKDIR=/github/workspace

pwd
mkdir -p ${WORKDIR}/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

RC=0

[ -n "${INPUT_PROVIDED_VERSION}" ] && PROVIDED_VERSION_OPTION="-D \"provided_version ${INPUT_PROVIDED_VERSION}\""
[ -n "${INPUT_PROVIDED_RELEASE}" ] && PROVIDED_RELEASE_OPTION="-D \"provided_release ${INPUT_PROVIDED_RELEASE}\""

cp ${INPUT_SELINUX_FILES_LOCATION}/{*.te,*.fc,*.if} ${WORKDIR}/rpmbuild/SOURCES/
RC=$(($RC + $? ))
cp ${INPUT_SPEC_FILE_LOCATION}/*.spec ${WORKDIR}/rpmbuild/SPECS/
RC=$(($RC + $? ))

for specfile in $( find ${WORKDIR}/rpmbuild/SPECS/ -type f)
do
  /usr/bin/rpmbuild -bb -D "_topdir ${WORKDIR}/rpmbuild" ${PROVIDED_VERSION_OPTION} ${PROVIDED_RELEASE_OPTION} ${specfile}
  RC=$(($RC + $? ))
done

exit $RC