---
layout: post
permalink: /ElCapitan-u.html
title: "El Capitan 10.11系统U盘制作教程"
category: "tool"
tags: ["ElCapitan" , "系统安装盘教程"]
---
{% include JB/setup %}

### 准备

* 准备8G或者8G以上的U盘一枚
* 下载原版的El Capitan镜像文件 将下载好的{El Capitan app }拷贝到`应用程序`文件夹里

### 格式化U盘

打开 **`Launchpad`**(小火箭标识) 进入**`其他`**点开**`其他`**里的**`磁盘工具`**将准备好的U盘**`分区`**操作,选择**`一个分区`**,格式为**`Mac OS 扩展 (日志式)`** 将磁盘命名为**`install`** 找到**`选择`** 选择**`GUID 分区表`**之后再点**`应用`**对U盘进行格式化

### 制作启动盘

检查{El Capitan app}是否在**`应用程序`**文件夹里
打开`终端`输入

```
sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/install --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
```

按回车运行回车后，系统会提示你输入管理员密码，接下来就是等待系统开始制作启动盘了。这时，命令执行中你会陆续看到类似以下的信息：

```
Erasing Disk: 0%... 10%... 20%... 30%...100%...
Copying installer files to disk...
Copy complete.
Making disk bootable...
Copying boot files...
Copy complete.
Done.
```
    
当你看到最后有`Copy complete`和`Done`字样出现就是表示安装盘已经制作完成了

### 安装Clover引导到U盘

 用`Clover Configurator`挂载U盘的`EFI分区`，然后运行`Clover PKG`文件，选择安装到`U盘`，在`clover选项`界面，选在`安装Clover到EFI分区`，然后按个人的电脑进行`clover配置`，到这里整个启动盘就制作OK了

### 附件下载

**clover configurator传送门**:<http://pan.baidu.com/s/1qW7SHoK> 密码: `pd32`

**官方版Clover_v2.3k_r3259版本传送门**:<http://pan.baidu.com/s/1kTLAiJ9> 密码: `gwn9`

**编译版Clover_v2.3k_r3262版本传送门**:<http://pan.baidu.com/s/1qWJygji> 密码: `es9h`