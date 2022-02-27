---
layout: post
title: 《算法导论》第二章
description: >
  《算法导论》第二章（笔记、作业）
sitemap: false
hide_last_modified: true
categories: [algorithm]
tags: [algorithm]
---

0. his line will be replaced by the toc
{:toc}

## 函数

## 函数记号

| 定义                                                         | 名称             | 类比        |
| ------------------------------------------------------------ | ---------------- | ----------- |
| $$\Theta(g(n)) = \{ f(n): \exists c_1, c_2,N>0, \forall n \ge N, \text{有 } 0 \le c_1 g(n) \le f(n) \le c_2 g(n) \}$$ | 渐进确界         | $$f = g$$   |
| $$O(g(n)) = \{ f(n): \exists c,N>0, \forall n \ge N, \text{有 } 0 \le f(n) \le c g(n) \}$$ | 渐进上界         | $$f \le g$$ |
| $$\Omega(g(n)) = \{ f(n): \exists c, N>0, \forall n \ge N, \text{有 } 0 \le c g(n) \le f(n) \}$$ | 渐进下界         | $$f \ge g$$ |
| $$o(g(n)) = \{ f(n): \forall c, \exists N>0, \forall n \ge N, \text{有 } 0 \le f(n) \lt c g(n) \}$$ | 非渐进紧确的上界 | $$f \lt g$$ |
| $$\omega(g(n)) = \{ f(n): \forall c, \exists N>0, \forall n \ge N, \text{有 } 0 \le c g(n) \lt f(n) \}$$ | 非渐进紧确的下界 | $$f \gt g$$ |


- 传递性

  $$
  \begin{align*}
  f(n) = \Theta(g(n)) \and g(n) = \Theta(h(n)) &\to f(n) = \Theta(h(n)), \\
  f(n) = O(g(n)) \and g(n) = O(h(n)) &\to f(n) = O(h(n)), \\
  f(n) = \Omega(g(n)) \and g(n) = \Omega(h(n)) &\to f(n) = \Omega(h(n)), \\
  f(n) = o(g(n)) \and g(n) = o(h(n)) &\to f(n) = o(h(n)), \\
  f(n) = \omega(g(n)) \and g(n) = \omega(h(n)) &\to f(n) = w(h(n)). \\
  \end{align*}
  $$

- 自反性

  $$
  \begin{align*}
  f(n) &= \Theta(f(n)), \\
  f(n) &= O(f(n)), \\
  f(n) &= \Omega(f(n)).
  \end{align*}
  $$

- 对称性

  $$
  f(n) = \Theta(g(n)) \iff g(n) = \Theta(f(n)).
  $$

- 转置对称性

  $$
  \begin{align*}
  f(n) = O(g(n)) &\iff g(n) = \Omega(f(n)), \\
  f(n) = o(g(n)) &\iff g(n) = \omega(f(n)). \\
  \end{align*}
  $$

$$\lg(n!) = \Theta(n\lg n)$$

$$n! = \sqrt{2 \pi n}(\frac n{\rm e})^n(1+\Theta(\frac 1n))$$

$$\lg^*n = \min\{ i \ge 0: \lg^{(i)}n \le 1 \}$$

若 $$\exists k[f(n) = O(n^k)]$$，则称 $$f(n)$$ **多项式有界**；若 $$\exists k[f(n) = O(\lg^kn)]$$，则称 $$f(n)$$ **多对数有界**。

### 练习

- 证明：若 $$f(n), g(n)$$ 为渐进非负函数，$$\max(f(n), g(n)) = \Theta(f(n) + g(n))$$

  $$
  \begin{cases}
  f(n) + g(n) \ge \max(f(n), g(n)) \\
  \frac{f(n) + g(n)}{2} \le \max(f(n), g(n)) \\
  \end{cases} \implies \max(f(n), g(n)) = \Theta(f(n) + g(n)).
  $$

- 证明：$$\forall a,b \in \mathbb R(b > 0 \to (n+a)^b = \Theta(n^b))$$

  $$
  \begin{align*}
  a \ge 0, \\
  & (n+a)^b = \sum_{k=0}^{b}\binom{b}{k}n^{b-k}a^{k}, \\
  & \text{let } n^b > \sum_{k=1}^{b}\binom{b}{k}n^{b-k}a^{k}, \\
  & \sum_{k=1}^{b}\binom{b}{k}\frac{a^{k}}{n^k} < 1 \\
  & \text{let }n > N = \binom{b}{[k/2]} \cdot ab, \text{then } 2n^b > (n+a)^b.\\
  a < 0, \\
  & \text{let } n' = n + a, n = n' - a, \text{then} -a > 0.
  \end{align*}
  $$

  $$
  \begin{align*}
  n+a \le n + \lvert a \rvert \le 2n, &\text{ when }n \ge \lvert a \rvert \\
  n+a \ge n - \lvert a \rvert \ge \frac 12n, &\text{ when }n \ge 2\lvert a \rvert \\\hline
  0 \le (\frac 12)^bn^b \le (n+a)^b \le 2^bn^b, &\text{ when } n \ge 2\lvert a \rvert 
  \end{align*}
  $$

  

- $$T(N)$$ 至少为 $$O(n^2)$$ 无意义

  $$O(n^2)$$ 表示的所有渐进时间在 $$n^2$$ 以下的函数

- 证明：$$f(n) = \Theta(g(n)) \iff f(n) = O(g(n)) \wedge f(n) = \Omega(g(n))$$

  $$
  \begin{align*}
  f(n) = \Theta(g(n)) &\iff \exist c_1, c_2,N>0, \forall n \ge N, \text{有 } 0 \le c_1 g(n) \le f(n) \le c_2 g(n), \\
  f(n) = \Omega(f(n)) &\iff \exist c_1,N>0, \forall n \ge N, \text{有 } 0 \le c_1 g(n) \le f(n), \\
  f(n) = O(g(n)) &\iff \exist c_2,N>0, \forall n \ge N, \text{有 } 0 \le f(n) \le c_2 g(n), \\
  \end{align*}
  $$

  对照即可

- 证明：$$o(g(n)) \cap \omega(g(n)) = \varnothing$$

  $$
  o(g(n)) \cap \omega(g(n)) = \{ f(n): \forall c,N>0, \exist n \ge N, \text{有 } 0 \le cg(n) < f(n) \lt c g(n) \} = \varnothing
  $$

- 给出有两个参数的记号

  $$
  \begin{align*}
  \Theta(g(n,m)) &= \{ f(n,m): \exist c_1, c_2,N,M(n \ge N \or m \ge M \to 0 \le c_1g(n,m) \le f(n,m) \le c_2g(n,m)) \}, \\
  O(g(n,m)) &= \{ f(n,m): \exist c,N,M(n \ge N \or m \ge M \to 0 \le f(n,m) \le cg(n,m)) \}, \\
  \Omega(g(n,m)) &= \{ f(n,m): \exist c,N,M(n \ge N \or m \ge M \to 0 \le cg(n,m)) \le f(n,m) \}. \\
  \end{align*}
  $$

- 证明：$$a^{\log_bc} = c^{\log_ba}$$

  $$
  a^{\log_bc} = b^{\log_ba \cdot \log_bc} = c^{\log_ba}.
  $$

- 证明：$$\lg(n!) = \Theta(n\lg n)$$

  $$
  \begin{align*}
  \lg(n!) &\le n\lg n = \lg n^n , \\
  \lg(n!) &= \sum_{k=0}^{n}{\lg k}\\
          &\ge \sum_{k=\lceil n/2 \rceil}^{n}{\lg k}\\
          &\ge \frac n2\lg{\frac n2} \\
          &= \frac n2\lg n - \frac n2 \lg2 \\
          &\ge \frac n2\lg n - \frac n4 \lg n, \text{when }n \ge 4 \\
          &=\frac 14n \lg n.
  \end{align*}
  $$

- 证明：$$F_i = \frac{\phi^i-\hat\phi^i}{\sqrt5}$$，其中 $$\phi = \frac{1+\sqrt5}{2}, \hat\phi = \frac{1-\sqrt5}{2}$$

  $$
  \begin{align*}
  &F_0 = 0, F_1 = 1. \\
  \text{if }&F_{i-1} = \frac{\phi^{i-1}-\hat\phi^{i-1}}{\sqrt5}, F_i = \frac{\phi^i-\hat\phi^i}{\sqrt5}, \\
  \text{then } &F_{i+1} = F_{i-1} + F_i = \frac{\phi^{i-1}(\phi+1)-\hat\phi^{i-1}(\hat\phi+1)}{\sqrt5} = \frac{\phi^{i+1}-\hat\phi^{i+1}}{\sqrt5}. \\
  \end{align*}
  $$

- 证明：$$k \ln k = \Theta(n) \implies k = \Theta(n/\ln n)$$

  $$
  \begin{align*}
  & k \ln k = \Theta(n) \\\implies
  & n = \Theta(k \ln k) \\\implies
  & \ln n = \Theta(ln(k \ln k)) = \Theta(\ln k + \ln\ln k) =\Theta(\ln k) \\\implies
  & \frac{n}{\ln n} = \frac{\Theta(k \ln k)}{\Theta(\ln k)} = \Theta(\frac{k \ln k}{\ln k}) = \Theta(k) \\\implies
  & k = \Theta(\frac{n}{\ln n})
  \end{align*}
  $$

- 证明：$$\lg^*(\lg n) > \lg(\lg^*n), \text{when } n \ne 1$$

  $$
  \begin{align*}
  \lg^*n = \min\{ i \ge 0: \lg^{(i)}n \le 1 \} &\implies \lg^*n - 1 = \min\{ i \ge 0: \lg^{(i+1)}n = \lg^{(i)}(\lg n) \le 1 \} = \lg^*(\lg n), \\[2em]
  x - 1 \ge \lg x &\implies \lg^*(\lg n) = \lg^*n - 1 \ge \lg(\lg^*n)
  \end{align*}
  $$


### 思考题

- 渐进增长的性质
  $$
  \begin{align*} &
  \begin{cases}
  f(n) = O(g(n)) \\
  \lg{g(n)} \ge 1 \\
  f(n) \ge 1 \\
  \end{cases} \\\implies &
  \exist c,N>0, \forall n \ge N[0 \le f(n) \le c g(n)]  \\\implies &
  \lg f(n) \le \lg(c g(n)) = \lg c + \lg g(n) \\\implies &
  \lg f(n) = O(\lg g(n)) \\
  \end{align*}
  $$

  $$
  \begin{align*}
  g(n) = o(f(n)) 
  \implies& \forall c \ge 0, \exist N > 0, \forall n \ge N, 0 \le g(n) \le cf(n)
  \\\implies&
  \forall c \ge 0, \exist N > 0, \forall n \ge N, 0 \le f(n) \le f(n) + g(n) \le (1+c)f(n)
  \\\implies&
  f(n) + o(f(n)) = \Theta(f(n)).
  \end{align*}
  $$

- $$\overset{\infty}{\Omega}(g(n)) = \{ f(n): \exists c,\text{对无穷多个整数 }n, 0 \le cg(n) \le f(n) \}$$

  证明：$$\forall f,g\in\text{渐进非负函数}[f(n) = O(g(n)) \vee f(n) = \overset{\infty}{\Omega}(g(n))] = \bf T$$，$$\forall f,g[f(n) = O(g(n)) \wedge f(n) = \Omega(g(n))] = \bf F$$

  $$
  \begin{align*}
  \neg[f(n) = O(g(n))] &= \neg[\exist c,N>0, \forall n \ge N(0 \le f(n) \le c g(n))] \\
                       &= \forall c,N>0, \exist n \ge N[cg(n) < f(n)], \\[2em]
  &\text{不妨依次取 } n = n_i, N_i = n_i, (i < j \implies n_i < n_j), \\
  &\text{则显然 }\forall N \text{ 意味着 $n$ 有无穷个, 这与 $\overset{\infty}{\Omega}(g(n))$ 定义相合} \\
  &\text{即 }\neg[f(n) = O(g(n))] \to f(n) = \overset{\infty}{\Omega}(g(n)), \\
  &\text{由 }\neg p \to q \equiv p \or q \text{ 得证}.
  \end{align*}
  $$

