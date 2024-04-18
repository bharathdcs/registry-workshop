tar -czvf ~/cpd-cli-workspace.tar.gz ~/cpd-cli-linux-EE-13.1.3-98/cpd-cli-workspace


echo "stop and remove the olm-utils image"
sleep 10
podman rmi olm-utils-play-v2 --force

rm -rf ~/cpd-cli-linux-EE-13.1.3-98

echo "Lets simulate moving the workspace to a green zone" 
echo ".................."
sleep 10

mkdir ~/green
tar -xzvf ~/cpd-cli-workspace.tar.gz -C ~/green

export CPD_CLI_MANAGE_WORKSPACE=~/green/cpd-cli-workspace

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


