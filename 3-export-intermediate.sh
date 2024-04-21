echo "Exporting the workspace"
cd ~/cpd-cli-linux-EE-13.1.4-109
mkdir ~/green
export CPD_CLI_MANAGE_WORKSPACE=~/green/cpd-cli-workspace

tar -czvf ~/cpd-cli-workspace.tar.gz ~/cpd-cli-linux-EE-13.1.4-109/cpd-cli-workspace

echo "stop and remove the olm-utils image"
sleep 10

podman rmi icr.io/cpopen/cpd/olm-utils-v2:latest --force

export PATH=~/cpd-cli-linux-EE-13.1.4-109/:$PATH

rm -rf ~/cpd-cli-linux-EE-13.1.4-109/cpd-cli-workspace

echo "Lets simulate moving the workspace to a green zone" 
echo ".................."
sleep 10
cpd-cli manage test

tar -xzvf ~/cpd-cli-workspace.tar.gz -C ~/green

