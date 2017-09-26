FROM rastasheep/ubuntu-sshd

ENV PUPPET_AGENT_VERSION="5.2.0" UBUNTU_CODENAME="trusty"

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget ca-certificates lsb-release && \
    wget https://apt.puppetlabs.com/puppet5-release-"$UBUNTU_CODENAME".deb && \
    dpkg -i puppet5-release-"$UBUNTU_CODENAME".deb && \
    rm puppet5-release-"$UBUNTU_CODENAME".deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y puppet-agent="$PUPPET_AGENT_VERSION"-1"$UBUNTU_CODENAME" && \
    apt-get remove --purge -y wget

RUN apt-get update && \
    apt-get install --no-install-recommends -y lsof software-properties-common python-software-properties && \ 
    add-apt-repository ppa:duggan/bats && \
    apt-get update && \
    apt-get install --no-install-recommends -y bats

RUN apt-get update && \
    apt-get install php5 -y 

ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH
