---
title: "关机不断电修复DSDT代码"
layout: post
category: "DSDT"
tags: ["dsdt" , "关机不断电" ,"电源补丁"]
---
{% include JB/setup %}


## 教程正文

打开你的DSDT.AML文件并查找 `Method (_PTS, 1, NotSerialized)`你看到以下代码：



```
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
```

**在第一行**

```
Method (_PTS, 1, NotSerialized)
```

**下面添加**

```
 {
        If (LEqual (Arg0, 0x05)) {}
        Else
```

**在收尾代码最后面加一个**

```
}
```

**修改完成后**

```

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
```

## 备注解释

添加的代码完整段是这样的

```
    Method (_PTS, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x05)) {}
        Else
        {
            ...  original codes...
        }
    }
```