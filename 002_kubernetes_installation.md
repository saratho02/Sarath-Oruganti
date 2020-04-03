# Install Kubernetes on Amazon EC2 (Amazon Linux 2 AMI)


## Instructions to run on both K8 master and worker nodes

$ login as: ec2-user

$ sudo su

$ cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

EOF

$ cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

$ sysctl --system

### Expected Output:

* Applying /etc/sysctl.d/00-defaults.conf ...
..
* Applying /etc/sysctl.d/k8s.conf ...
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
* Applying /etc/sysctl.conf ...


$ setenforce 0

Expected Output:   setenforce: SELinux is disabled

##Install Kubelet, Kubeadm and Kubectl on K8 master and worker nodes

$ yum install -y kubelet kubeadm kubectl 


Installed:
  kubeadm.x86_64 0:1.18.0-0                kubectl.x86_64 0:1.18.0-0                kubelet.x86_64 0:1.18.0-0


$ systemctl enable kubelet && systemctl start kubelet

Created symlink from /etc/systemd/system/multi-user.target.wants/kubelet.service to /usr/lib/systemd/system/kubelet.service.


Only on Kubernetes Master Node
==============================

$ sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=NumCPU

Expected Output: 
Your Kubernetes control-plane has initialized successfully!
……

Then you can join any number of worker nodes by running the following on each as root:


kubeadm join 172.31.41.123:6443 --token 7oy7kg.g2u9wmhewgxyl0zn \
    --discovery-token-ca-cert-hash sha256:9e94b12d9391d5afa78bf32beece20ae129f8cff8d3a81b2085ff718a9274879


Copy the above join command and save it to run on worker nodes.

# Execute the below instructions on K8 master node. 

#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Only on the worker node

#kubeadm join xxx. xxx. xxx. xxx:6443 --token 7oy7kg.g2u9wmhewgxyl0zn \
    --discovery-token-ca-cert-hash sha256:9e94b12d9391d5afa78bf32beece20ae129f8cff8d3a81b2085ff718a9274879

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

## Kubernetes Master Node
=========================

[root@...]# kubectl cluster-info

Kubernetes master is running at https://172.31.41.123:6443
KubeDNS is running at https://172.31.41.123:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

[root@...]# kubectl get nodes

NAME                                      	              STATUS     ROLES    AGE     VERSION
ip-X-X-X-X.ap-south-1.compute.internal    NotReady   <none>   2m51s    v1.18.0
ip-X-X-X-X.ap-south-1.compute.internal    NotReady    master   7m19s    v1.18.0


[root@...]# kubectl get nodes

[root@ip- kubernetes]  sudo kubectl apply -f etcd.yaml
[root@ip- kubernetes]  sudo kubectl apply -f rbac.yaml
[root@ip- kubernetes]  sudo kubectl apply -f calico.yaml

[root@ip- kubernetes] kubectl get nodes

NAME                   STATUS   	ROLES     AGE   	VERSION
ip- xxxxxxx            Ready    	master    15m   	v1.18.0
ip-xxxxxxx             Ready    	<none>    10m     	v1.18.0

kubectl get pods -o wide

Get the IP and run curl to check whether the nginx page is accessible

curl http://<IP>:80


