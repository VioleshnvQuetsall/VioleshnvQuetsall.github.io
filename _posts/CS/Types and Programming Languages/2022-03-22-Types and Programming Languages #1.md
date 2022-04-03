---
layout: post
title: 类型系统与程序语言——无类型系统
description: >
  Types and Programming Languages 导引章节记录
sitemap: false
hide_last_modified: true
categories: [cs]
tags: [Types and Programming Languages]
---

0. this line will be replaced by the toc
{:toc}

## 无类型系统

本节为其他章节作引。

### 无类型算数表达式

一门语言需要语法、语义、语用来构成。现在以无类型算数表达式这个非常简单的语言开始探讨，我们将明确它的语法和语义来充分了解这门语言。

#### 语法

无类型算数表达式语言的语法中只包含 $$true, false, 0, \operatorname{succ}, \operatorname{pred}, \operatorname{iszero}$$ 和条件表达式，通过堆砌这些语法就完成了这门语言的“代码”。

我们将这门语言中的成分称为 **term**，一个语言的所有内容就是所有 term 的集合，在这门语言中 term 的集合是具有如下性质的**最小**的 $$\mathcal T$$，如下：

$$
\begin{align*}
\{ true, false, 0 \} &\subseteq \mathcal T, \\
\text{if } t_1 \in \mathcal T, \text{ then } \{ \operatorname{succ} t_1, \operatorname{pred} t_1, \operatorname{iszero} t_1 \} &\subseteq \mathcal T, \\
\text{if } t_1, t_2, t_3 \in \mathcal T, \text{ then } if\ t_1\ then\ t_2\ else\ t_3 &\subseteq \mathcal T.
\end{align*}
$$

或者使用推理规则定义如下：

$$
\begin{align*}
\hline \lbrace true, false, 0 \rbrace \subseteq \mathcal T \\[2em]\\
t_1 \in \mathcal T \\\hline
\lbrace \operatorname{succ}t_1, \operatorname{pred} t_1, \operatorname{iszero}t_1 \rbrace \subseteq \mathcal T
\\[2em]\\
t_1, t_2, t_3 \in \mathcal T \\\hline
\text{if $t_1$ then $t_2$ else $t_3$} \in \mathcal T
\end{align*}
$$

---

也可以使用集合的方法定义，先定义集合 $$\mathcal S_i$$ 和 $$\mathcal S$$
$$
\begin{align*}
\mathcal S_0 &= \varnothing, \\
\mathcal S_{i+1} &= \{ true, false, 0 \} \\&\cup\ \{ \operatorname{succ} t_1, \operatorname{pred} t_1, \operatorname{iszero} t_1 :t_1 \in \mathcal S_i \} \\&\cup\; \{ \text{if $t_1$ then $t_2$ else $t_3$} : t_1, t_2, t_3 \in \mathcal S_i \}, \\
\mathcal S &= \bigcup_i\mathcal S_i.
\end{align*}
$$

再证明：$$\mathcal T = \mathcal S$$

熟悉命题逻辑的应该能看出这类似于对**全体合式公式的集合**的自底向上的定义，只需证明 $$\mathcal S$$ 符合 $$\mathcal T$$ 的定义，且为最小即可。

先证明前者：

$$
\begin{align*}
\mathcal S_1 &= \lbrace{true, false, 0}\rbrace \subseteq \mathcal S, \\[2em]
\forall t_1 \in \mathcal S,\exists\mathcal S_i(t_1 \in \mathcal S_i) &\implies \forall t_1\in\mathcal S(\operatorname{succ}t_1 \in\mathcal S_{i+1}) \\
&\implies \forall t_1\in\mathcal S(\operatorname{succ}t_1\in\mathcal S), \\[2em]
\text{so as }&\text{pred $t_1$, iszero $t_1$, if $t_1$ then $t_2$ else $t_3$}.
\end{align*}
$$

接下来使用归纳法证明最小，先定义 $$S^\prime$$ 为任意满足 $$\mathcal T$$ 的集合，只需证明 $$\mathcal S_i \subseteq \mathcal S^\prime$$：

$$
\begin{align*}
\forall j < i(\mathcal S_j \subseteq \mathcal S) \implies
\begin{cases}
\mathcal S_i &= \mathcal S_0 = \varnothing \subseteq \mathcal S & i = 0, \\[2em]
\mathcal S_i &= \mathcal S_{\max{j}+1} &i \ne 0 \\&=\{ true, false, 0 \} \\&\cup\,\ \{ \operatorname{succ} t_1, \operatorname{pred} t_1, \operatorname{iszero} t_1 :t_1 \in \mathcal S_{\max{j}} \} \\&\cup\,\ \{ if\ t_1\ then\ t_2\ else\ t_3 : t_1, t_2, t_3 \in \mathcal S_{\max{j}} \}
\\&\subseteq \mathcal S^\prime
\end{cases}
\end{align*}
$$

$$\mathcal S = \bigcup_i\mathcal S_i$$，则 $$\mathcal S \subseteq \mathcal S^\prime$$，由于 $$\mathcal S^\prime$$ 为任意大小的满足 $$\mathcal T$$ 的集合，故 $$\mathcal S$$ 为最小的满足 $$\mathcal T$$ 的集合。

---

其他定义

$$
\begin{array}{ll}
Consts(true) &= \lbrace{true}\rbrace \\
Consts(false) &= \lbrace{false}\rbrace \\
Consts(0) &= \lbrace{0}\rbrace \\
Consts(\operatorname{succ} t_1) &= Consts(t_1) \\
Consts(\operatorname{pred} t_1) &= Consts(t_1) \\
Consts(\operatorname{iszero} t_1) &= Consts(t_1) \\
Consts(\text{if $t_1$ then $t_2$ else $t_3$}) &= Consts(t_1) \cup Consts(t_1) \cup Consts(t_1) \\
\end{array}
$$

$$
\begin{array}{ll}
size(true) &= 1 \\
size(false) &= 1 \\
size(0) &= 1 \\
size(\operatorname{succ} t_1) &= size(t_1) + 1 \\
size(\operatorname{pred} t_1) &= size(t_1) + 1 \\
size(\operatorname{iszero} t_1) &= size(t_1) + 1 \\
size(\text{if $t_1$ then $t_2$ else $t_3$}) &= size(t_1) + size(t_2) + size(t_3) + 1 \\
\end{array}
$$

$$
\begin{array}{ll}
depth(true) &= 1 \\
depth(false) &= 1 \\
depth(0) &= 1 \\
depth(\operatorname{succ} t_1) &= depth(t_1) + 1 \\
depth(\operatorname{pred} t_1) &= depth(t_1) + 1 \\
depth(\operatorname{iszero} t_1) &= depth(t_1) + 1 \\
depth(\text{if $t_1$ then $t_2$ else $t_3$}) &= \max{(depth(t_1) + depth(t_2) + depth(t_3))} + 1 \\
\end{array}
$$

由于 $$\mathcal T$$ 的归纳定义方法，term 的多种性质可以使用归纳法证明。

#### 语义

语义是 terms 如何求值（evaluate）的定义，定义语义有三个基本途径：

- 操作语义（Operational Semantics）

  通过定义 terms 如何工作的一系列操作的语义。比如最常见的替换操作和单步求值操作，这两个操作实际上是对 term 的简化。实际上还有可能有更多操作语义。

  其实就是程序的**执行流程**。

- 指称语义（Denotational Semantics）

  将一些 term 与数学实体关联起来的语义，可以明确程序**行为**。

- 公理语义（Axiomatic Semantics）

  在一套逻辑系统下，研究某种特定的**性质**是否成立的语义。

##### 求值

![Boolean](/assets/img/Types and Programming Languages.assets/image-20220403091138831.png)

![Arithmetic Expressions](/assets/img/Types and Programming Languages.assets/image-20220403091234091.png)

图片显示了无类型表达式中的两种成分：Boolean 和自然数的运算。左侧为语法，展示了语言的所有成员，包括 term 和 value，term 和 value 的区别就是 value 是不可再求值的，term 包含 value；右侧为语义，其实也就是一系列推演规则，展示如何在各种前提（或无需前提）下做到 $$t\to t'$$，“$$\to$$” 是一个非常关键的算符，称为“单步求值”，将 term 逐步计算为 value。

比如下面的运算就将复杂的 term 多步求值为了一个 value —— false。

$$
\begin{align*}
& \text{if false then true else (if false then false else false)} \\\hline
& \text{if false then false else false} \\\hline
& \text{false}
\end{align*}
$$

同时定理【单步求值的确定性】：$$\text{if $t\to t'$ and $t\to t''$, then $t'=t''$}$$ 指出，单步求值规则之间不可能冲突，一个 term 在某一时刻要么只适用一条规则，要么不适用任何规则。

---

由于可能出现如 $$\operatorname{succ}false$$ 这样不适用任何规则且不是 value 的存在，这种情况称为 stuck，这是一种在语法层面允许出现的**运行时错误**。

### 无类型 Lambda 表达式

Lambda 演算是一种形式化系统，在该系统中所有计算都被归约为函数的定义（definition）和应用（application）上的各种操作。如果说无类型算数表达式是过程式语言，那么无类型 Lambda 表达式就是函数式语言了。

![Untyped Lambda-Calculus](/assets/img/Types and Programming Languages.assets/image-20220403104450989.png)

#### 语法

$$
\begin{align*}
t::=&& terms: \\
    &\ x & variable \\
    &\ \lambda x.t & abstraction \\
    &\ t\ t & application \\
\end{align*}
$$

上述**语法**表示，该语言中的最小组成单元 term 包括三种类型，左边为这三种类型的形式，右边为这三种形式的名称。

采用集合的定义为，$$\mathcal T$$ 为 term 的集合，$$\mathcal V$$ 为变量的集合

$$
\begin{array}{l}
x \in \mathcal T \text{ for every } x \in \mathcal V \\
\text{if $t_1\in\mathcal T$ and $x\in\mathcal V$, then $\lambda x.t_1 \in\mathcal T$} \\
\text{if $t_1\in\mathcal T$ and $t_2\in\mathcal T$, then $t_1\ t_2\in\mathcal T$ }
\end{array}
$$


#### Lambda 演算的作用域和操作语义

Lambda 演算中最重要的就是关于函数的描述，即 $$\lambda x.t$$ 或更多参数的函数 $$\lambda x.\lambda y.t$$。

用 Python 语言做类比可以理解为 `lambda x: t` 和 `lambda x, y: t`，在函数中，$$.$$ 表示参数定义的结束，$$\lambda$$ 代表函数定义的开始，$$t$$ 可以是任意一个 term。

像很多语言一样，这个演算中的函数也有变量的作用域，依作用于不同分为**约束变量**和**自由变量**，比如 $$(\lambda x.x)\ x$$ 中括号中的 $$x$$ 和括号外 $$x$$ 是不同的变量。

自由变量的集合也可以被定义为：

$$
\begin{array}{ll}
FV(x) &= \lbrace{x}\rbrace \\
FV(\lambda x.t_1) &= FV(t_1) \backslash\lbrace{x}\rbrace \\
FV(t_1\ t_2) &= FV(t_1)\ \cup\ FV(t_2) 
\end{array}
$$

对函数的应用只是简单地将*函数体*中的 term 中的参数进行替换，表示为$$(\lambda x.t_1)\ t_2 \to [x \mapsto t_2] t_1$$，比如

$$
\begin{align*}
(\lambda x.x)\ y &\to [x \mapsto y](x) \to y \\
(\lambda x.\lambda y.x\ y)\ z &\to [x \mapsto z](\lambda y.x\ y) \to \lambda y.z\ y
\end{align*}
$$

更严谨的定义为

$$
\begin{array}{llll}
[x\mapsto s]x &=& s & \\
[x\mapsto s]y &=& y & \text{if } y \ne x \\
[x\mapsto s]\lambda y.t_1 &=& \lambda y.[x\mapsto s]t_1 & \text{if $y\ne x$ and $y\notin FV(s)$}\\
[x\mapsto s](t_1\ t_2) &=& [x\mapsto s]t_1\ [x\mapsto s]t_2 & \\
\end{array}
$$

### Lambda 演算编程

#### 布尔运算

可以使用 Lambda 表达式作一些有趣的编程，首先我们定义编程中最基础的一种运算——boolean。

由于在 Lambda 演算中，一切皆函数，所以 $$true, false$$ 也是一种函数，其定义为

$$
\begin{align*}
\operatorname{true} &= \lambda t.\lambda f.t \\
\operatorname{false} &= \lambda t.\lambda f.f \\
\end{align*}
$$

可以看到，这一运算仅仅是选择两个参数中的一个，这一行为本身没有什么用处，需要与其配套的布尔运算

$$
\begin{align*}
\operatorname{not} &= \lambda a.a\ \operatorname{false}\ \operatorname{true} \\
\operatorname{and} &= \lambda b.\lambda c.b\ c\ \operatorname{false} \\
\operatorname{or} &= \lambda b.\lambda c.b\ \operatorname{true}\ c \\
\end{align*}
$$

尝试将 $$a,b,c$$ 用 $$\operatorname{true}, \operatorname{false}$$ 替换可以得到对应的结果。

#### 序偶

Lambda 演算不仅可以定义运算，还可以定义结构，下面介绍一种最基础的数据结构——序偶。

$$
\begin{align*}
\operatorname{pair} &= \lambda f.\lambda s.\lambda b.b\ f\ s \\
\operatorname{first} &= \lambda p.p\ \operatorname{true} \\
\operatorname{second} &= \lambda p.p\ \operatorname{false}
\end{align*}
$$

$$
\begin{align*}
&\ \operatorname{first}\ (\operatorname{pair}\ v\ w) \\
=&\ \operatorname{first}\ ((\lambda f.\lambda s.\lambda b.b\ f\ s)\ v\ w) \\
\to&\ \operatorname{first}\ (\lambda b.b\ v\ w) \\
=&\ (\lambda p.p\ \operatorname{true})\ (\lambda b.b\ v\ w) \\
\to&\ (\lambda b.b\ v\ w) \operatorname{true} \\
\to&\ \operatorname{true}\ v\ w \\
\to&\ v
\end{align*}
$$

虽然序偶这一结构非常简单，但是实际上可以用不断的序偶来定义元组和数组。一个例子就是 C++ 中的元组就是由序偶的模版组合成的。

#### 自然数

由**皮亚诺公里**，将数定义为对某函数的重复后继运算，可以得到自然数的 Lambda 演算

$$
\begin{align*}
0 &= \lambda f.\lambda x.x \\
1 &= \lambda f.\lambda x.f\ x \\
2 &= \lambda f.\lambda x.f\ (f\ x) \\
3 &= \lambda f.\lambda x.f\ (f\ (f\ x)) \\
\vdots \\
n &= \lambda f.\lambda x.f^{\circ n}\ x \\
\end{align*}
$$

现在有了数，还需要定义数之间的运算，依次定义后继，加法，乘法，前驱，减法

$$
\begin{align*}
\operatorname{succ} &= \lambda n.\lambda f.\lambda x.f\ (n\ f\ x) \\
+ &= \lambda m.\lambda n.\lambda f.\lambda x.m\ \operatorname{succ}\ n \\
  &= \lambda m.\lambda n.\lambda f.\lambda x.m\ f\ (n\ f\ x) \\
\times &= \lambda m.\lambda n.m\ (+\ n)\ 0
\end{align*}
$$

不要忘记数就是对某个函数的重复应用，所以后继是某个函数再一次应用，加法是后继的重复应用，乘法是加法的重复应用。

接下来定义前驱，这一操作需要用到序偶，先将其思想用 Python 表示为

~~~python
def pred(n: int) -> int:
    pair = (0, 0)
    for _ in range(n):
        pair = (pair[1], pair[1] + 1)
    return pair[0]
~~~

$$
\begin{align*}
\operatorname{initialize} &= \operatorname{pair}\ 0\ 0 \\
\operatorname{increase} &= \lambda p.\operatorname{pair}\ {\operatorname{second}\ p}\ (+\ 1\ (\operatorname{second}\ p)) \\
\operatorname{pred} &= \lambda m.\operatorname{first}\ (m\ \operatorname{increase}\ \operatorname{initialize}) \\
- &= \lambda m.\lambda n.\lambda f.\lambda x.m\ \operatorname{pred}\ n \\
\end{align*}
$$

除法在这里就不列出具体实现了，只列出其思想：也需要一个序偶，一个数记录减法次数，另一个数记录被减数，多次减法后取减法次数即可。

#### 拓展

##### 递归

若一个函数具有如下形式，其中 $$a,b,c,d$$ 为任意函数，$$p$$ 为谓词

$$
f(x) =
\begin{cases}
a(x) & \text{if } p(x) \\[2em]
b(f(c(x))) + d(x) & \text{else}
\end{cases}
$$

其 Lambda 演算形式为

$$
\begin{align*}
fix &= \lambda f.(\lambda x.f\ (\lambda y.x\ x\ y))\ (\lambda x.f\ (\lambda y.x\ x\ y)) \\
f\text{-}helper &= \lambda f.\lambda x. (p\ x )\ (a\ x)\ (+\ (b\ (f\ (c\ x)))\ (d\ x)) \\
f &= fix\ f\text{-}helper
\end{align*}
$$

$$fix, f\text{-}helper$$ 都接受一个函数作为参数，$$f\text{-}helper$$ 其实就是 $$f$$ 的函数行为，而 $$fix\ f\text{-}helper$$ 为 $$f$$ 的展开形式。

$$
\begin{align*}
\text{let } f_h =&\ f\text{-}helper \\
f_f =&\ (p\ x )\ (a\ x)\ (+\ (b\ (f\ (c\ x)))\ (d\ x)) \\
rec =&\ \lambda x.f_h\ (\lambda y.x\ x\ y) \\
\text{then } f
=&\ fix\ f_h \\
=&\ rec\ rec \\
=&\ f_h\ (\lambda y.rec\ rec\ y) \\
=&\ (\lambda f.\lambda x. f_f)\ (\lambda y.rec\ rec\ y) \\
\to&\ \lambda x.[f \mapsto (\lambda y.rec\ rec\ y)] f_f \\
=&\ \lambda x.[f \mapsto (\lambda y.f\ y)] f_f
\end{align*}
$$

要注意 $$[]$$ 内的两个 $$f$$ 含义不同，左边的为 $$f_f$$ 中的 $$f$$，右边的为我们要求的递归函数 $$f$$。

最后的结果表明：$$f_f$$ 内的 $$f$$ 是对 $$(\lambda y.f\ y)$$ 的再一次应用，其中的 $$y$$ 其实在 $$f_f$$ 中会被 $$c(x)$$ 替换。由于 $$\lambda y.f\ y \leftrightarrow \lambda y.rec\ rec\ y$$，所以在 $$f$$ 的展开中并没有再次出现 $$f$$，这只是计算上的等价替换，并不是在函数体中再次调用了 $$f$$。
