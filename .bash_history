apt update
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update -y
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
apt install docker.io -y
usermod -aG docker ubuntu
systemctl restart docker
systemctl enable docker.service
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service
kubeadm join 172.31.95.188:6443 --token elio9t.2lg91er31w0hc21g         --discovery-token-ca-cert-hash sha256:8761d9b12fc996f5e26abb69674cdf7aa8c127f314afa027f43cf97e959bd5da
