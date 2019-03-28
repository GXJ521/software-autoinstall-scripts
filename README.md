# DevOps
## 运维开发
---
### Redis
```bash
cd /opt
tar zxvf redis_ha.tar.gz
./redisha_install.sh 
create public key ,please input slave host ip: 192.168.3.176
Generating public/private rsa key pair.
Your identification has been saved in /root/.ssh/id_dsa.
Your public key has been saved in /root/.ssh/id_dsa.pub.
The key fingerprint is:
SHA256:EOuLiWURyxyN5syZrF+uAa45h4FcZRecDPBqaOn0/GM root@redis-slave
The key's randomart image is:
+---[RSA 2048]----+
|   .++=.o        |
|   o+*.B         |
|   *B++          |
|  o.Oo .         |
|o=o+o . S        |
|*o== o..         |
| +o++o.          |
|oo. oE.          |
|oo  oo.          |
+----[SHA256]-----+
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_dsa.pub"
The authenticity of host '192.168.3.176 (192.168.3.176)' can't be established.
ECDSA key fingerprint is SHA256:osY7nzvy67fueEnsw8yGYHHlpThnpy17BNVDTj4TPF0.
ECDSA key fingerprint is MD5:4e:49:5a:bb:90:19:67:97:6d:1c:c0:5e:a2:6d:70:a4.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.3.176's password: 这里请输入从机密码

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@192.168.3.176'"
and check to make sure that only the key(s) you wanted were added.

Please input VIP: 192.168.3.175
Please input network card name: ens33
Please input mask(numbers): 24
```
