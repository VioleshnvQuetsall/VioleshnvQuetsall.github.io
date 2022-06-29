---
title: 线性回归
description: 机器学习--线性回归
sitemap: false
hide_last_modified: true
categories: [ml]
tags: [linear-regression]
related_posts:
  - ''
---

0. this line will be replaced by the toc
{:toc}

### 线性回归的预设

- 线性

  只能通过每个样本各维的线性组合获得预测结果，这使得函数很简单，但拟合能力较弱。

- 同方差性

  每个样本的方差不变。方差不同会使得拟合函数对某些数据敏感性有差异。

- 独立性

  每个样本独立于其他样本

- 固定特征

  特征数是固定的

- 非多重共线性

  特征直接不能存在线性关系

$$
\begin{align*}
y&=\sum_iw^{(i)}\phi_i(\pmb x)+\epsilon=\pmb w^T\pmb x+\epsilon\\
J(\pmb w;\pmb{x_i},y_i)&=\sum_i(y_i-{\hat y}_i)^2=\sum_i\left(y_i-\sum_jw^{(j)}\phi_j(\pmb{x_i})\right)^2
\end{align*}
$$

$$\pmb x$$ 经过 $$j$$ 个基函数（basis function） $$\phi_j$$ 转为新的 $$j$$ 维样本，同样是线性回归方程。经过变化后的方程对 $$\phi(\pmb x)$$ 是线性回归，但对 $$\pmb  x$$ 来说不是了，可以更好地拟合非线性函数。

### 常用基函数

- $$\phi(x)=x^p$$；
- $$\phi(x;\mu,\sigma)=\exp\left({(x-\mu)^2\over2\sigma^2}\right)$$；
- $$\phi(x;s)=\frac1{1+\exp(-sx)}$$；
- $$\phi(x)=\ln(x+1)$$。
- $$\phi(x)=\pmb1_{\mathcal X}(x)=\begin{cases}1,x\in\mathcal X\\0,x\notin\mathcal X\end{cases}$$
- $$\phi(x)=\begin{cases}\sin n\pi x\\\cos n\pi x\end{cases}$$

比如对 $$\pmb x=\lbrace x^{(1)},x^{(2)}\rbrace$$ 使用多项式转换，并令最大次数为 2，得 $$\pmb\phi(\pmb x)=\lbrace\phi_1(\pmb x),\dots,\phi_j(\pmb x)\rbrace=\lbrace 1,x^{(1)},x^{(2)},x^{(1)}x^{(2)},[x^{(1)}]^2,[x^{(2)}]^2\rbrace$$

随着多项式最大次数的提高，通过基函数转换而来的新向量的维数呈几何式增长。

### 最小二乘估计和最小二乘反演

依照 $$\pmb\Phi$$ 左逆和右逆的存在情况。

$$
\begin{align*}
&&{\pmb\Phi}&=\begin{pmatrix}
\phi_0(\pmb{x_1})&\phi_1(\pmb{x_1})&\dots&\phi_j(\pmb{x_1})\\
\phi_0(\pmb{x_2})&\phi_1(\pmb{x_2})&\dots&\phi_j(\pmb{x_2})\\
\vdots&\vdots&\ddots&\vdots\\
\phi_0(\pmb{x_i})&\phi_1(\pmb{x_i})&\dots&\phi_j(\pmb{x_i})\\
\end{pmatrix}\\[0.2cm]
&&\hat{\pmb y}&={\pmb\Phi}\cdot\pmb w\\[1em]
\text{let}&&\nabla_{\pmb w} J(\pmb w;X,\pmb y)&=\nabla_{\pmb w}\vert\vert\pmb y-\hat{\pmb y}\vert\vert^2=2{\pmb\Phi}^T({\pmb\Phi}\pmb w-\pmb y)=0\\[0.2cm]
\text{then}&&\pmb w&=({\pmb\Phi}^T{\pmb\Phi})^{-1}{\pmb\Phi}^T\pmb y\\
\end{align*}
$$

$$
\begin{align*}
&&\pmb y&=\pmb\Phi\pmb w\\
&&(\pmb\Phi\pmb\Phi^T)(\pmb\Phi\pmb\Phi^T)^{-1}\pmb y&=\pmb\Phi\pmb w\\
&&\pmb\Phi\pmb\Phi^T(\pmb\Phi\pmb\Phi^T)^{-1}\pmb y&=\pmb\Phi\pmb w\\
&&\pmb w_{mn}&=\pmb\Phi^T(\pmb\Phi\pmb\Phi^T)^{-1}\cdot\pmb y\\
\text{let $\pmb w_0$ be another the solution to}&&\pmb y&=\pmb\Phi\pmb w\\
\text{then}&&\pmb\Phi(\pmb w_0-\pmb w_{mn})&=0\\
\text{and}&&(\pmb w_0-\pmb w_{mn})^T\pmb w_{mn}&=(\pmb w_0-\pmb w_{mn})^T\pmb\Phi^T(\pmb\Phi\pmb\Phi^T)^{-1}\pmb y\\
&&&=0\\
\text{i.e.}&&(\pmb w_0-\pmb w_{mn})&\ \bot\ \pmb w_{mn}\\
\text{so}&&\vert\vert\pmb w_0\vert\vert^2&=\vert\vert\pmb w_{mn}+\pmb w_0-\pmb w_{mn}\vert\vert^2\\
&&&=\vert\vert\pmb w_{mn}\vert\vert^2+\vert\vert\pmb w_0-\pmb w_{mn}\vert\vert^2\\
&&&\ge\vert\vert\pmb w_{mn}\vert\vert^2\\
\text{therefore}&&\vert\vert\pmb w_{mn}\vert\vert^2&\text{ has minimum norm}
\end{align*}
$$

$$
\begin{align*}
\pmb w&=\begin{cases}
({\pmb\Phi}^T{\pmb\Phi})^{-1}{\pmb\Phi}^T\pmb y&\text{left inverse}\\[0.2cm]
{\pmb\Phi}^T({\pmb\Phi}{\pmb\Phi}^T)^{-1}\pmb y&\text{right inverse}
\end{cases}
\end{align*}
$$

值得注意的是，在左逆中 $$\hat{\pmb y}=\pmb\Phi\pmb w$$，而在右逆中 $$\pmb y=\pmb\Phi\pmb w$$；左逆中使用 $$\nabla_{\pmb w}J$$，而右逆中使用 $$\pmb y=\pmb\Phi\pmb w$$。

这是因为左逆中样本数量通常远大于特征数量，我们希望 $$\pmb\Phi$$ 变换能够完成从低维空间向量 $$\pmb w$$ 到高维空间向量 $$\pmb y$$ 的变换，但这种变换因为维数差异不一定能完成，所以 $$\pmb w$$ 只能变换为 $$\hat{\pmb y}$$，而衡量 $$\pmb y,\hat{\pmb y}$$ 之间的差异的就是损失函数。令损失函数最小化则是让变换的差异尽可能缩小。

而右逆中则是特征数量大于样本数量， $$\pmb\Phi$$ 变换是从高维空间向量 $$\pmb w$$ 到低维空间向量 $$\pmb y$$ 的变换，这个变换必定有解，而且可能不止一个。$$\pmb w_{mn}=\pmb\Phi^T(\pmb\Phi\pmb\Phi^T)^{-1}\cdot\pmb y$$ 这个相等其实是在 $$\pmb\Phi$$ 变换下的具有最小范数的向量。取得这个最小范数的关键在于 $$\pmb w_{mn}$$ 处于 $$\pmb\Phi^T$$ 的线性空间中，即 存在 $$\pmb w_{mn}=\pmb\Phi^T\pmb b,\pmb b=({\pmb\Phi}{\pmb\Phi}^T)^{-1}\pmb y$$。从图形上看，$$\pmb w_{mn}$$ 映射到 $$\pmb y$$ 是直接投影，$$\pmb w_0-\pmb w_{mn}$$ 则是与 $$\pmb\Phi^T$$ 正交的向量，总是投影到零空间，因此与 $$\pmb w_{mn}$$ 相加不改变投影结果，但会增加范数。


> $$
> \begin{align*}
> A.shape&=(m,n)\\
> \operatorname{rank}(\pmb A)&=m,\text{ i.e., }\pmb A\text{ is of full row-rank}\\
> \operatorname{rank}(\pmb A)&=n,\text{ i.e., }\pmb A\text{ is of full column-rank}\\
> \operatorname{rank}(\pmb A)&=m\implies\operatorname{rank}(\pmb A\pmb A^T)=m\\
> \operatorname{rank}(\pmb A)&=n\implies\operatorname{rank}(\pmb A^T\pmb A)=n\\
> \end{align*}
> $$


#### 梯度下降法

使用 Mean-Squared-Error (MSE) 作为损失函数，损失为 $$\epsilon$$

$$
\begin{align*}
\epsilon_i&=\frac12\left(y^{(i)}-[\pmb{\phi}^{(i)}]^T\pmb w\right)^2\\
&=\frac12\left([y^{(i)}]^2-2y^{(i)}[\pmb{\phi}^{(i)}]^T\pmb w+{\pmb w}^T\pmb{\phi}^{(i)}[\pmb{\phi}^{(i)}]^T\pmb w\right)\\[1em]
\epsilon&=E[\epsilon_i]\\
&=\frac12E\left[[y^{(i)}]^2\right]-E\left[y^{(i)}[\pmb{\phi}^{(i)}]^T\right]+\frac12{\pmb w}^TE\left[\pmb{\phi}^{(i)}[\pmb{\phi}^{(i)}]^T\right]\pmb w
\end{align*}
$$

$$E$$ 为求样品平均的函数，比如 $$E\left[[y^{(i)}]^2\right]\to \frac1N\sum_{i=1}^{N}[y^{(i)}]^2$$

$$
\begin{align*}
\text{let }&C=E\left[[y^{(i)}]^2\right],P^T=E\left[y^{(i)}[\pmb{\phi}^{(i)}]^T\right],R=E\left[\pmb{\phi}^{(i)}[\pmb{\phi}^{(i)}]^T\right]\\
\epsilon&=E[\epsilon_i]=\frac12C-P^T\pmb w+\frac12{\pmb w}^TR\pmb w\\
\end{align*}
$$

对每个样本损失 $$\epsilon$$，求其关于 $$\pmb w$$ 的梯度 $$\nabla_{\pmb w}\epsilon=-P+\frac12(R+R^T)\pmb w\overset{R \ 对称}{\longrightarrow}-P+R\pmb w$$

令 $$\pmb w\leftarrow\pmb w-\eta\nabla_{\pmb w}\epsilon$$，其中 $$\eta$$ 为超参数学习率，则完成一步梯度下降。

也可使用 $$\pmb w=R^{-1}P$$ 直接得出结果，但实际情况中不一定能得出 $$R,P$$（数据集不完全 / 数据集太大放不进内存），而且这也只是损失函数为 MSE 的情况。（后面使用递归最小二乘可以使用这个方法）

> $$\nabla_{\pmb x}{\pmb x}^T\pmb a=\nabla_{\pmb x}{\pmb a}^T\pmb x=\pmb a$$
>
> $$\nabla_{\pmb x}{\pmb x}^T\pmb A\pmb x=(\pmb A+{\pmb A}^T)\pmb x\overset{A\text{ 为对称矩阵}}{\longrightarrow}2\pmb A\pmb x$$

由所使用的训练集的大小，可以区分出三种梯度下降法：<abbr title="Batch Gradient Descent">BGD</abbr>、<abbr title="Stochastic Gradient Descent ">SGD</abbr>、<abbr title="Mini-batch Gradient Descent">Mini Batch GD</abbr>。

- BGD 需要提前获得所有训练集，但是对于某些模型，需要边训练边使用，在使用的过程中收集数据，而且一般数据集也是比较大的；
- SGD 是边训练边使用的模式，随着训练集的增加慢慢学习，因为不能获得所有数据所以无法计算 $$R,P$$；
- Mini Batch GD 接近 SGD，但是使用每次训练时更大的数据集。

如果在 SGD 或 Mini Batch GD 尝试用不完全的训练集来计算 $$R,P$$ 直接获得 $$\pmb w^*=\underset{\pmb w}{\arg \min}(\epsilon)=R^{-1}P$$，那么只能达到这些不完全的训练集最小 $$\pmb w^*$$，而不是整个训练集的 $$\pmb w^*$$。

### 递归最小二乘法

$$
\begin{align*}
\pmb Y_i&=\begin{pmatrix}
y^{(0)}\\
y^{(1)}\\
\vdots\\
y^{(i)}\\
\end{pmatrix},
\pmb H_i=\begin{pmatrix}
\pmb h_0^T\\
\pmb h_1^T\\
\vdots\\
\pmb h_i^T\\
\end{pmatrix},
\pmb V_i=\begin{pmatrix}
v^{(0)}\\
v^{(1)}\\
\vdots\\
v^{(i)}\\
\end{pmatrix},\\[0.8cm]
\pmb Y_i&=\pmb H_i\pmb X_i+\pmb V_i\\
\hat{\pmb X}_i&=(\pmb H^T_i\pmb H_i)^{-1}\pmb H^T_i\pmb Y_i\overset{\pmb M_i=(\pmb H^T_i\pmb H_i)^{-1}}{======}\pmb M_i\pmb H^T_i\pmb Y_i,\\[0.2cm]
\text{notice that }&\pmb H^T_i\pmb H_i=\pmb H^T_{i-1}\pmb H_{i-1}+\pmb h_i\pmb h_i^T,\\
\text{therefore, }&\pmb M_i = (\pmb M^{−1}_{i−1} +\pmb h_i\pmb h^T_i )^{−1}=\pmb M_{i-1}-{\pmb M_{i-1}\pmb h_i\pmb h_i^T\pmb M_{i-1}\over\pmb I_i+\pmb h_i^T\pmb M_{i-1}\pmb h_i}\\
\hat{\pmb X}_i&=\pmb M_i\pmb H^T_i\pmb Y_i\\
&=\left(\pmb M_{i-1}-{\pmb M_{i-1}\pmb h_i\pmb h_i^T\pmb M_{i-1}\over\pmb I_{i-1}+\pmb h_i^T\pmb M_{i-1}\pmb h_i}\right)\left(\pmb H^T_{i-1}\pmb Y_{i-1}+\pmb h_iy^{(i)}\right)\\
&=\hat{\pmb X}_{i-1}+{\pmb M_{i-1}\pmb h_{i}\over\pmb I_{i-1}+\pmb h_i^T\pmb M_{i-1}\pmb h_i}\left(y^{(i)}-\pmb h_i^T\hat{\pmb X}_{i-1}\right)
\end{align*}
$$

使用递归最小二乘则可以使用 $$\pmb w=R^{-1}P$$ 求解。

$$
\begin{align*}
P^T_N&=E\left[y^{(i)}[\pmb{\phi}^{(i)}]^T\right]\\
&=\frac1N\sum_{i=1}^Ny^{(i)}[\pmb{\phi}^{(i)}]^T\\
&=\frac1NY_N^T\Phi_N=\frac1N\left[(N-1)P_{N-1}^T+\pmb\phi_Ny^{(N)}\right]\\
R_N&=E\left[\pmb{\phi}^{(i)}[\pmb{\phi}^{(i)}]^T\right]\\
&=\frac1N\sum_{i=1}^N\pmb{\phi}^{(i)}[\pmb{\phi}^{(i)}]^T\\
&=\frac1N\Phi^T_N\Phi_N=\frac1N\left[(N-1)R_{N-1}+\pmb\phi_N\pmb\phi_N^T\right]
\end{align*}
$$


> $$\pmb A={\pmb B}^{-1}+\pmb C{\pmb D}^{-1}{\pmb C}^T\implies{\pmb A}^{-1}=\pmb B-\pmb B\pmb C(\pmb D+{\pmb C}^T\pmb B\pmb C)^{-1}{\pmb C}^{-1}\pmb B$$
>
> $$(\pmb A+\pmb B\pmb C\pmb D)^{−1} = {\pmb A}^{−1}−{\pmb A}^{−1}{\pmb B}({\pmb C}^{−1}+\pmb D{\pmb A}^{−1}\pmb B)^{−1}\pmb D{\pmb A}^{−1}$$

