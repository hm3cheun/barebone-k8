cp conf/containerd.conf /etc/modules-load.d/
modprobe overlay
modprobe br_netfilter
cp conf/99-kubernetes-cri.conf /etc/sysctl.d/
sysctl --system
apt-get update && sudo apt-get install -y containerd
mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
systemctl restart containerd
swap off -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cp conf/kubernetes.list /etc/apt/sources.list.d/
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
