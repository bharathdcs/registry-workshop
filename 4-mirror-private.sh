export CPD_CLI_MANAGE_WORKSPACE=~/green/cpd-cli-workspace/
export HOSTNAME=`hostname`
export PRIVATE_REGISTRY_LOCATION="${HOSTNAME}:5000"
export PRIVATE_REGISTRY_PUSH_USER=admin
export PRIVATE_REGISTRY_PUSH_PASSWORD=passw0rd
export PATH=~/cpd-cli-linux-EE-13.1.4-109/:$PATH
export COMPONENTS=cpd_platform
export VERSION=4.8.4
export IMAGE_ARCH=amd64

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


