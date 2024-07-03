FROM quay.io/centos/centos:XXXXXXX

#RUN yum update -y

RUN dnf install -y selinux-policy-devel rpm-build rpm-sign

COPY ./script.sh .

RUN chmod u+x script.sh

# Script to execute when the docker container starts up
ENTRYPOINT ["bash", "/script.sh"]
