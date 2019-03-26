#!/bin/bash 

# Start graft node
sudo /usr/sbin/service graftnoded start

# Start graft supernode
/usr/bin/graft-supernode --config-file ./config.ini --log-file /home/graft-sn/graft-supernode.log
