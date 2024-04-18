echo "Enter your CPD Entitlement Key"

wget https://github.com/IBM/cpd-cli/releases/download/v13.1.3/cpd-cli-linux-EE-13.1.3.tgz

tar -xzvf cpd-cli-linux-EE-13.1.3.tgz -C ~
export PATH=~/cpd-cli-linux-EE-13.1.3-98/:$PATH
export IBM_ENTITLEMENT_KEY=
export COMPONENTS=cpd_platform
export VERSION=4.8.1
export IMAGE_ARCH=amd64

export CPD_CLI_MANAGE_WORKSPACE=`pwd`

cpd-cli manage login-entitled-registry \
${IBM_ENTITLEMENT_KEY}

sleep 100

cpd-cli manage case-download \
--components=${COMPONENTS} \
--release=${VERSION}

sleep 100

cpd-cli manage mirror-images \
--components=${COMPONENTS} \
--release=${VERSION} \
--target_registry=127.0.0.1:12443 \
--arch=${IMAGE_ARCH} \
--case_download=false

sleep 100

export HOSTNAME=`hostname`
export PRIVATE_REGISTRY_LOCATION="${HOSTNAME}:5000"
export PRIVATE_REGISTRY_PUSH_USER=admin
export PRIVATE_REGISTRY_PUSH_PASSWORD=passw0rd

cpd-cli manage login-private-registry \
${PRIVATE_REGISTRY_LOCATION} \
${PRIVATE_REGISTRY_PUSH_USER} \
${PRIVATE_REGISTRY_PUSH_PASSWORD}

sleep 100

cpd-cli manage mirror-images \
--components=${COMPONENTS} \
--release=${VERSION} \
--source_registry=127.0.0.1:12443 \
--target_registry=${PRIVATE_REGISTRY_LOCATION} \
--arch=${IMAGE_ARCH} \
--case_download=false

sleep 100
