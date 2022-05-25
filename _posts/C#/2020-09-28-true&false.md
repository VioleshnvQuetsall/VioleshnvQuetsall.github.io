---
title: C#中 `true` 和 `false` 运算符的使用
description: >
  学习C#时所做的笔记
sitemap: false
hide_last_modified: true
categories: [c#]
tags: [c#]
---

0. this line will be replaced by toc
{:toc}

### C#中的`true`和`false`运算符

##### 基础用法

我们先定义一个示例用的类

```csharp
public class BoolTest
{
    public int X { get; set; }
    public BoolTest(int x) { X = x; }
    public static bool operator true(BoolTest test)
    {
        Console.WriteLine("call op_true");
        return test.X > 0;
    }
    public static bool operator false(BoolTest test)
    {
        Console.WriteLine("call op_false");
        return test.X < 0;
    }
}
```

定义了`true`和`false`运算符后，类可以在可以用于`if`、`do`、`while`和`for`语句以及条件表达式中的控制表达式。

```csharp
if (new BoolTest(1))
    ; // 会有空语句警告，请忽视
if (new BoolTest(-1))
    ;
// output:
// call op_true
// call op_true
```

可以看到，我们只调用了`true`运算符，那么`false`运算符用在哪里呢

##### 定义`||`和`&&`运算符

更确切地说，`false`运算符是用于定义`||`运算符的

在此之前，我默认你已经知道**逻辑运算符的短路运算**

C#不能直接定义`||`和`&&`运算符，而是通过定义`|`和`true`来获得`||`，定义`&`和`false`来得到`&&`，其原因就是为了支持短路运算。

现在更新我们的类

```csharp
public class BoolTest
{
    public int X { get; set; }
    public BoolTest(int x) { X = x; }

    public static bool operator true(BoolTest test)
    {
        Console.WriteLine("call op_true");
        return test.X > 0;
    }
    public static bool operator false(BoolTest test)
    {
        Console.WriteLine("call op_false");
        return test.X < 0;
    }

    public static BoolTest operator |(BoolTest left, BoolTest right)
    {
        return new BoolTest(Math.Max(left.X, right.X));
    }
    public static BoolTest operator &(BoolTest left, BoolTest right)
    {
        return new BoolTest(Math.Min(left.X, right.X));
    }
    // 这两个运算符必须返回BoolTest类型（准确的说是返回和参数相同的类型）
}
```

```csharp
BoolTest p = new BoolTest(1);
BoolTest n = new BoolTest(-1);

if (p || n)
    WriteLine("p || n");
    /*
    call op_true
    call op_true 调用了两次true()
    p || n
    */
if (p && n)
    WriteLine("p && b");
    /*
    call op_false 使用了false()来作短路判断
    call op_true 此时p是True，调用&()生成新的BoolTest，再对新的BoolTest调用true()
    */
if (n || p)
    WriteLine("n || p");
    /*
    call op_true 对n
    call op_true 对(n | p)
    n || p
    */
if (n && p)
    WriteLine("n && p");
    /*
    call op_false 对n
    call op_true 对n
    */
```

结论就是
`a || b`等价于`operator_true(operator_true(a) ? a : (a | b))`
`a && b`等价于`operator_true(operator_false(a) ? a : (a & b))`

> 注意：**最终的真或假还是交由`true`运算符判断**，`false`运算符只在短路中用到

##### 附

`true`和`false`运算符还用于支持三元逻辑值*(True, False, Null)*，不过现在有`bool?`类型了

这个链接是三元逻辑值的示例类 [struct DBBool](http://shouce.jb51.net/net/html/acaba817-5da5-4364-b3b2-2e5c75ec1839.htm)