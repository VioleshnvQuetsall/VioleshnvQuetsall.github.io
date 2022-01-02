---
layout: post
title: C#笔记其五
description: >
  学习C#时所做的笔记
sitemap: false
hide_last_modified: true
categories: [c#]
tags: [c#]
---

0. this line will be replaced by toc
{:toc}

#### 输入输出

```csharp
ConsoleKeyInfo c;
do
{
    c = Console.ReadKey(); // 读取按键
}
while (c.Key != ConsoleKey.Escape); // 等待输入Esc键

string s = Console.ReadLine();
if (s != "123")
    Console.Write(s + "456");
Console.WriteLine();
```

#### 格式化

###### 字符串格式化

```csharp
string name = "abc";
int id = 12;
string s = $"{name}: {id}";
s = string.Format("{0}: {1}", name, id);

Console.WriteLine($"{id:C}"); // ￥12.00
Console.WriteLine($"{id:D5}"); // 00012
Console.WriteLine($"{id:F3}"); // 12.000
Console.WriteLine($"{id:000.00}"); // 012.00
Console.WriteLine($"{id:00(0.0)0}"); // 01(2.0)0
Console.WriteLine($"{id:0(##)0}"); // 0(01)2
```

日期格式化

```csharp
DateTime date = new DateTime(2000, 10, 5, 6, 11, 3);
WriteLine($"{date}"); //2000/10/5 6:11:03
WriteLine($"{date:dddd yyyy MM tt}"); // 星期四 2000 10 上午
```

官方文档中还有更多格式化参数，见 [.NET 中的格式类型](https://docs.microsoft.com/zh-cn/dotnet/standard/base-types/formatting-types)

### 注释和XML

```csharp
/* 行内注释、多行注释 */
// 单行注释

/** XML行内注释、多行注释 会被编辑器注意到并被放在单独文本文件中 **/
/// XML单行注释 同上
```

> 不要使用注释，除非代码一言难尽
> 写清楚的代码而非用注释澄清复杂算法

```csharp
/// <summary>
/// 
/// </summary>
/// <param name="text"></param>
```

在代码前加入XML注释可以被IDE识别，并且进行**高亮**和**语法提示**如果在编译时提供命令行选项，还会将注释写入XML文档中作为API文档

以下是建议的XML注释元素的标记

```csharp
/// <code></code>
/// <example></example>
/// <exception></exception>
/// <list type=""></list>
/// <param name=""></param>
/// <para></para>
/// <remark></ramark>
/// <returns></returns>
/// <seealso cref=""></seealso>
/// <permission></permission>
/// <summary></summary>
/// <value></value>
```
