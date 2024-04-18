echo "stop and remove the olm-utils image"
sleep 10
podman rmi olm-utils-play-v2 --force

cd ~/cpd-cli-linux-EE-13.1.3-98

tar -czvf ~/cpd-cli-workspace.tar.gz cpd-cli-workspace

export PATH=~/cpd-cli-linux-EE-13.1.3-98/:$PATH

#rm -rf ~/cpd-cli-linux-EE-13.1.3-98/cpd-cli-workspace

echo "Lets simulate moving the workspace to a green zone" 
echo ".................."
sleep 10

mkdir ~/green
tar -xzvf ~/cpd-cli-workspace.tar.gz -C ~/green

