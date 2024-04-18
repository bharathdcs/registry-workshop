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





