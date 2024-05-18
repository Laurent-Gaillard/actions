<<<<<<< HEAD
FROM quay.io/centos/centos:XXXXXXX
=======
FROM  quay.io/fedora/fedora:39
>>>>>>> 1e7c445 (Create Fedora 39 branch)

#RUN yum update -y

RUN yum install -y selinux-policy-devel rpm-build

COPY ./script.sh .

RUN chmod u+x script.sh

# Script to execute when the docker container starts up
ENTRYPOINT ["bash", "/script.sh"]
