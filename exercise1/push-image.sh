export REGISTRY_SERVER=$HOSTNAME
export REGISTRY_PORT=5000
export LOCAL_REGISTRY="${REGISTRY_SERVER}:${REGISTRY_PORT}"
export EMAIL="testuser@email.com"
export REGISTRY_USER="admin"
export REGISTRY_PASSWORD="passw0rd"
export HOSTNAME=`hostname`

echo "Login to registry server"
podman login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY_SERVER}:${REGISTRY_PORT} --tls-verify=false

sleep 10

echo "Tag and push the image"
podman tag localhost/samplecontainer:latest ${REGISTRY_SERVER}:${REGISTRY_PORT}/samplecontainer:latest 

sleep 10
podman push ${REGISTRY_SERVER}:${REGISTRY_PORT}/samplecontainer:latest --tls-verify=false

