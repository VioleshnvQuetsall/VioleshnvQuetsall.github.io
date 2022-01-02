---
layout: post
title: Python 注释解析
description: >
  如何正确使用Python注释
sitemap: false
hide_last_modified: true
categories: [python]
tags: [python]
---

0. this line will be replaced by toc
{:toc}

Python注释可以分为**块注释和行内注释、文档注释、类型注释**

#### 块注释和行内注释

```python
# 块注释一般用于描述下方代码
if a > 10 :
    # 按照PEP8规范，块注释以一个#和一个空格开头，除非块注释中需要使用缩进
    a = 10
else:
    # 块注释应该和它要注释的代码具有同样的缩进
    a *= 2
```

```python
# 行内注释用于注释一行代码
a //= 2             # 很难想象一行代码有什么需要注释的，所以大多数时候它是无用的
b **= 2             # 不要注释这种显而易见的代码
c = {word : annotation for word, annotation in dictionary if len(annotation) > 1}  # 选择具有多个解释的词语
```

块注释和行内注释是最简单、最常见的注释，它们在其他语言中也非常普遍

#### 文档注释

可以用于模块、函数、类、方法的注释，由成对的六个个单引号或双引号组成（**最好用双引号**）

###### 模块

放在文件开头的标识和`import`之间

`module1.py`

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-

"""this is a test module"""

import requests
from lxml import etree
```

其实文档开头的

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
```

也可以算一种注释，不过这种注释不（只）是给人看的，它标识了运行文件的程序和编码

###### 函数

函数文档注释放在`def`的下一行

`module1.py`

```python
# 多行函数文档注释
def max(*args, key=None): # known special case of max
    """
    max(iterable, *[, default=obj, key=func]) -> value
    max(arg1, arg2, *args, *[, key=func]) -> value

    With a single iterable argument, return its biggest item. The
    default keyword-only argument specifies an object to return if
    the provided iterable is empty.
    With two or more arguments, return the largest argument.
    """
    pass

# 单行函数文档注释应该使引号保持在同一行
def foo(a, b):
    """write annotation in one line"""
    # 具有文档注释的函数可以没有函数体
```

一种常见的函数文档注释格式是以冒号开头的几个关键字来说明参数、返回值、异常等

格式为

```shell
[一般性注释]
:<keyword> <name>: <annotation>
:<keyword> <name>: <annotation>
...
:<keyword> <name>: <annotation>
```

```python
from operator import lt
def foo_max(lhs, rhs):
    """
    return bigger item, if equals return left one
    :param lhs: left hand side item
    :param rhs: right hand side item
    :return: bigger item or left item
    """
    return rhs if lt(lhs, rhs) else lhs
```

常用关键字为

- `param`：参数
- `type`：参数类型
- `return`：返回值
- `rtype`：返回值类型
- `except`：异常类型

除此之外还有其他多种格式，可以阅读官方代码或第三方代码学习

###### 类

写在`class`的下一行

`module1.py`

```python
class Foo:
    """Fooooooooooooooo"""
```

###### 获取文档注释

可以通过`__doc__`魔法属性获取文档注释

```python
# 之前写的函数和类都在module1.py模块中
import module1
print(module1.__doc__)
print(module1.foo_max.__doc__)
print(Foo.__doc__)
```

类型检查器、IDE、静态检查器等第三方工具也具有获取文档注释的能力


#### 类型注释

Python作为一个动态类型（运行阶段做类型绑定）的语言，不需要提供类型。但如果提供了类型注解可用于类型检查器、IDE、静态检查器等第三方工具

###### 写类型注释

类型注释可以在代码中、函数参数和返回值中书写

```python
from typing import List, Tuple

a: list = [1, 2, 3]

# 参数类型和返回值类型
def foo(a: int = 5) -> int:
    # int是类型，5是默认值（缺省值）
    return a

# 字符串注释
def bar(b: "it's b'") -> "return b itself":
    return b

# 复杂类型的注释
def baz(c: List[Tuple, ...]):
    return c
```

其实冒号`:`后还可以写其他的，比如数字、函数，不过最常用的是类型注释和字符串注释

甚至可以调用函数

```python
def qux(d: print(4 if 5 > 8 else 7)):
    return d
```

如同在正常代码中使用，不过这种写法不应该出现在实际使用过程中

> 根据PEP8规范，类型注释应该具有如下的空格
>
> ```python
> # Yes:
> def munge(input: AnyStr): pass
> def munge() -> AnyStr: pass
> 
> # No:
> def munge(input:AnyStr): pass
> def munge()->PosInt: pass
> ```

###### 获取类型注释

通过`__annotations__`魔法属性获取，只能对函数使用

```python
print(foo.__annotations__)
print(bar.__annotations__)
print(baz.__annotations__)
# display: 
# {'a': <class 'int'>, 'return': <class 'int'>}
# {'b': "it's b'", 'return': 'return b itself'}
# {'c': typing.List[typing.Tuple]}
```

###### 使用`typing`模块

`typing`模块（和`collections.abc`模块）可以帮助我们写出更好的类型注释，其实官方文档已经写的很清楚了，这里只提供常用的几种

```python
from typing import Any, List, Tuple, Iterator, NoReturn, Literal

# 最普通的使用
def foo(a: Any) -> NoReturn:
    raise RuntimeError('no way')

# 类型的组合的演示，可以延伸到其他类型
# 空元组
Tuple[()]
# 单元素元组
Tuple[int]
# 双元素列表
List[int, str]
# 变长同质元组
Tuple[int, ...]
# 更复杂的
Tuple[Union[Tuple[int, str], List[int, str]], ...]

# Union 多选一
def foo(arg: Union[int, str]) -> NoReturn:
    pass

# Optional 可选，有默认值
def foo(arg: Optional[int] = None) -> NoReturn:
    pass

# Literal 多选一
def foo(arg: Literal[1, 2, 3]) -> NoReture:
    pass
 
# Callable 可调用
# Iterator 生成器
```

同样，在PyCharm中类型注释可以被感知。


官方文档还提供了各种其他类型注释

[`typing` --- 类型提示支持](https://docs.python.org/zh-cn/3/library/typing.html)
