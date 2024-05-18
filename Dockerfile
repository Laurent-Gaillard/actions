FROM  quay.io/fedora/fedora:40

#RUN yum update -y

RUN dnf install -y selinux-policy-devel rpm-build

COPY ./script.sh .

RUN chmod u+x script.sh

# Script to execute when the docker container starts up
ENTRYPOINT ["bash", "/script.sh"]
