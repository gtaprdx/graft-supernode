# graft-supernode
A Docker setup embedding graftnoded and graft-supernode for mainnet deployment.

## Quickstart
```
$ cd docker

# Edit supernode configuration (e.g. wallet-public-address) 
$ vim config.ini

$ docker build . -t graft-pard0x

$ cd ..

$ ./start.sh
```
