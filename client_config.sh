#!/bin/bash
export SKYNET_DZHOST=71.19.149.234:8046
export SKYNET_DZNSHOST=71.19.149.234:8046
export SKYNET_MGOSERVER=localhost:27017
export SKYNET_REGION=laptop

# Forward ports
# ssh -N leo@pvm -L 27017:localhost:27017 &
# ssh -N leo@pvm -L 28017:localhost:28017 &

killall doozerd skydaemon dashboard

# Doozer node
doozerd -timeout 5 -l 'localhost:8046' -w 'localhost:8080' -c 'skynet' -b 'doozer:?ca=71.19.149.234:10000' 0<&- &> ~/src/gocode/log/doozer.log &
sleep 1.5

~/src/gocode/src/github.com/bketelsen/skynet/cmd/skydaemon/skydaemon --version=1 0<&- &> ~/src/gocode/log/skynet_daemon.log &
sleep 1.5
