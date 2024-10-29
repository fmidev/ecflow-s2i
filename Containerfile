FROM rockylinux/rockylinux:8

RUN rpm -ivh https://download.fmi.fi/fmiforge/rhel/8/x86_64/fmiforge-release-latest.noarch.rpm \
             https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
             https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    dnf -y install dnf-plugins-core && \
    dnf config-manager --set-enabled powertools && \
    dnf config-manager --set-disabled pgdg12 pgdg13 pgdg16 pgdg17 && \
    dnf -y module disable postgresql && \
    dnf config-manager --setopt="epel.exclude=eccodes*" --save && \
    dnf -y install ecflow5 ecflow5-server ecflow5-http ecflow5-python ecflow-scripts findutils && \
    dnf -y install python3-ecflow-openshift-agent && \
    dnf -y clean all

ENV PYTHONPATH /usr/ecflow5/lib/python3.6/site-packages/

ADD create-defs.sh /usr/ecflow5/bin
ADD load-defs.sh /usr/ecflow5/bin
ADD start.sh /usr/ecflow5/bin

#RUN svn co https://svn.fmi.fi/svn/tie/weto_ecf

ENV PATH /usr/ecflow5/bin:$PATH
