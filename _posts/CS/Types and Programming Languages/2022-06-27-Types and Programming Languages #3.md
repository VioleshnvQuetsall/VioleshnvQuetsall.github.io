---
title: 类型系统与程序语言——子类型和递归类型
description: >
  Types and Programming Languages 导引章节记录
sitemap: false
hide_last_modified: true
categories: [cs]
tags: [Types and Programming Languages]
---

0. this line will be replaced by the toc
{:toc}

# 子类型和递归类型

## 子类型 Subtyping

### 定义

如果没有子类型，那么 $$(\lambda r:\lbrace x:Nat\rbrace.\ r.x)\ \lbrace x=0,y=1\rbrace$$ 在语法上是无法判断出类型的，因为形参和实参的类型不匹配。为此，添加子类型的语法。

$$S<:T$$ 表示任何类型为 $$S$$ 的值类型也可以是 $$T$$，即 $$S$$ 的元素集合是 $$T$$ 的元素集合的子集，类型 $$S$$ 是类型 $$T$$ 的子类。

添加一个超类 $$Top$$ 和子类型的相关语法（自反性、传递性等）。

![Simply typed lambda-calculus with subtyping](/assets/img/Types and Programming Language.assets/image-20220424105105070.png)

添加记录（Record）的额外规则。

![Records](/assets/img/Types and Programming Language.assets/image-20220424105704730.png)

![Records and subtyping](/assets/img/Types and Programming Language.assets/image-20220424105737576.png)

### 性质

因为添加了新的规则，需要重新论证类型安全性。即 Safety = Progress + Preservation。

证明过程与没有子类型的有类型 Lambda 表达式类似，但是多出来几个情况。

对于 Preservation，请考虑每个 evaluation rule 和对应的 typing rule。

对于 Progress，请考虑每个 term 的形式以及对应的 evaluation rule。

事实上，terms，evaluation rules，typing rules 的关系非常紧密。

### Top 类型和 Bot 类型

在子类型系统中添加 Top 类型和 Bot 类型分别作为所有类型的父类和子类。Bot 类型没有任何成员。Top 类型在实际语言中比较常见，但 Bot 类型将需要在未来得到更充分的叙述。

![Bottom type](/assets/img/Types and Programming Language.assets/image-20220424122147422.png)

### 其他特性

#### 类型转换

![Casting](/assets/img/Types and Programming Language.assets/image-20220424140201604.png)

在子类型系统中，类型注解（ascription）升级为类型转换（casting），分为类型上升（up-casting）和类型下降（down-casting）。其中类型上升是将子类元素委派为父类，类型下降反之。

类型上升没有什么不同，而类型下降允许将类型检查器无法静态推理出来的类型指派给表达式，但有破坏语言安全性的风险。

错误的类型转换，会造成无法预料的结果。采取在静态类型检查中相信程序员的类型指派，而在动态程序运行时检验类型的措施，可能需要两套类型系统。

#### 变体 Variants

![Variants and subtyping](/assets/img/Types and Programming Language.assets/image-20220424135903666.png)

#### 链表  

![Lists with subtyping](/assets/img/Types and Programming Language.assets/image-20220424140134804.png)

#### 引用

![References with subtyping](/assets/img/Types and Programming Language.assets/image-20220424140231738.png)

需要 $$Ref\ T_1$$ 的场景对 $$Ref\ S_1$$ 也适用。引用有赋值和解引用两个操作，其中赋值（$$Ref\ T_1:=$$）需要 $$T_1<:S_1$$，解引用（$$!(Ref\ T_1)$$）需要 $$S_1<:T_1$$。

一个实例是 $$\lbrace a:Bool,b:Nat\rbrace,\lbrace b:Nat,a:Bool\rbrace$$。

#### 数组

数组是一串引用

![Array](/assets/img/Types and Programming Language.assets/image-20220424141846419.png)

#### 交类型和并类型

![Intersection types](/assets/img/Types and Programming Language.assets/image-20220424142340788.png)

这表明，如果有函数是 $$S\to T_1$$ 和 $$S\to T_2$$ 的交类型，那么传入 $$S$$ 类型作为参数，得到的类型是 $$T_1$$ 和 $$T_2$$ 的交类型。可以当做**函数重载**。

同理有并类型 $$T_1\vee T_2$$，一个参数为并类型的函数必须对两个类型都有效。

### 算法式定义

虽然已经定义了关于子类型系统的一系列规则，但是这些规则还无法被直接实现，原因在于这些规则还有一些小漏洞。

比如：$$T\text-S\scriptsize UB$$ 和 $$T\text-S\scriptsize ABS$$ 可能会有冲突，完全可能出现一种情况使得这两个规则同时适用；还有 $$S\text-T\scriptsize RANS$$ 中出现了 $$U$$，不知道怎么得到这个 $$U$$。

我们将更新规则，因为这些规则将被用于类型检查算法，称为算法子类型。

如果通过算法能得出 $$S$$ 是 $$T$$ 的子类型，则表示为 $$\mapsto S<:T$$。

#### 算法子类型（algorithmic subtyping）

我们首先将 $$S\text-R\scriptsize CD\normalsize W\scriptsize IDTH$$、$$S\text-R\scriptsize CD\normalsize D\scriptsize EPTH$$、$$S\text-R\scriptsize CD\normalsize P\scriptsize ERM$$ 合为一个规则 $$S\text-R\scriptsize CD$$。并删去了两个（不必要的）规则。

![Algorithmic subtyping](/assets/img/Types and Programming Language.assets/image-20220424210352738.png)

可以证明这些规则是安全且完备的（soundness and completeness）：$$S<:T\iff\vert\!\!\!\rightarrow S<:T$$ 

再给出一个算法，该算法是有穷的（termination）。

![subtype](/assets/img/Types and Programming Language.assets/image-20220424212509179.png)

### 算法类型（algorithmic typing）

![Algorithmic typing](/assets/img/Types and Programming Language.assets/image-20220424213424464.png)

通过改写规则的应用情况，使类型检查成为可能。

同样有安全性和完备性，表明算法类型关系和前述的类型关系是一致的：

- $$\text{if }\Gamma\mapsto t:T,\text{ then }\Gamma\vdash t:T$$
- $$\text{if }\Gamma\vdash t:T,\text{ then }\Gamma\mapsto t:S,\text{ for some }S<:T$$

证明需要对照两种类型关系的叙述，并归纳证明。

## 递归类型 Recursive Types

用变体类型表示的一个链表 $$NatList=\langle nil:Unit,cons:\lbrace Nat,NatList\rbrace\rangle$$。

![NatList](/assets/img/Types and Programming Language.assets/image-20220424144807994.png)

为了将类型名单独放在左侧，递归过程放在右侧，现在引入递归符号 $$\mu$$，$$NatList=\mu X.\langle nil:Unit,cons:\lbrace Nat,X\rbrace\rangle$$与上述定义同义。其中 $$\mu X$$ 表示 $$X$$ 满足 $$X=\langle nil:Unit,cons:\lbrace Nat,X\rbrace\rangle$$ 这一无限递归。

### 递归类型举例

$$
\begin{array}{rll}
&Hungry &=& \mu A.Nat\to A \\
&f &=& fix\ (\lambda f:Nat\to Hungry.\lambda n.Nat.f) \\
\blacktriangleright &f&:&Hungry \\
& f\ 0\ 1\ 2\ 3\ 4\ 5 \\
\blacktriangleright &\langle fun\rangle&:&Hungry
\end{array}
$$

$$
\begin{array}{rll}
&Stream &=& \mu A.Unit\to\lbrace Nat,A\rbrace \\
&hd &=& \lambda s:Stream.(s\ unit).1 \\
\blacktriangleright &hd&:& Stream\to Nat \\
&tl &=& \lambda s:Stream.(s\ unit).2 \\
\blacktriangleright &tl&:& Stream\to Stream \\
&upfrom0 &=& fix\ (\lambda f:Nat\to Stream.\lambda n:Nat.\lambda\_:Unit. \\
&&&\qquad\lbrace n,f\ (succ\ n)\rbrace \\
&&&)\ 0 \\
\blacktriangleright &upfrom0&:& Stream \\
&hd\ &&(tl\ (tl\ (tl\ upfrom0))) \\
\blacktriangleright &3&:& Nat \\
&fib&:&fix\ (\lambda f:Nat\to Nat\to Stream.\lambda m:Nat.\lambda n:Nat.\lambda\_:Unit. \\
&&&\qquad\lbrace n,f\ n\ (+\ m\ n)\rbrace \\
&&&)\ 0\ 1 \\
\blacktriangleright &fib&:& Stream \\
\end{array}
$$

$$
\begin{array}{rll}
&Process &=& \mu A.Nat\to\lbrace Nat,A\rbrace \\
&curr&=& \lambda s:Process.(s\ 0).1 \\
\blacktriangleright &curr&:& Process\to Nat \\
&send &=& \lambda n:Nat.\lambda s:Stream.(s\ n).2 \\
\blacktriangleright &send&:& Nat\to Stream\to Stream \\
&p &=& fix\ (\lambda f:Nat\to Process.\lambda a:Nat.\lambda n:Nat. \\
&&&\qquad\text{let $na=+\ a\ n$ in} \\
&&&\qquad\lbrace na,f\ na\rbrace \\
&&&)\ 0 \\
\blacktriangleright &p&:& Process \\
&curr\ &&(send\ 20\ (send\ 3\ (send\ 5\ p))) \\
\blacktriangleright &28&:& Nat \\
\end{array}
$$

### 形式化定义

添加一对函数
$$
\begin{array}{lll}
unfold[\mu X.T] &:& \mu X.T\to[X\mapsto\mu X.T]T \\
fold[\mu X.T] &:& [X\mapsto\mu X.T]T\to\mu X.T \\
\end{array}
$$
![isomorphism](/assets/img/Types and Programming Language.assets/image-20220424154912202.png)

它们的结果是一个关于类型的函数，可以将递归类型的展开形式和折叠形式作转换。

![Iso-recursive types](/assets/img/Types and Programming Language.assets/image-20220424153629180.png)

### 元理论

现有全集 $$\mathcal U$$，称函数 $$F\in\mathcal P(\mathcal U)\to P(\mathcal U)$$ 为一致（monotone）的，如果 $$X\subseteq Y\implies F(X)\subseteq F(Y)$$。（$$\mathcal P(\mathcal U)$$ 是 $$\mathcal U$$ 所有子集的集合）

给出三个定义，$$X$$ 是 $$\mathcal U$$ 的子集：

1. $$X$$ is *F-closed* if $$F(X)\subseteq X$$
2. $$X$$ is *F-consistent* if $$X\subseteq F(X)$$
3. $$X$$ is a *fixed point* if $$F(X)=X$$

用推理规则表示函数的输入集合和输出集合，比如函数 $$E_1$$

![E1 function](/assets/img/Types and Programming Language.assets/image-20220424221512176.png)

![E1 function inference rules](/assets/img/Types and Programming Language.assets/image-20220424221530847.png)

命题：*F-closed* 的集合的交集是 $$F$$ 的最小的 *fixed point*；*F-consistent* 的集合的并集是 $$F$$ 的最大的 *fixed point*。

$$F$$ 的最小的 *fixed point* 写作 $$\mu F$$，$$F$$ 的最大的 *fixed point* 写作 $$\nu F$$。

## 多态

如果一个类型系统允许一段代码被不同的类型使用，那么这种类型系统被称为多态系统。

### 类型重构

前面的类型检查方法需要为每个 term 指定具体的类型。类型重构可以推断出一个大致的类型。

1. 声明一个从类型变量到类型的映射 $$\sigma$$
2. 应用这个映射于一个具体类 $$T$$ 得到 $$\sigma T$$

$$
\begin{align*}
\sigma(X) &= \begin{cases}
T & \text{if } (X\mapsto T)\in\sigma \\
X & \text{if $X$ is not in the domain of }\sigma
\end{cases} \\[0.2em]
\sigma(Nat) &= Nat \\[0.2em]
\sigma(Bool) &= Bool \\[0.2em]
\sigma(T_1\to T_2) &= \sigma T_1\to\sigma T_2 \\[0.2em]
\sigma(x_1:T_1,\dots,x_n:T_n) &= (x_1:\sigma T_1,\dots,x_n:\sigma T_n) \\[0.2em]
\sigma\circ\gamma &= \left[\begin{array}{ll}
X\mapsto\sigma(T) & \text{for each }(X\mapsto T)\in\gamma \\
X\mapsto T & \text{for each }(X\mapsto T)\in\sigma\text{ with }X\notin dom(\gamma) \\
\end{array}\right]
\end{align*}
$$

类型重构方法可以找到类型，不必显式写出

定义：令 $$\Gamma$$ 为一个上下文，$$t$$ 为一个 term，$$(\Gamma,t)$$ 的一个解是满足 $$\sigma\Gamma\vdash\sigma t:T$$ 的序偶 $$(\sigma,T)$$。

### 类型的约束求解

定义 $$C$$ 作为类型约束的集合，$$\Gamma\vdash t:T\mid_{\mathcal X}C$$ 表示如果 $$C$$ 被满足，则 $$t$$ 在上下文 $$\Gamma$$ 中具有类型 $$T$$，$$\mathcal X$$ 用来记录类型变量。

![Constraint typing rules](/assets/img/Types and Programming Language.assets/image-20220424235051777.png)

![Unification algorithm](/assets/img/Types and Programming Language.assets/image-20220425000654597.png)

### 多态 Lambda 表达式

将类型作为参数，得到多态 Lambda 表达式。类似 C++ 里的模版。

![Polymorphic lambda-calculus](/assets/img/Types and Programming Language.assets/image-20220425001052973.png)

$$
\begin{align*}
sort &= \lambda X.\lambda f:X\to X\to Bool. \\
     &\qquad fix\ (\lambda m:List\ X\to List\ X.\lambda l:List\ X \\
     &\qquad\qquad \text{if } isnil[X]\ l \\
     &\qquad\qquad \text{then } l \\
     &\qquad\qquad \text{else let } insert=fix\ (\lambda n:List\ X\to X\to List\ X.\lambda k:List\ X.\lambda e:X. \\
     &\qquad\qquad\qquad\qquad\qquad\qquad\quad\ \ \text{let } h=head[X]\ k,t=tail[X]\ k \text{ in}\\
     &\qquad\qquad\qquad\qquad\qquad\qquad\quad\ \ \text{if } isnil[X]\ k\text{ then } cons[X]\ nil[X]\ e \\
     &\qquad\qquad\qquad\qquad\qquad\qquad\quad\ \ \text{else if }f\ h\ e\text{ then }cons[X]\ h\ (n\ t\ e) \\
     &\qquad\qquad\qquad\qquad\qquad\qquad\quad\ \ \text{else }cons[X]\ e\ k) \\
     &\qquad\qquad\qquad\text{ in }insert\ (m\ (tail[X]\ l))\ (head[X]\ l) \\
     &\qquad)
\end{align*}
$$



