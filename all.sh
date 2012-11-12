# Build / Test skylib
go build

# Build / Test sky
cd cmd/sky && go build
cd ../../

cd cmd/skydaemon && go build
cd ../../

cd cmd/dashboard && go build
cd ../../

# Build / Test examples
cd examples/client && go build
cd ../../

cd examples/service && go build
cd ../../
