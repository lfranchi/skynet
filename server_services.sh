#!/bin/bash
export SKYNET_DZHOST=71.19.149.234:8046
export SKYNET_DZNSHOST=71.19.149.234:8046
export SKYNET_MGOSERVER=localhost:27017
export SKYNET_REGION=server

killall doozerd skydaemon dashboard

# Start DZNS master
doozerd -timeout 5 -l '71.19.149.234:10000' -w '71.19.149.234:11000' -c 'dzns' 0<&- &> ~/log/dzns.log &
sleep 1.5

# start doozer master
doozerd -timeout 5 -l '71.19.149.234:8046' -w '71.19.149.234:8080' -c 'skynet' -b 'doozer:?ca=71.19.149.234:10000' 0<&- &> ~/log/doozer.log &
sleep 1.5

# Start skynet daemon
~/src/gocode/src/github.com/bketelsen/skynet/cmd/skydaemon/skydaemon -l '71.19.149.234:9000' --version=1 0<&- &> ~/log/skynet_daemon.log &
sleep 1.5

# Dasbboard
~/src/gocode/src/github.com/bketelsen/skynet/cmd/dashboard/dashboard -d -addr 71.19.149.234:8090 --webroot=/home/leo/src/gocode/src/github.com/bketelsen/skynet/cmd/dashboard 0<&- &> ~/log/skynet_dashboard.log &

# Now can deploy in sky cli:
# deploy github.com/bketelsen/skynet/examples/testing/fibonacci/fibservice --version=2
# after having done a "go install"!
