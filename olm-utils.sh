if [ $# -ne 1 ]; then
    >&2 echo "Usage: olm-utils.sh '<Entitlement Key>' "
    exit 1
fi
KEY=$1

echo "Downloading the cpd-cli utility ---"

wget -v https://github.com/IBM/cpd-cli/releases/download/v13.1.3/cpd-cli-linux-EE-13.1.3.tgz

sleep 10

tar -xzvf cpd-cli-linux-EE-13.1.3.tgz -C ~


export PATH=~/cpd-cli-linux-EE-13.1.3-98/:$PATH
export IBM_ENTITLEMENT_KEY=$KEY
export COMPONENTS=cpd_platform
export VERSION=4.8.1
export IMAGE_ARCH=amd64

cd ~/cpd-cli-linux-EE-13.1.3-98/
export CPD_CLI_MANAGE_WORKSPACE=`pwd`

echo "Logging into registry"

cpd-cli manage login-entitled-registry \
${IBM_ENTITLEMENT_KEY}

echo "Downloading  the case files"
sleep 20
cpd-cli manage case-download \
--components=${COMPONENTS} \
--release=${VERSION}

echo "Mirror the images" 
sleep 20
cpd-cli manage mirror-images \
--components=${COMPONENTS} \
--release=${VERSION} \
--target_registry=127.0.0.1:12443 \
--arch=${IMAGE_ARCH} \
--case_download=false



export HOSTNAME=`hostname`
export PRIVATE_REGISTRY_LOCATION="${HOSTNAME}:5000"
export PRIVATE_REGISTRY_PUSH_USER=admin
export PRIVATE_REGISTRY_PUSH_PASSWORD=passw0rd

echo "Logging into the private registry"
sleep 20
cpd-cli manage login-private-registry \
${PRIVATE_REGISTRY_LOCATION} \
${PRIVATE_REGISTRY_PUSH_USER} \
${PRIVATE_REGISTRY_PUSH_PASSWORD}


echo "Mirror the images to private registry"
sleep 20
cpd-cli manage mirror-images \
--components=${COMPONENTS} \
--release=${VERSION} \
--source_registry=127.0.0.1:12443 \
--target_registry=${PRIVATE_REGISTRY_LOCATION} \
--arch=${IMAGE_ARCH} \
--case_download=false
