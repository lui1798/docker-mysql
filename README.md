# docker-mysql



##### 在centos7的docker容器里面不能用service启动服务



配置centos7解决 docker Failed to get D-Bus connection 报错

配置centos的docker容器时，在里面安装mysql数据库，以下为安装mysql的命令：

```bash
yum -y install mariadb*
systemctl start mariadb.service  # 运行到这条报错  
systemctl enable mariadb.service 

# 设置root有用户密码
mysql_secure_installation123456
```

当时我配置项目服务器，调用了**systemctl**命令启动服务，报错。

------

原因及解决方式： 
这个的原因是因为**dbus-daemon**没能启动。其实**systemctl**并不是不可以使用。将你的CMD或者entrypoint设置为**/usr/sbin/init**即可。会自动将dbus等服务启动起来。 
然后就可以使用systemctl了。命令如下：

```bash
# 在创建docker容器时添加--privileged
docker run --privileged  -ti -e "container=docker"  -v /sys/fs/cgroup:/sys/fs/cgroup  centos  /usr/sbin/init
```