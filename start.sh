#!/bin/bash

docker run --init --detach --restart unless-stopped \
    --mount type=bind,src=/opt/graft-docker-mainnet/.graft,dst=/home/graft-sn/.graft/  \
    --interactive --tty -p 28880:28880 -p 28690:28690 -p 18980:18980 graft-pard0x
