---
title: 关机不断电修复DSDT代码
layout: post
category: DSDT
tags: [dsdt , 关机不断电 ,电源补丁]
date : 2015-9-21
duoshuo: true
---

## 教程正文

打开你的DSDT.AML文件并查找 `Method (_PTS, 1, NotSerialized)`你看到以下代码：



<pre class="brush: c; ruler: true; first-line: 0; highlight: [] ; auto-links: true ; collapse: true ; gutter: true; ">
    Method (_PTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x03))
        {
            Store (0x53, P80H)
        }

        And (GIO0, 0xFFFFDFFF, GIO0)
        If (LEqual (Arg0, 0x04))
        {
            Store (0x54, P80H)
            CMSW (0x6E, 0x6E)
        }

        Or (GPL0, 0x01000000, GPL0)
        Or (GPL1, 0x0100, GPL1)
        Return (Zero)
    }
</pre>

**在第一行**

<pre class="brush: c; ruler: true; first-line: 0; highlight: [] ; auto-links: true ; collapse: true ; gutter: true; ">
Method (_PTS, 1, NotSerialized)
</pre>

**下面添加**

<pre class="brush: c; ruler: true; first-line: 0; highlight: [] ; auto-links: true ; collapse: true ; gutter: true; ">
 {
        If (LEqual (Arg0, 0x05)) {}
        Else
</pre>

**在收尾代码最后面加一个**

<pre class="brush: c; ruler: true; first-line: 0; highlight: [] ; auto-links: true ; collapse: true ; gutter: true; ">
}
</pre>

**修改完成后**

<pre class="brush: c; ruler: true; first-line: 0; highlight: [] ; auto-links: true ; collapse: true ; gutter: true; ">

    Method (_PTS, 1, NotSerialized)
    {  
       If (LEqual (Arg0, 0x05)) {}
       Esle
       {
        If (LEqual (Arg0, 0x03))
        {
            Store (0x53, P80H)
        }

        And (GIO0, 0xFFFFDFFF, GIO0)
        If (LEqual (Arg0, 0x04))
        {
            Store (0x54, P80H)
            CMSW (0x6E, 0x6E)
        }

        Or (GPL0, 0x01000000, GPL0)
        Or (GPL1, 0x0100, GPL1)
        Return (Zero)
      }
    }
</pre>

## 备注解释

添加的代码完整段是这样的

<pre class="brush: c; ruler: true; first-line: 0; highlight: [] ; auto-links: true ; collapse: true ; gutter: true; ">
    Method (_PTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x05)) {}
        Else
        {
            ...  original codes...
        }
    }
</pre>

