---
title: 利用AMD Framebuffer Utility 轻松驱动你的A卡
author: 猫叔
layout: post
permalink: /Framebuffer-amd-all.html
category: kext
tags:
  - AMD显卡驱动
  - 显卡驱动
---


本教程适用于：
● 如果您的电脑为双显卡，在BIOS中已经屏蔽了核芯显卡。
● 使用Clover引导OS X系统，推荐用Clover Configurator配置。如果是系统为10.11，Clover版本不小于3259，需要关闭SIP。
我使用的是Chameleon(变色龙)，[如何转换成Clover？](http://bbs.pcbeta.com/viewthread-1340057-1-1.html)[如何关闭SIP？](http://bbs.pcbeta.com/viewthread-1605186-1-1.html)

● /System/Library/Extensions「系统►资源库►Extensions」中AMD开头的kext未经删除和修改。
       没有备份原版？10.10驱动打包下载

声明：

● 本方法为驱动AMD显卡的通用方法，不能保证100%能驱动显卡。

● 在观看本帖的过程中，如有任何疑惑，欢迎回复本帖。


## 第一步：提取显卡ROM

在Windows中提取显卡ROM的工具有很多，例如AIDA64，GPU-Z等。在这一步中，我们将直接采用Clover提取显卡ROM。如果您已经提取显卡ROM，可以跳过此步骤。

● 在Clover引导界面，按下「F6」，Clover将会自动提取显卡ROM，不会有任何的提示。

![](http://cache.maoshu.cc/uploads/2015/09/105339p1tfsys3fpqy13ef.png.thumb_.jpg)

图1-1 Clover提取显卡ROM


● 如果您的磁盘采用是GPT分区方式，在系统启动完毕后，需要挂载EFI分区。打开Clover Configurator，点击左侧的「Mount EFI」。

![](http://cache.maoshu.cc/uploads/2015/09/112438u348v6q3qq8omo8s.png.thumb_.jpg)

图1-2 挂载EFI分区
您可以通过 ① 处的小圆点，判断EFI分区是否挂载。白色为尚未挂载，绿色为已经挂载。
点击右侧的 ②「Mount EFI Partition」，即可挂载分区

● 如果您的磁盘采用是GPT分区方式，在EFI分区下的`EFI/CLOVER/misc/`中将可以看到一个名为c0000.bin的文件，这个文件即为显卡ROM。如果您的磁盘采用是MBR分区方式，在OS X系统盘分区下`EFI/CLOVER/misc/`中也可以看到这样的文件。请将该文件复制到一个您方便访问的地方。

![](http://cache.maoshu.cc/uploads/2015/09/105341zixchc2rbummxsr2.png.thumb_.jpg)

图1-3 显卡ROM文件

## 第二步：获取显卡信息

通过对显卡ROM的分析，我们可以获得关于显卡的相关信息。在这一步中，我们将采用AMD Framebuffer Utility分析显卡ROM。此步骤需要在OS X下进行。[点击此处下载](http://pan.baidu.com/s/1ntGMsNR)AMD Framebuffer Utility

● 打开AMD Framebuffer Utility，① 选择您在第一步获取的显卡ROM文件，② 和您的系统所在分区。③ 最后，点击「显示接口数据」。

![](http://cache.maoshu.cc/uploads/2015/09/7BA73660-1223-4929-B54C-CC4649D2ABE8.png)

图2-1 选取显卡ROM文件

● AMD Framebuffer Utility将会显示显卡的基本信息。

![](http://cache.maoshu.cc/uploads/2015/09/183530w0lxxzegl875iel4.png.thumb_.jpg)

图2-2 获取显卡信息


以这个显卡为例，记录以下信息：

<table class="t_table" cellspacing="0">
  <tr>
    <td>
      ① 显卡ID:
    </td>
    
    <td>
      <strong>1002:6827<br /> </strong>写成Mac中采用的十六进制表示法即<strong><span style="color: #ff00ff;">0x68271002</span></strong>
    </td>
  </tr>
  
  <tr>
    <td>
      ② 对应的kext:
    </td>
    
    <td>
      <strong><span style="color: #0000ff;">AMD6000Controller</span></strong>
    </td>
  </tr>
  
  <tr>
    <td>
      ③ 是否在kext中找到显卡ID
    </td>
    
    <td>
     未在kext中找到显卡ID
    </td>
  </tr>
</table>

如果此处显示“**在kext中找到显卡ID**”，说明您的显卡ID原生被OS X支持（但这并不意味着免驱）。

<hr class="l" />

## 第三步：添加ID到支持列表


只有当显卡ID在kext的支持列表中，相应的kext才会加载。
如果上一步中显示“在kext中找到显卡ID”，则可以跳过此步骤。

● 打开Finder，① 选择顶栏的「前往」，② 在弹出菜单中选择「前往文件夹…」。③ 在弹出的窗口中输入/System/Library/Extensions/AMD6000Controller.kext/Contents。此处的AMD6000Controller为第二步中的kext名称。④ 点击「确定」

![](http://cache.maoshu.cc/uploads/2015/09/183624jttftdwmvgwd1wdp.png.thumb_.jpg)


图3-1 前往kext

● 用文本编辑打开Info.plist，并找到IOPCIMatch所对应的值。

![](http://cache.maoshu.cc/uploads/2015/09/183706vjlkljnottzknaty.png.thumb_.jpg)


图3-2 查看支持列表

在第二步中，我们获得的显卡ID写成16进制为`0x68271002`，我们需要在支持列表中找到一个接近的ID进行替换。对于这个显卡，我们选择`0x68401002`。根据您的显卡，找到一个接近的ID，选择的ID可能和本例不同。

对于新手，为了避免修改原版kext而导致的权限问题，我们建议采用Clover的Fake ID（仿冒ID）来修改。

● 打开Clover Configurator，并使其加载Clover配置文件config.plist。选择左侧的「Devices」。① 在ATI选框中填写要仿冒成的ID`0x68401002`

![](http://cache.maoshu.cc/uploads/2015/09/212325m6z01su5mtuh0ooz.png.thumb_.jpg)


图3-3 添加仿冒ID


## 第四步：定制Framebuffer

● 让我们重新打开AMD Framebuffer Utility。

![](http://cache.maoshu.cc/uploads/2015/09/183845id6bkvgeb9bbkri3.png.thumb_.jpg)

图4-1 检查接口信息

以这个显卡为例，我们可以获得以下信息：

<table class="t_table" cellspacing="0">
  <tr>
    <td>
      ① 选择的Framebuffer：
    </td>
    
    <td>
      <strong>Pondweed</strong>
    </td>
  </tr>
  
  <tr>
    <td>
      ② Framebuffer中定义的数目：
    </td>
    
    <td>
      <strong>3</strong>
    </td>
  </tr>
  
  <tr>
    <td>
      ③ 实际接口：
    </td>
    
    <td>
      三个DP，一个HDMI
    </td>
  </tr>
  
  <tr>
    <td>
      ④ 实际接口数目：
    </td>
    
    <td>
      <strong>4</strong>
    </td>
  </tr>
</table>

此时我们碰到了这样的情况，实际接口的数目多于Framebuffer中定义的数目。

在这里有两种解决方法：(如果您的实际接口的数目等于或少于Framebuffer中定义的数目，则不必进行这样的操作。)

1. [推荐]通过屏蔽部分实际接口，使实际接口的数量不多于Framebuffer中定义的数目。取消对应项勾选框的“√”即可。（例如，我不需要使用第三个接口，取消掉相应的“√”）

![](http://cache.maoshu.cc/uploads/2015/09/122315yhfuh22kp24p2yus.png.thumb_.jpg)

图4-2 屏蔽接口


2. 更换一个Framebuffer。在左侧的选择框中，包含着系统中所有原始的Framebuffer。您可以选择一个接口数量足够的Framebuffer。需要注意的是，选择的Framebuffer一定是第二步中显卡对应的kext中的Framebuffer。

![](http://cache.maoshu.cc/uploads/2015/09/122327vcatayu4ker4ewfw.png.thumb_.jpg)

图4-3 更换Framebuffer

接口信息下面的三个选项，程序将自动选择，保持默认即可。

![](http://cache.maoshu.cc/uploads/2015/09/124039qhpz6rs7dd1xwdhp.png.thumb_.jpg)

图4-4 选项


● 在调整好接口后，点击「保存所有数据」。

![](http://cache.maoshu.cc/uploads/2015/09/124606uxqgulu5qzbgln5n.png.thumb_.jpg)

图4-5 保存接口信息

我们得到了两个Framebuffer：

<table class="t_table" cellspacing="0">
  <tr>
    <td>
      ① ATI Connectors Data:
    </td>
    
    <td>
      02000000000100000901010010000505<br /> 00040000040300000001020011020101<br /> 00040000040300000001030021030202
    </td>
  </tr>
  
  <tr>
    <td>
      ② ATI Connectors Patch:
    </td>
    
    <td>
      00080000040200000071000011020101<br /> 00040000040600000001000021030202<br /> 00040000040300000001000012040303
    </td>
  </tr>
</table>


## 第五步：配置Clover

● 打开Clover Configurator，并使其加载Clover配置文件config.plist。打开左侧的「Kernel And Kext Patches」。

![](http://cache.maoshu.cc/uploads/2015/09/184014o3gmrmr2m31m7mm3.png.thumb_.jpg)

图5-1 填入接口信息1

将第四步中的 ① ATI Connectors Data和 ② ATI Connectors Patch分别整理成一行后，填入Clover的相应位置。

将第二步中的kext名称中包含的数字（例如，`AMD6000Controller`中包含的数字为`6000`），填入 ③“`Ati Connectors Controller`”中。

● 打开左侧的「Graphics」。

![](http://cache.maoshu.cc/uploads/2015/09/132507tqp7nqaqfpfph7yn.png.thumb_.jpg)

图5-2 填入接口信息2

① 将第四步中选择的Framebuffer（例如，Pondweed），填入“FB Name”中。

② 在“VRAM”中填写显存大小（以MB为单位，例：`512`，`1024`），可以在“Video Ports”中填写接口数量（例如，3）。

③ 勾选下方的“`Load VBIOS`”（笔记本显卡需要勾选），“`Patch VBIOS`”，“`Inject ATI`”，其它选项请不要勾选。

● 打开左侧的「Acpi」。① 勾选图上所示的ATI项，Clover回向DSDT中加入显卡信息。

![](http://cache.maoshu.cc/uploads/2015/09/214859o0nm617eee36n7m3.png.thumb_.jpg)

图5-3 加入显卡信息

● 保存配置文件，重启电脑，看看显卡是否驱动。

