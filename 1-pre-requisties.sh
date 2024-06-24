
echo "Installing the dependencies"
sleep 10
dnf -y install podman 
dnf -y install httpd-tools
dnf -y install git

echo "Clean up the previous attempts if already exists"
podman rmi icr.io/cpopen/cpd/olm-utils-v2:latest --force
podman rmi quay.io/bkdevara/registry:2 --force
rm -vrf /opt/registry
rm -rvf ~/green
rm -rvf ~/cpd-cli-linux-EE*
rm -rvf ~/cpd-cli-workspace.tar.gz

echo "Preparing your private registry...."
sleep 20
podman pull quay.io/bkdevara/registry:2 

mkdir -p /opt/registry/{auth,certs,data}

htpasswd -bBc /opt/registry/auth/htpasswd admin passw0rd

export HOSTNAME=`hostname`
  
openssl req -newkey rsa:4096 -nodes -sha256 -keyout /opt/registry/certs/domain.key -x509 -days 365 -out /opt/registry/certs/domain.crt -subj "/C=US/ST=CA/L=SVL/O=IBM/OU=SWG/CN=${HOSTNAME}"

export REGISTRY_SERVER=$HOSTNAME
export REGISTRY_PORT=5000
export LOCAL_REGISTRY="${REGISTRY_SERVER}:${REGISTRY_PORT}"
export EMAIL="testuser@email.com"
export REGISTRY_USER="admin"
export REGISTRY_PASSWORD="passw0rd"

podman run --name mirror-registry --publish $REGISTRY_PORT:5000 --detach --volume /opt/registry/data:/var/lib/registry:z --volume /opt/registry/auth:/auth:z --volume /opt/registry/certs:/certs:z --env "REGISTRY_AUTH=htpasswd" --env "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" --env REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd --env REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt --env REGISTRY_HTTP_TLS_KEY=/certs/domain.key quay.io/bkdevara/registry:2

sleep 20
echo "Test whether the registry is accessible"
podman login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY_SERVER}:${REGISTRY_PORT} --tls-verify=false


