FROM ubuntu:18.04

# Create dedicated user graft-sn to run graft processes
RUN apt update && apt install sudo -y \
	&& cp /etc/sudoers /etc/sudoers.bak \ 
    && echo "graft-sn ALL=(ALL:ALL) ALL" >> /etc/sudoers \
    && echo  "graft-sn ALL=NOPASSWD:/usr/sbin/service graftnoded start, /usr/sbin/service graftnoded restart, /usr/sbin/service graftnoded stop" >> /etc/sudoers
RUN useradd -m graft-sn && usermod -aG sudo graft-sn

# Install dependencies & additional packages (e.g. netstat, ping, nc)
ENV BUILD_PACKAGES ca-certificates curl gnupg2 sed git ca-certificates wget curl systemd
ENV ADDITIONAL_PACKAGES net-tools vim htop iputils-ping netcat
RUN apt-get update && apt-get install --no-install-recommends -y $BUILD_PACKAGES

# Install graft binaries from official repo
RUN curl -s https://deb.graft.community/public.gpg | apt-key add - \
    && echo "deb [arch=amd64] https://deb.graft.community bionic main" > /etc/apt/sources.list.d/graft.community.list
RUN apt update && apt install graftnoded graft-supernode graft-blockchain-tools graft-wallet selinux-basics -y


# Systemctl is not working properly inside a Docker container
# we therefore use a service file to be able to start graftnoded
ADD graftnoded /etc/init.d/graftnoded

# The config.ini used by the supernode
ADD config.ini /home/graft-sn/config.ini

# The entrypoint of the container does the following:
#   1. start graftnoded as a service
#   2. start graft-supernode as foreground process 
ADD graft.sh /home/graft-sn/graft.sh

# Adjusting permissions and ownership
RUN chmod +x /home/graft-sn/graft.sh \
    && chmod +x /etc/init.d/graftnoded \
    && chown -R graft-sn:graft-sn /home/graft-sn

# Switching to graft-sn user
USER graft-sn
WORKDIR /home/graft-sn

CMD ["./graft.sh"]
