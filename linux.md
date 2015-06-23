title: Linux 学习分享
speaker: Bushen Shi
url: http://imcoach.cn
files: /js/linux.js,/css/linux.css,/js/zoom.js
theme: moon

[slide]

#Linux学习分享
##Linux系统介绍， 命令实例
<small>演讲者：史卜申</small>

[slide]
##操作系统的作用
----

* 进程管理（Processing management） {:&.rollIn}
* 内存管理（Memory management）
* 文件系统（File system）
* 网络通讯（Networking）
* 安全机制（Security）
* 用户界面（User interface）
* 驱动程序（Device drivers）


[slide]

* 桌面操作系统
	* Unix和类Unix操作系统: Mac OS X, Linux 发行版(如Debian，Ubuntu，Linux Mint，Suse Linux，Fedora等) {:&.moveIn}
	* 微软公司Windows操作系统：XP，Vista，7，8等
* 服务器操作系统
	* Unix系列：SUN Solaris，IBM-AIX，HP-UX，FreeBSD等; {:&.moveIn}
	* Linux系列：Red Hat Linux，CentOS，Debian，Ubuntu等;
	* Windows系列：Windows Server 2003, 2008，2008 R2等。
* 嵌入式操作系统
	* 涵盖生活各个方面，从便携设备到大型设施，移动设备，物联网（可以方便进行剪裁和移植的嵌入式 Linux、Windows CE等） {:&.moveIn}

[slide]

## GNU 革奴计划 & Linux
* GNU计划是由Richard Stallman在1983年9月27日公开发起的，85年创立自由软件基金会（Free Software Foundation）它的目标是创建一套完全自由的操作系统（实现UNIX系统的接口标准）, 90年依然没有操作系统内核.
	* 功能强大的文字编辑器Emacs
	* GCC（GNU Compiler Collection，GNU编译器集合）	

* 有些人生来就具有统率百万人的领袖风范；另一些人则是为写出颠覆世界的软件而生。唯一一个能同时做到这两者的人，就是托瓦兹。**Linus Torvalds(李纳斯·托瓦兹)**, Linux内核缔造者， 倡导开放源代码，尊重知识产权，91年追随自己内心的感受和Richard精神感召，Linux成为世界上最大的协作项目。

[slide]

##Redhat & Debian
<font size=4>Linux的发行版本大体分为商业公司维护的发行版本和社区组织维护的发行版本。</font>
---
| Redhat系列 | Debain系列 
------:|:-------:|:--------:
发行版本 | RHEL(收费版本)、Fedora Core(桌面版本发展而来)、CentOS(RHEL的社区克隆版本，免费) | Debian和Ubuntu等,最遵循GNU规范的Linux系统
包管理 | 基于RPM包的YUM包管理方式 | apt-get / dpkg包管理方式	
> ubuntu是基于Debian的unstable版本加强起来， 根据桌面系统不同 基于Gnome的ubuntu，基于KDE的Kubuntu以及基于Xfc的Xubuntu

> Gentoo 最年轻，完美的发行版，编译安装，适合自己定制，FreeBSD并不是一个Linux系统！但FreeBSD与Linux的用户群有相当一部分是重合的，二者支持的硬件环境也比较一致

[slide]

## shell 与计算机硬件交互的介质
<font size=4>一般Linux系统默认安装的shell叫做bash(Bourne Again Shell)，sh（Bourne Shell）的增强版本</font>
```shell
#符号#!用来告诉系统它后面的参数是用来执行该文件的程序
#!/bin/sh
#chmod +x filename 这样才能用./filename 来运行
#分号；语句分割符号
a="hello world"
echo $a
echo "this is ${a} print"
#export 处理过的变量叫做环境变量
export PATH=$PATH:/usr/local/mongodb/bin
```	

[slide]

##  unix 命令
```shell
wc –l file wc -w file wc -c file #计算文件行数计算文件中的单词数计算文件中的字符数
cut -b5-9 file.txt #输出每行第5个到第9个字符
cat file.txt #输出文件内容到标准输出设备（屏幕）上
read var #提示用户输入，并将输入赋值给变量
uniq #删除文本文件中重复出现的行列比如： sort file.txt | uniq
expr 2 "+" 3 #进行数学运算
cat file.txt | awk -F, '{print $1 "," $3 }' #这里我们使用，作为字段分割符，同时打印第一个和第三个字段
sed #Sed是一个基本的查找替换程序。可以从标准输入（比如命令管道）读入文本，并将结果输出到标准输出（屏幕）
basename /bin/tux #将返回 tux
dirname /bin/tux #返回 bin
head file; tail file #返回头几行 和 末尾几行
```

[slide]

##  管道, 重定向和 backtick
	
```shell
#管道 (|) 将一个命令的输出作为另外一个命令的输入。
grep "hello" file.txt | wc -l 
#重定向：将命令的结果输出到文件，而不是标准输出（屏幕）
#> 写入文件并覆盖旧文件， >> 加到文件的尾部，保留旧文件内容。
#使用反短斜线（`）可以将一个命令的输出作为另外一个命令的一个命令行参数
#用来查找过去24小时（-mtime –2则表示过去48小时）内修改过的文件， 并且打一个包
#!/bin/sh
# The ticks are backticks (`) not normal quotes ('):
tar -zcvf lastmod.tar.gz `find . -mtime -1 -type f -print` 
```


[slide]

## Linux 实用命令

> | ：管道符，前面多次说过，它的作用在于将符号前面命令的结果丢给符号后面的命令。这里提到的后面的命令，并不是所有的命令都可以的，一般针对文档操作的命令比较常用，例如cat, less, head, tail, grep, cut, sort, wc, uniq, tee, tr, split, sed, awk等等，其中grep, sed, awk为正则表达式必须掌握的工具。

[slide]

## Linux 实用命令 - 实例

```shell
find -type f -size 0 -exec rm -rf {} \ #删除0字节文件, -exec\-ok(安全模式会提示Y\N)
find -tyoe f -size 0 | xargs -0 rm  #xargs处理参数过长， -0 转义特殊字符
grep -r -a jpg /data/cache/* | strings | grep "http:" | awk -F'http:' '{print "http:"$2;}' #打印cache 里的url
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}' #查看http的并发请求数及其TCP连接状态
sed -i '/Root/s/no/yes/' /etc/ssh/sshd_config #sed在这个文里Root的一行，匹配Root一行，将no替换成yes
ps aux |grep mysql |grep -v grep |awk '{print $2}' |xargs kill -9 #杀死mysql进程
ls /etc/rc3.d/S* |cut -c 15- #显示运行3级别开启的服务
cat << EOF
+--------------------------------------------------------------+
| === Welcome to Tunoff services === |
+--------------------------------------------------------------+
EOF
ifconfig eth0 |grep "inet addr:" |awk '{print $2}'|cut -c 6- #活取Ip地址
ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' #活取Ip地址
#统计当前目录下所有markdown文件的字符数
find -name '*.md' -exec wc -c {} \;|awk '{print $1}'|awk '{a+=$1}END{print a}'
```

[slide]

## Linux 实用命令 - 实例

```shell
#查看连接某服务端口最多的的IP地址
netstat -an -t | grep ":80" | grep ESTABLISHED | awk '{printf "%s %s\n",$5,$6}' | sort 
#查看Apache的并发请求数及其TCP连接状态, NF代表：浏览记录的域的个数， $NF代表 ：最后一个Field(列)
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
cat /proc/loadavg #检查前三个输出值是否超过了系统逻辑CPU的4倍
free; vmstat 1 5 #进一步检查swap动作是否频繁
du -cks * | sort -rn | head -n 10 #df -h 之后检查某个分区下面大文件
netstat -an | grep -E "^(tcp)" | cut -c 68- | sort | uniq -c | sort -n #网络连接数目
lsof -i :80|grep -v "PID"|awk '{print "kill -9",$2}'|sh #杀死80端口相关的进程
ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9 # 清除僵尸进程
tcpdump -c 10000 -i eth0 -n dst port 80 > /root/pkts #tcpdump 抓包 ，用来防止80端口被人攻击时可以分析数据
#检查Ip的重复， 并排序
less /root/pkts | awk {'printf $3"\n"'} | cut -d. -f 1-4 | sort | uniq -c | awk {'printf $1" "$2"\n"'} 
```

[slide]

## Shell 变量使用

```shell
$#  #参数个数不包括脚本本身
$?  #执行上一条shell 命令的返回值
$0  #脚本自身名称 $1 第一个参数 $2 第二个参数, 以此类推
$*  #全部参数
$$  #当前进程标示号

#expr 计算命令 
vi sum
sum = `expr $1+ $2`
echo $1 + $2 = $sum
./sum 1 2 #输出 1 + 2 = 3

```

[slide]

##运算符应用

* 整数测试

	> test int1 -eq int2 (eq, ne, gt, lt, ge, le)
* 字符串测试

	> test -z string (-z[为空返回真], -n[为空返回假]) 
	> test str1 = str2 (=,!=)
* 文件测试

	> test -r filename (-r, -w, -x, -d[目录]，-s[大小不为零])
* 逻辑运算

	> test 表达式1 -a 表达式2 （-a[and], -o[or]）

[slide]

##条件控制
--------

<div class="columns-2">
<pre>
<code class="shell">
if [expression1]
then
	if [expression2]
	then
	fi
else
fi

if [$# -lt 1]
then
	echo  Usage:$0 参数1
	exit
fi
</code>
</pre>
<pre>
<code class="shell">
case string in
str1)

	command1;; #表示命令序列结束
str2)

	command2;;
*)

	defaut command;;
esac


</code>
</pre>
</div>

[slide]

##循环 -- for 
---

<div class="columns-2">
<pre>
<code class="shell">
for var in list #list 空格分割的变量	
do
	# ...
	echo $var
done
-----------------------------------------
for var #没有list， var中存储的是命令行参数
do
	# ..
	echo $var
done
</code>
</pre>
<pre>
<code class="shell">
#!/bin/sh
sum=0
for ccc
do
	if[`expr $ccc \>= 0` = 1]
	then
		echo -e "$ccc+\c" # -e 转义\, \c 输出后不按<enter> 回车
		sum= `expr $sum + $ccc` 
	fi
done
echo -e "\b=$sum" # \b 退格键
</code>
</pre>
</div>

[slide]

## 循环 - while, until
-----

<div class="columns-2">
<pre>
<code class="shell">
while 表达式
do
	命令串；
done
-----------------------------------------
until 表达式
do
	命令串；
done
</code>
</pre>
<pre>
<code class="shell">
#!/bin/sh
n=1
while [-n "$*"]
do
	# ..
	echo 第$n个参数是$1
 	n = `expr $n + 1`
	shift			#shift 左移命令行参数
done
</code>
</pre>
</div>

[slide]

## shell脚本 - 函数

```shell
#函数声明可不加function， 直接函数名（）
function fact() #计算阶乘
{
	if [ $1 -eq 0]
	then
		echo $2
		return
 	fi
	t = `expr $2 * $1`
  fact `expr $1 - 1` $t
}
fact $1 1

```
