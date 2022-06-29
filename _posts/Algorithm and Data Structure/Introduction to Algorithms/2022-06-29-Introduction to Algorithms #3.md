---
title: 《算法导论》第三章
description: >
  《算法导论》第三章（笔记、作业）
sitemap: false
hide_last_modified: true
categories: [algorithm]
tags: [algorithm]
---

0. this line will be replaced by the toc
{:toc}

## 概论分析和随机算法

当概率分布在算法的输入上时，讨论**平均情况运行时间**；当算法本身作出随机选择（使用随机数生成器）时，讨论**期望运行时间**。由于算法中做出了随机选择，后者对同样的输入可能产生不同的运行时间和运行结果。因为运行环境只会提供**伪随机数生成器**，所以算法的输入不包括伪随机数生成器的输入。

~~~python
def f1(array):
    """平均情况运行时间"""
    return merge_sort(array)
def f2(array):
    """期望运行时间"""
    shuffle(array)
    return merge_sort(array)
~~~

**指示器随机变量** $$I\{A\}=\begin{cases}1&\text{如果 $A$ 发生}\\0&\text{如果 $A$ 不发生}\end{cases},E[X_A]=E[I\{A\}]=Pr\{A\}$$

**随机排列数组的方法**：

~~~python
def permute_by_sorting(array):
    RANDOM_PERMUTE_C = 50
    n = len(array)
    p = [randrange(len(array) ** RANDOM_PERMUTE_C) for _ in range(n)]
    # return [array[i] for i in sorted(list(range(n)), key=p.__getitem__)]
    return list(map(array.__getitem__, sorted(list(range(n)), key=p.__getitem__)))

def ranomize_by_swap(array):
    array = array[:]
    for i in range(len(array)):
        j = randrange(i, len(array))
        array[i], array[j] = array[j], array[i]
    return array
~~~

`RANDOM_PERMUTE_C` 越大则 `p` 中的优先级越唯一，排序结果越均匀。

**把球投到箱子里**（用于分析散列的模型）的问题。平均投多少个球才能使每个箱子中有一个球：

$$
\begin{align*}
&\text{设箱子 $b$ 个，平均投球 $n$ 个；}\\
&\text{设在前 $i-1$ 个箱子中有球的情况下使第 $i$ 个箱子中有球的投球次数为随机变量 $n_i$。}\\
&\text{在前 $i-1$ 次时投到第 $i$ 个箱子的概率为 $\frac{b-i+1}b$, $n_i$ 服从关于 $i$ 的几何分布}\\[1em]
E[n_i]&={b\over b-i+1},\qquad n=\sum_{i=1}^{b} n_i,\\
E[n]&=\sum_{i=1}^bE[n_i]=\sum_{i=1}^b{b\over b-i+1}\\
&\overset{i\leftarrow b-i+1}{====}\sum_{i=1}^b \frac bi\\
&\overset{调和级数前\ b\ 项和}{=======}b(\ln b+\frac1{2b})\\
&=b\ln b+O(1)
\end{align*}
$$


**期望特征序列长度的界**（抛硬币 $$n$$ 次所得的最长正面期望长度）：

$$L$$ 为最长序列长度，$$L_i$$ 为该长度为 $$i$$ 的事件。注意到 $$i,Pr\lbrace L_i\rbrace$$ 呈负相关，当 $$i$$ 较小时 $$Pr\lbrace L_i\rbrace$$ 较大；反之亦然。

$$
\begin{align*}
E[L]&=\sum_{i=0}^{n}i\cdot Pr\lbrace L_i\rbrace\\
    &=\sum_{i=0}^{2\lceil\lg n\rceil-1}i\cdot Pr\lbrace L_i\rbrace+\sum_{i=2\lceil\lg n\rceil}^ni\cdot Pr\lbrace L_i\rbrace\\
    &<2\lceil\lg n\rceil\sum_{i=0}^{2\lceil\lg n\rceil-1}Pr\lbrace L_i\rbrace+n\sum_{i=2\lceil\lg n\rceil}^nPr\lbrace L_i\rbrace\\
    &\overset{\sum_{i=0}^{2\lceil\lg n\rceil-1}Pr\lbrace L_i\rbrace<1,\quad\sum_{i=2\lceil\lg n\rceil}^nPr\lbrace L_i\rbrace<1/n}{===================}\\
    &<2\lceil\lg n\rceil+1=O(\lg n)\\
E[L]&=\sum_{i=0}^{n}i\cdot Pr\lbrace L_i\rbrace\\
    &=\sum_{i=0}^{\lfloor(\lg n)/2\rfloor-1}i\cdot Pr\lbrace L_i\rbrace+\sum_{i=\lfloor(\lg n)/2\rfloor}^ni\cdot Pr\lbrace L_i\rbrace\\
    &\ge\sum_{i=0}^{\lfloor(\lg n)/2\rfloor-1}0\cdot Pr\lbrace L_i\rbrace+\sum_{i=\lfloor(\lg n)/2\rfloor}^n\lfloor(\lg n)/2\rfloor\cdot Pr\lbrace L_i\rbrace\\
    &\overset{\sum_{i=\lfloor(\lg n)/2\rfloor}^nPr\lbrace L_i\rbrace\ge1-O(1/n)}{=============}\\
    &\ge\lfloor(\lg n)/2\rfloor(1-O(1/n))=\Omega(\lg n)
\end{align*}
$$

使用 Python 验证特征序列长度的界

~~~python
import numpy as np
import matplotlib.pyplot as plt

def get_max_count(size, repeat_times=10):
    """返回最大特征序列长度的平均值"""
    while True:
        if repeat_times == 0:
            return None, 0
        try:
            zero = np.zeros((repeat_times, 1), dtype=np.int8)
            sequence = np.append(
                np.random.randint(0, 2, (repeat_times, size), dtype=np.int8),
                zero, axis=1) # 获得序列
            diff = np.diff(sequence, prepend=zero, axis=1)

            begin = np.argwhere(diff > 0).astype(np.uint32) # 特征序列起始位置
            end = np.argwhere(diff < 0).astype(np.uint32) # 特征序列结束位置
            
            split = np.unique(begin[:,0], return_index=True)[1][1:] # grouped by row number
            begin_split = np.split(begin[:,1], split)
            end_split = np.split(end[:,1], split)
            
            break
        except MemoryError as err:
            # 内存不足
            print(err)
            repeat_times //= 2

    average = np.sum([np.max(e - b).astype(np.float64)
                      for b, e in zip(begin_split, end_split)])
                / repeat_times
    return average, repeat_times

linspace = np.linspace(8, 30, 150)
sizes = (2 ** linspace).astype(np.int32) 
results = np.zeros_like(sizes, dtype=np.float64)

REPEAT_TIMES = 100
repeat_times = REPEAT_TIMES

for i, size in enumerate(sizes):
    if results[i]:
        continue
    count, repeat_times = get_max_count(size, repeat_times=repeat_times)
    if count is None:
        break
    if repeat_times != REPEAT_TIMES:
        count += sum(get_max_count(size, repeat_times=repeat_times)[0]
                     for _ in range(REPEAT_TIMES // repeat_times))
        count /= REPEAT_TIMES // repeat_times + 1
    results[i] = count
    print(f'results[{i}] {size}: {results[i]} / {1.5 * np.log(size)} = {results[i] / 1.5 / np.log(size)}')

print(np.average(results / np.log(sizes), weights=sizes)) # 1.410515920608434
~~~

~~~python
plt.plot(linspace, 1.410515920608434 * np.log(sizes), label='log')
plt.plot(linspace, results, label='results')
plt.legend()
plt.show()

plt.plot(linspace, results / 1.410515920608434 / np.log(sizes), label='results / log')
plt.legend()
plt.show()
~~~

![index](/assets/img/Introduction to Algorithms.assets/index-1655557247054.png)![index](/assets/img/Introduction to Algorithms.assets/index-1655557287879.png)

可见 $$E[L]\approx 1.410515920608434\ln n$$

**在线雇佣问题**：在 $$n$$ 应聘者中选择并只选择一个。

拒绝前 $$k$$ 个，获得前 $$k$$ 个应聘者的最高分，接受之后第一个高于该最高分的应聘者，$$k=n/e$$。

$$S,S_i,B_i,O_i$$ 分别为成功得到最高分应聘者、成功得到最高分应聘者且在第 $$i$$ 位、最高分应聘者在第 $$i$$ 位、前 $$i-1$$ 个应聘者被拒绝。

$$
\begin{align*}
Pr\lbrace S\rbrace&=\sum_{i=k+1}^nPr\lbrace S_i\rbrace\\
                  &=\sum_{i=k+1}^nPr\lbrace B_i\rbrace Pr\lbrace O_i\rbrace\\
                  &=\sum_{i=k+1}^n\frac1n\cdot{k\over i-1}\\
                  &=\frac kn\sum_{i=k}^{n-1}\frac1i\\
                  &\approx\frac kn(\ln n-\ln k)\\
\end{align*}
$$


### 练习

- 用 `randint(0, 1)` 实现 `randint(a, b)`

  ~~~python
  def randint(a, b):
      bitsize = len(bin(b - a)) - 2
      while True:
          bits = (randint(0, 1) for _ in range(bitsize))
          result = a + reduce(lambda x, y: (x << 1) + y, bits)
          if result in range(a, b + 1):
            return result
  ~~~

  $$
  \begin{align*}
  T(a,b)&=T(0,1)\times bitsize\times E(loop)\\[1em]
        &=T(0,1)\times\lceil\lg(b-a)\rceil\times\sum_{i=0}^\infty(i+1)(1-{b-a\over2^{\lceil\lg(b-a)\rceil}})^i{b-a\over2^{\lceil\lg(b-a)\rceil}}\\
        &\overset{p={b-a\over2^{\lceil\lg(b-a)\rceil}}}{=====}T(0,1)\times\lceil\lg(b-a)\rceil\times p\left(\sum_{i=0}^\infty\left(1-p\right)^{i+1}\right)^\prime\\
        &=T(0,1)\times\lceil\lg(b-a)\rceil\times \frac1p\\
        &=T(0,1)\times\lceil\lg(b-a)\rceil\times{2^{\lceil\lg(b-a)\rceil}\over b-a}\\
        &<T(0,1)\times\lceil\lg(b-a)\rceil\times{2\times 2^{\lg(b-a)}\over b-a}\\[1em]
        &=T(0,1)\times2\lceil\lg(b-a)\rceil=\Theta(\lg(b-a))
  \end{align*}
  $$

- 用有偏的 `biased_randint(0, 1)` 实现无偏的 `randint(0, 1)`

  ~~~python
  def randint(0, 1):
      while (a := biased_randint(0, 1)) == (b := biased_randint(0, 1)):
          pass
      return a
  ~~~

  $$times={1 − 2p(p − 1)\over2p(p − 1)}$$

- HIRE-ASSISTANT 中雇佣一次的概率和 n 次的概率
- 
  $$
  \begin{align*}
  一次&: a_0 \ge a_i(i>0) & Pr&=\frac1n \\
  n次&:a_0<a_1<\cdots<a_i<a_n & Pr&=\frac1{n!} \\
  2次&:将数分为两堆，这两堆分别降序，减去雇佣一次的情况&Pr&={\sum_{k=1}^{n-1}\binom nk-1\over n!}={2^n-n-1\over n!}
  \end{align*}
  $$

- $$[1..n]$$ 上的均匀随机数列的逆序对个数期望

  $$
  \begin{align*}
  &\text{let $f(i,j)$ represent $i<j\wedge A[i]>A[j]$} \\
  E&=\sum_{i=1}^{n-1}\sum_{j=i+1}^{n}Pr\{f(i,j)\}\\
  &=\sum_{i=1}^{n-1}\sum_{j=i+1}^{n}\frac12\\
  &=\frac12\sum_{i=1}^{n-1}n-i\\
  &=\frac12\left[n(n-1)-{(n-1)n\over2}\right]\\
  &=\frac{n(n-1)}4
  \end{align*}
  $$

- 产生除恒等排列以外（indentity permuatation）的任意排列

  Kelp 教授的方法不能实现要求，这一算法使得所有数字都离开原位，显然有部分排列不能被生成。

- PERMUTE-WITH-ALL，$$swap(A[i], A[RANDOM(1,n)])$$ 

  使用此算法获得的结果有 $$n^n$$ 种，全排列有 $$n!$$ 个，要获得随即均匀排列，必要条件为两者为整除关系，显然不一定满足。

  $$n^n/n!=\prod_{i=1}^{n-1}n/i$$

- Armstrong 教授的算法

  ~~~python
  def permute_by_cyclic(a):
      n = len(a)
      b = [None for _ in range(n)]
      offset = random.randrange(0, n)
      for i in range(n):
          dest = i + offset
          if dest >= n:
              dest -= n
          b[dest] = a[i]
      return b
  # 实际上该算法等同于
  def permute_by_cyclic(a):
      offset = random.randrange(0, n)
      b = a[:offset] + a[offset:]
  ~~~

- `[random.randrange(0, n ** 3) for _ in range(n)]` 产生的元素都唯一的概率至少为 $$1-1/n$$

  求不唯一的概率为
  
  $$
  \begin{align*}
  Pr\lbrace \exists i,j\in[0..n-1](i\ne j\wedge P[i]=P[j])\rbrace&=Pr\lbrace \bigcup _{i,j\in[0..n-1],i\ne j}P[i]=P[j]\rbrace\\
    &\le\sum_{i,j\in[0..n-1],i<j}Pr\lbrace P[i]=P[j]\rbrace\\
    &={n(n-1)\over 2n^3}\\
    &\le\frac1n
  \end{align*}
  $$

- PERMUTE-BY-SORTING 处理相同优先级

  对具有相同优先级的数再次进行 PERMUTE-BY-SORTING，直到没有相同的优先级。

- 随机样本

  ~~~python
  def random_sample(m, n):
      if m == 0:
          return []
      s = random_sample(m - 1, n - 1)
      i = random.randrange(0, n)
      s.append(n - 1 if i in s else i)
      return s
  ~~~

  证明所有 m 子集是等可能的。

  `random_sample(1, n)` 成立，因为 `i in s` 恒为 `False`；`random_sample(n, n)` 成立，因为 `i in s` 恒为 `True`。

  如果 `random_sample(m - 1, n - 1)` 产生等可能的 $$[0..n-2]$$ 的 m-1 子集，则由于 `random.randrange(0, n)` 产生 $$[0..n-1]$$ 的任意一个数，$$n-1$$ 被添加的概率为
  
  $$
  \begin{align*}
  \underbrace{n-1\over n}_{i\in[0..n-2]}\cdot\underbrace{C_{n-2}^{m-2}\over C_{n-1}^{m-1}}_{i\in random\text-sample(m - 1, n - 1)}+\frac1n=\frac mn
  \end{align*}
  $$
  
  其他数在其中的概率（可能被添加，也可能已经在了）
  
  $$
  \begin{align*}
  \frac1n(1-{m-1\over n-1})+{m-1\over n-1}=\frac mn
  \end{align*}
  $$
  
  因此所有数的概率都为 $$m/n=C^{m-1}_{n-1}/C^m_n$$

- 生日悖论

  $$
  \begin{align*}
  \text{let $my birthday=b$}\\
  Pr\lbrace b_i=b\rbrace&=\frac1n\\
  Pr\lbrace\exists i\in[1..k](b_i=b)\rbrace&=Pr\lbrace\bigcup_{i\in[1..k]} b_i=b\rbrace\\
  &=1-Pr\lbrace\bigcap_{i\in[1..k]} b_i\ne b\rbrace\\
  &=1-({n-1\over n})^k\ge\frac12\\
  Pr\lbrace\exists i,j\in[1..k],i\ne j(b_i=b_j=\text{"7-4"})\rbrace&=Pr\lbrace\bigcup_{i,j\in[1..k],i\ne j} b_i=b_j=\text{"7-4"}\rbrace\\
  &=1-Pr\lbrace\bigcup_{i\in[1..k]} b_i\ne\text{"7-4"}\rbrace-\sum_{i=1}^kPr\lbrace b_i=b\rbrace Pr\lbrace\bigcup_{j\in[1..k],j\ne i} b_i\ne b_j\rbrace\\
  &=1-({n-1\over n})^k-k\frac1n({n-1\over n})^{k-1}\\
  &=1-{(n+k-1)(n-1)^{k-1}\over n^k}\ge\frac12
  \end{align*}
  $$

- 投到任一箱子里有两个球的期望

  投入第 $$i$$ 个球使仍未成功，说明此时有 $$i$$ 个箱子中有球，设次数为 $$n$$
  
  $$
  \begin{align*}
  E[n]&=\sum_{i=2}^{b+1}i\cdot Pr\lbrace n=i\rbrace\\
  &=\sum_{i=2}^{b+1}i{i-1\over b}\prod_{i=0}^{i-2}{b-i\over b}\\
  \end{align*}
  $$

- 分析生日悖论时需要生日彼此独立还是两两独立即可

  两两独立即可，因为使用概率分析时只需要在两两独立的前提下就可以算出生日在同一天上的概率。

- 3 人生日相同

  $$Pr\lbrace b_i=b_j=b_k=b\rbrace=1/n^3$$

  所求结果为 $$1-Pr\lbrace 两两不同\rbrace-Pr\lbrace 有两两相同没有三三相同\rbrace$$

  $$Pr\lbrace 两两不同\rbrace={n!\over n^n(n-k)!}$$

  $$Pr\lbrace 有两两相同没有三三相同\rbrace=\sum_{i=1}^{\lfloor k/2\rfloor}\left[C_n^i\prod_{j=0}^{i-1}C_{k-2j}^2\cdot\prod_{j=1}^{k-2i}(n-i-j+1)\right]\Large/n^n$$

  使用指示器随机变量分析会比较简单。

- n 球投入 n 箱，空箱子的期望

  $$
  \begin{align*}
  E[empty]&=E[\sum_{i=1}^nI\lbrace nboxes[i].isempty\rbrace]\\
  &=\sum_{i=1}^nE[I\lbrace boxes[i].isempty\rbrace]\\
  &=\sum_{i=1}^nPr\lbrace boxes[i].isempty\rbrace\\
  &=\sum_{i=1}^n(\frac{n-1}n)^n=n(\frac{n-1}n)^n
  \end{align*}
  $$

### 思考题

- R. Morris 的概率计数法

  考虑一个 $$b$$ 位的计数器，里面存储了 $$2^b$$ 个递增的数 $$n_0=0,n_1,\dots,n_{2^b-1}$$，技术单元以 $$1/(n_{i+1}-n_i)$$  从 $$n_i$$ 自增到 $$n_{i+1}$$。

  a. 如果当前数为 $$n_i$$，进行 $$n_{i+1}-n_i$$ 次 INC 操作后，期望为 $$n_{i+1}$$；进行 $$n<n_{i+1}-n_i$$ 次 INC 操作之后，期望为 $$n/(n_{i+1}-n_i)$$，期望为 $$n_i+n$$。将多次 INC 操作分为上述两种类别即可。

  b. $$p=0.01$$，每次操作都有概率自增，这是一个二项分布，其成功次数方差为 $$np(1-p)=0.0099n$$。由于 $$n_i=100i$$，表示的数的方差为 $$99n$$。

  

- 查找无序数组

  a. 

  ~~~python
  def search(array, target):
      n = len(array)
      mark = {}
      while len(mark) < n:
          while (index := random.randrange(0, n)) in mark:
              pass
          mark[index] = None
          if array[index] == target:
              return index
      return -1
  ~~~

  b. $$n$$

  c. 几何分布 $$\sum_{i=0}^\infty i({n-k\over n})^{i-1}(k/n)=n/k$$

  d. 使所有箱子都被投入一个球，$$n(\ln n+O(1))$$

  e. $$(n+1)/2$$、$$n$$

  f. $$(n+1)/(k+1)$$

  g. 都为 n

  h. 除了打乱操作以外，运行时间相同

