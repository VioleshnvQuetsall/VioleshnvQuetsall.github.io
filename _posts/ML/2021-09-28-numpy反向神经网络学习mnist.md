---
title: 用numpy实现最简单的前馈神经网络——反向网络建立篇
description: >
  反向网络建立
sitemap: false
hide_last_modified: true
categories: [ml]
tags: [numpy, NN]
related_posts:
  - _posts/ML/2021-09-28-numpy简单神经网络学习mnist.md
  - _posts/ML/2021-09-28-numpy简单神经网络.md
  - _posts/ML/2022-01-01-卷积层和池化层的实现.md
---

0. this line will be replaced by toc
{:toc}

在[前一篇文章]({% post_url /ML/2021-09-28-numpy简单神经网络学习mnist %})中，已经初略的建立了前向神经网络，但是前向神经网络大量的前馈计算使其只有较低的速度，因此我们来建立反向神经网络。

**本篇主要是公式**

{:toc}

## 链式法则

在学习偏导数的反向传递之前，需要有对**链式法则**有一定的了解

$$
\begin{align}
\text{provide that }&y = y(x) \text{ and } z = z(y), \\
\text{then }& z'(x) = \frac{ {\rm d} z}{ {\rm d}x} = \frac{ {\rm d}z}{ {\rm d}y} \frac{ {\rm d}y}{ {\rm d}x} = z'(y) \cdot y'(x).
\end{align}
$$

$$
\begin{align}
\text{provide that }&u = u(x,y),v = v(x,y),w = w(u,v), \\
\text{then }& w'(x) = \frac{\partial w}{\partial u} \frac{\partial u}{\partial x} + \frac{\partial w}{\partial v} \frac{\partial v}{\partial  x} = w'(u) \cdot u'(x) + w'(v) \cdot v'(x), \\
&w'(y) = \frac{\partial w}{\partial u} \frac{\partial u}{\partial y} + \frac{\partial w}{\partial v} \frac{\partial v}{\partial  y} = w'(u) \cdot u'(y) + w'(v) \cdot v'(y). \\
\end{align}
$$

对于前馈神经网络来说，链式法则可以这么用

$$
B_1 = F_1(A_1,A_2,A_3), \\
B_2 = F_2(A_1,A_2,A_3), \\
B_3 = F_3(A_1,A_2,A_3), \\
B_4 = F_4(A_1,A_2,A_3). \\
$$

这里的 $$F_i$$ 可以是矩阵函数，可以是激活函数等等，也可以是它们的混合

取 $$L$$ 为损失函数那么自然就有

$$
\begin{align}
L'(A_1) &= \frac{\partial L}{\partial B_1} \frac{\partial B_1}{\partial A_1} + \frac{\partial L}{\partial B_2} \frac{\partial B_2}{\partial A_1} + \frac{\partial L}{\partial B_3} \frac{\partial B_3}{\partial A_1} + \frac{\partial L}{\partial B_4} \frac{\partial B_4}{\partial A_1} \\
&= L'(B_1) \frac{\partial F_1}{\partial A_1} + L'(B_2) \frac{\partial F_2}{\partial A_1} + L'(B_3) \frac{\partial F_3}{\partial A_1} + L'(B_4) \frac{\partial F_4}{\partial A_1}.
\end{align}
$$

这行公式的意思就是：**如果已知后一层神经网络对损失函数的偏导数，那么就能通过后一层的神经网络和前一层的神经网络的关系算出前一层神经网络对损失函数的偏导数**

当然这也只是经过化简后的情况，实际情况是**我们要求的不是损失函数对节点值的偏导数，而是损失函数对权重和偏置的偏导数**，不过损失函数对节点值的偏导数可以帮助我们求出对权重和偏置的偏导数。

## 利用节点值偏导数求权重偏导数和偏置偏导数

现在仍然只考察两层神经网络

定义 $$L'(Z_i)$$ 为对节点值的偏导数，取 $$\alpha$$ 为激活函数，$$w_{ij}$$ 为前一层第 $$i$$ 个节点对后一层第 $$j$$ 个节点的权重，$$b_j$$ 为后一层第 $$j$$ 个的权重

$$
Z_{B_j} = \sum_i w_{ij}A_i + b_j, \\
B_i = \alpha(Z_{B_i}), \\
A_i = \alpha(Z_{A_i}).
$$

$$
B_1 = F_1(A_1,A_2,A_3) = \alpha(Z_{B_1}) = \alpha(w_{11}A_1 + w_{21}A_2 + w_{31}A_3 + w_{41}A_4 + b_1).
$$

### 利用节点值偏导数求权重偏导数和偏置偏导数

$$
\begin{align}
L'(w_{11}) &= L'(Z_{B_1}) \cdot Z'_{B_1}(w_{11}) &&= L'(Z_{B_1}) \cdot A_1, \\
L'(b_1) &= L'(Z_{B_1}) \cdot Z'_{B_1}(b_1) &&= L'(Z_{B_1}).
\end{align}
$$

### 利用后一层节点偏导数求前一层节点值偏导数

$$
\begin{align}
L'(Z_{A_1}) &= L'(Z_{B_1}) \cdot Z'_{B_1}(A_1) \cdot A'_1(Z_{A_1}) \\
            &+ L'(Z_{B_2}) \cdot Z'_{B_2}(A_1) \cdot A'_1(Z_{A_1}) \\
            &+ L'(Z_{B_3}) \cdot Z'_{B_3}(A_1) \cdot A'_1(Z_{A_1}) \\
            &+ L'(Z_{B_4}) \cdot Z'_{B_4}(A_1) \cdot A'_1(Z_{A_1}) \\
&= \sum_jL'(Z_{B_j}) \cdot Z'_{B_j}(A_1) \cdot A'_1(Z_{A_1}) \\
&= (\sum_jL'(Z_{B_j}) \cdot w_{1j}) \cdot \alpha'(Z_{A_1}).
\end{align}
$$

$$
L'(Z_{A_i}) = (\sum_jL'(Z_{B_j}) \cdot w_{ij}) \cdot \alpha'(Z_{A_i}).
$$

其中，还需要注意**输入层和输出层**的节点值偏导数：

- 输入层可能没有激活函数；
- 输出层可能有特殊的输出函数，并且没有后一层神经网络，直接和损失函数相连，需要直接算出节点偏导数。

例如在 mnist 学习中，我分别使用 $$Softmax, CrossEntropy$$ 作为输出函数和损失函数，若取 $Ci$ 为最后一层节点值，$$n$$ 为标签值，$$Y_k= \begin{cases}1, & k = n, \\ 0, & k \ne n,\end{cases}$$ $$S = Softmax, L = CrossEntropy,$$ 则需要通过

$$
\begin{align}
S(C_i) &= \frac{e^{C_i}}{\sum_ke^{C_k}}, \\
L &= -\sum_k Y_k \cdot \ln S(C_k)) = -\ln S(C_n), \\
L'(C_i) &= S(C_i) - Y_i.
\end{align}
$$

算出最后一层的节点值偏导数（详细的推导请自行查阅）

可以看出，之所以 $$Softmax, CrossEntropy$$ 很搭配是因为它们配合在一起的导数很好求

## 最终计算过程

由此，可以获得反向传播神经网络的计算过程：

1. 和正向神经网络相同，选择合适的函数获取拟合函数（两者的差异主要在偏导数的求法不同）
2. 从后往前，计算出每层的**节点值偏导数**
3. 利用每层的**节点值偏导数**算出**权重偏导数和偏置偏导数**
4. 梯度下降

[最终代码](https://github.com/VioleshnvQuetsall/feedforward-mnist/blob/main/backward_processor.py)

