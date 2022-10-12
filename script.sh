#! /bin/bash

WORKDIR=/github/workspace

pwd
mkdir -p ${WORKDIR}/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

RC=0

cp ${INPUT_SELINUX_FILES_LOCATION}/{*.te,*.fc,*.if} ${WORKDIR}/rpmbuild/SOURCES/
RC=$(($RC + $? ))
cp ${INPUT_SPEC_FILE_LOCATION}/*.spec ${WORKDIR}/rpmbuild/SPECS/
RC=$(($RC + $? ))

for specfile in $( find ${WORKDIR}/rpmbuild/SPECS/ -type f )
do
  /usr/bin/rpmbuild -bb \
    --define="_topdir ${WORKDIR}/rpmbuild" \
    --define="provided_version ${INPUT_PROVIDED_VERSION:-null}" \
    --define="provided_release ${INPUT_PROVIDED_RELEASE:-null}" \
    ${specfile}
  RC=$(($RC + $? ))
done

exit $RC
