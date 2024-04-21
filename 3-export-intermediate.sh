echo "Exporting the workspace"
mkdir ~/green
cd ~/cpd-cli-linux-EE-13.1.4-109

pwd

tar -czvf ~/cpd-cli-workspace.tar.gz cpd-cli-workspace

echo "stop and remove the olm-utils image"
sleep 10

podman rmi icr.io/cpopen/cpd/olm-utils-v2:latest --force

export PATH=~/cpd-cli-linux-EE-13.1.4-109/:$PATH

#rm -rf ~/cpd-cli-linux-EE-13.1.4-109/cpd-cli-workspace

echo "Lets simulate moving the workspace to a green zone" 
echo ".................."
sleep 10
export CPD_CLI_MANAGE_WORKSPACE=~/green/cpd-cli-workspace

cpd-cli manage restart-container

tar -xzvf ~/cpd-cli-workspace.tar.gz -C ~/green

