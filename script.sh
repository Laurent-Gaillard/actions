#! /bin/bash

WORKDIR=/github/workspace

pwd
mkdir -p ${WORKDIR}/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

RC=0

RPMMACROS_OPTIONS="-D '_topdir ${WORKDIR}/rpmbuild'"

[ -n "${INPUT_PROVIDED_VERSION}" ] && RPMMACROS_OPTIONS="${RPMMACROS_OPTIONS} -D 'provided_version ${INPUT_PROVIDED_VERSION}'"
[ -n "${INPUT_PROVIDED_RELEASE}" ] && RPMMACROS_OPTIONS="${RPMMACROS_OPTIONS} -D 'provided_release ${INPUT_PROVIDED_RELEASE}'"

cp ${INPUT_SELINUX_FILES_LOCATION}/{*.te,*.fc,*.if} ${WORKDIR}/rpmbuild/SOURCES/
RC=$(($RC + $? ))
cp ${INPUT_SPEC_FILE_LOCATION}/*.spec ${WORKDIR}/rpmbuild/SPECS/
RC=$(($RC + $? ))

for specfile in $( find ${WORKDIR}/rpmbuild/SPECS/ -type f )
do
  /usr/bin/rpmbuild -bb ${RPMMACROS_OPTIONS} ${specfile}
  RC=$(($RC + $? ))
done

exit $RC
