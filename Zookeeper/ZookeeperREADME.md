### Zookeeper伪集群
- 适配于CentOS7.6
```bash
cd /opt/Zookeeper_Pseudo_Cluster
./Zookeeper_Install.sh 
是否安装JDK？如果安装请选择y，不安装请选择n: y
```
```bash
success
success
success
success
success
success
success
success
success
success
*-----启动zookeeper节点1-----*
*-----zookeeper节点1启动成功-----*
*-----启动zookeeper节点2-----*
*-----zookeeper节点2启动成功-----*
*-----启动zookeeper节点3-----*
*-----zookeeper节点3启动成功-----* 
```
---
### Zookeeper集群
- 适配于CentOS7.6
```bash
cd /opt/Zookeeper_Cluster
./Zookeeper_Install.sh 
Please input node1 ip: 192.168.3.171
Please input node2 ip: 192.168.3.170
Please input node3 ip: 192.168.3.169
Generating public/private rsa key pair.
Created directory '/root/.ssh'.
Your identification has been saved in /root/.ssh/id_dsa.
Your public key has been saved in /root/.ssh/id_dsa.pub.
The key fingerprint is:
SHA256:tN6kLOUISJNkDMHGh03Zya6QBesCnTbQYZKNPIqvgeA root@redis-cluster-01
The key's randomart image is:
+---[RSA 2048]----+
|OXXo+ .          |
|o#=B +           |
|=.& .   .        |
|*= + . . .       |
|=oo o   S .      |
|+E.. . * +       |
| o    o = .      |
|.      .         |
|                 |
+----[SHA256]-----+
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_dsa.pub"
The authenticity of host '192.168.3.170 (192.168.3.170)' can't be established.
ECDSA key fingerprint is SHA256:Mc7hBWOjfC+KevMZ7jBLudz3ewk/xBlpPTPT9nWWi8c.
ECDSA key fingerprint is MD5:f9:20:fe:13:99:bf:d7:99:60:61:3b:00:74:b4:ec:e8.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.3.170's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@192.168.3.170'"
and check to make sure that only the key(s) you wanted were added.

/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_dsa.pub"
The authenticity of host '192.168.3.169 (192.168.3.169)' can't be established.
ECDSA key fingerprint is SHA256:DVBhAr3zUOj2IC+B/YyA6ONDDKskGL6SK95hrVfX6eg.
ECDSA key fingerprint is MD5:8b:b2:56:3b:5d:13:c3:9a:39:c5:3a:fa:2b:54:0e:f5.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.3.169's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@192.168.3.169'"
and check to make sure that only the key(s) you wanted were added.

success
success
success
*-----启动zookeeper节点1-----*
*-----zookeeper节点1启动成功-----*
*-----启动zookeeper节点2-----*
*-----zookeeper节点2启动成功-----*
*-----启动zookeeper节点3-----*
*-----zookeeper节点3启动成功-----*
```
