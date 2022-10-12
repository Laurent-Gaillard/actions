#! /bin/bash

RC=0
WORKDIR=/github/workspace

pwd

mkdir -p ${WORKDIR}/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
RC=$(($RC + $? ))

if [ $RC -eq 0 ]
then
  echo "Source repository directory is: ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}"
  echo "::notice title=RPMbuild::Source repository directory is ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}"

  # Check that at least one SPEC file exists
  ls ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}/${INPUT_SPEC_FILE_LOCATION}/*.spec
  RC=$(($RC + $? ))

  if [ $RC -eq 0 ]
  then
    echo "::notice title=RPMbuild::Source repository directory is ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}"

    for specfile in ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}/${INPUT_SPEC_FILE_LOCATION}/*.spec
    do
      /usr/bin/rpmbuild -bb \
        --define="_topdir ${WORKDIR}/rpmbuild" \
        --define="_builddir ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}" \
        --define="provided_version ${INPUT_PROVIDED_VERSION:-null}" \
        --define="provided_release ${INPUT_PROVIDED_RELEASE:-null}" \
        ${specfile}
      rc=$?
      [ $rc -ne 0 ] && echo "::error title=RPMbuild::Could not build RPM for spec file ${specfile}."
      
      RC=$(($RC + $rc ))
    done
  else
    echo "::error title=RPMbuild::Could not find RPM spec file in ${WORKDIR}/${INPUT_SOURCE_REPO_LOCATION}/${INPUT_SPEC_FILE_LOCATION}/"
  fi
else
  echo "::error title=RPMbuild::Unable to create directories under ${WORKDIR}"
fi

exit $RC
