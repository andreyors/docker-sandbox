#!/bin/bash
DOCKERIP=`docker network inspect bridge -f "{{(index .IPAM.Config 0).Gateway}}"`

HOSTNAME="glispa.local"
HOSTLINE="$DOCKERIP\t$HOSTNAME"

echo -e $HOSTLINE
