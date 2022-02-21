---
layout: post
title: 《算法导论》第一章
description: >
  《算法导论》第一章（笔记、作业）
sitemap: false
hide_last_modified: true
categories: [algorithm]
tags: [algorithm]
---

0. his line will be replaced by the toc
{:toc}

## 算法基础

### 分析算法

- 循环不变式

### 设计算法

- 分治法

### 练习

- 线性查找的平均检查次数

  最好 1 次，最坏 n 次，平均 $$\frac{n+1}{2}$$ 次，$$f(n) = \Theta(n)$$。

- 使任何算法的**最好情况**运行时间提高的办法

  将最好情况总结，并作为算法的特例实现。但是不应该将函数的最好情况作为判断函数效率的指标看待。

- 归并算法 MERGE 过程结束的两种实现

  1. 使用哨兵

     MERGE 操作会选择更小的数填充数组，理论上可以使用 $$\infin$$ 使下标不会越界，由于编程时没有真正的无穷，只能使用最大值代替，这**要求原数组中没有最大值**。

     ~~~java
     void merge(int[] array, int low, int mid, int high)
     {
         int len1 = mid - low, len2 = high - mid;
         int[] a1 = new int[len1 + 1];
         int[] a2 = new int[len2 + 1];
         for (int i = 0; i != len1; ++i) a1[i] = array[low + i];
         for (int i = 0; i != len2; ++i) a2[i] = array[mid + i];
         
         a1[len1] = Integer.max();
         a2[len2] = Integer.max();
         
         // merge
         for (int i = 0, j = 0, k = low; k != high; ++k) {
             array[k] = a1[i] <= a2[j] ? a1[i++] : a2[j++];
         }
     }
     ~~~

  2. 进行下标越界检查

     比较 `i, j != mid, high`。

     `i, j` 分别达到 `mid, high` 是有先后的，因此需要在之后继续遍历未完结的数组。

     ~~~java
     void merge(int[] array, int low, int mid, int high)
     {
         int len1 = mid - low, len2 = high - mid;
         int[] a1 = new int[len1];
         int[] a2 = new int[len2];
         for (int i = 0; i != len1; ++i) a1[i] = array[low + i];
         for (int i = 0; i != len2; ++i) a2[i] = array[mid + i];
         
         // merge
         int i = 0, j = 0, k = low;
         while (i != len1 && j != len2) array[k++] = a1[i] <= a2[j] ? a1[i++] : a2[j++];
         while (i != len1) array[k++] = a1[i++];
         while (j != len2) array[k++] = a2[j++];
     }
     ~~~

- 证明
  $$
  \text{if } n = 2 ^ k, T(n) =
  \begin{cases}
  2           & n = 2, \\[2ex]
  2T(n/2) + n & n = 2 ^ k, k > 1,
  \end{cases}
  \\[2ex]
  \text{then } T(n) = n \lg n.
  $$

  $$
  \begin{align*}
  T(n) &= T(2^k) \\[2ex]
       &= 2T(2^{k-1}) + 2^k \\[2ex]
       &= 4T(2^{k-2}) + 2^{k} + 2^k \\[2ex]
       &= \cdots \\[2ex]
       &= 2^{k-1}T(2) + 2^k + \cdots + 2^k \\[2ex]
       &= k \cdot 2^k \\[2ex]
       &= n \lg n.
  \end{align*}
  $$

- 将插入排序视为一个递归过程

  为了排序 `a[0..n]`（`0..n` 不包括 `n`），递归地排序 `a[0..n-1]`，将 `a[n-1]` 插入已排序的数组。

  由于 `a[0..n-1]` 有序，可以使用二分搜索获取插入位置，该算法稳定。
  
  ~~~java
  public static void insertSort(int[] array, int n) {
      if (n > array.length) n = array.length;
      if (n <= 0) return;
      // sort [begin..end-1]
      insertSort(array, n - 1);
      // find
      int low = 0, high = n - 1;
      int target = array[high];
      while (low != high) {
          int mid = ((high - low) >> 1) + low;
          if (array[mid] <= target)
              low = mid + 1;
          else
              high = mid;
      }
      // 此时 array[high-1] <= target < array[high]
      // insert
      for (int i = n - 1; i != high; --i) array[i] = array[i - 1];
      array[high] = target;
  }
  ~~~
  
  最坏情况为每次都插入首位，即数组完全递减，因此
  $$
  T(n) =
  \begin{cases}
  1                  & n = 1, \\[2ex]
  T(n-1) + \lg n + n & n \ne 1. \\
  \end{cases}
  $$

- 给定 n 个整数的集合 $$S$$ 和另一个整数 $$n$$，给出 $$T(n)=\Theta(n \lg n)$$ 的算法

  ~~~cpp
  // T(n) = n lg n 修改元素
  bool findAddPair(vector<int> &s, int n) {
      auto begin = s.begin(), end = s.end();
      sort(begin, end);
      for (int val : s) {
          if (binary_search(begin++, end, val - n)) return true;
      }
      return false;
  }
  ~~~

  ~~~cpp
  // T(n) = n 额外n哈希空间
  bool findAddPair(const vector<int> &s, int n) {
      unordered_set<int> set;
      for (int val : s) {
          if (set.count(val - n)) return true;
          set.emplace(val);
      }
      return false;
  }
  ~~~

### 思考题

- 在归并排序中对小数组使用插入排序

  对长度为 $$k$$ 的 $$\frac nk$$ 个子表使用使用插入排序，再用标准的合并机制合并这些子表。

  1. 插入排序最坏情况为 $$\Theta(n^2)$$，可以在 $$T(n)=\frac{n}{k}\Theta(k^2)=\Theta(nk)$$ 完成排序

  2. 归并排序最坏情况为 $$\Theta(n \lg n)$$，使用插入排序辅助后
     $$
     \begin{align*}
     & \frac n{2^p} \le k, \frac n{2^{p-1}} > k \\[2ex]
     \to &
     \lg\frac nk \le p < \lg\frac nk+ 1 \\[2ex]
     \to & p = \lceil \lg\frac nk \rceil
     \end{align*}
     $$

     $$
     \begin{align*}
     T(n) &=
         \begin{cases}
         \Theta(n^2)   & n \le k, \\[2ex]
         2T(n/2) + cn & n > k,
         \end{cases} \\[2ex]
     T(n) &= 2T(n/2) + cn \\[2ex]
          &= 4T(n/4) + cn + cn \\[2ex]
          &= \cdots \\[2ex]
          &= \Theta(nk) + cn\lg\frac nk \\[2ex]
          &= \Theta(nk) + \Theta(n\lg\frac nk).
     \end{align*}
     $$
     
     **$$n$$ 足够大时**，求导有
     $$
     c_1 n = c_2 \frac nk, \\[2ex]
     k = \frac{c_2}{c_1}.
     $$
     解为 $$k$$ 的取值。
     
     验证 $$k$$ 与 $$n$$ 无关（**$$n$$ 足够大时**）：
     
     ~~~python
     import numpy as np
     import matplotlib.pyplot as plt
     from time import perf_counter
     from functools import wraps
     
     def timethis(func):
         @wraps(func)
         def wrapper(*args, **kwargs):
             s = perf_counter()
             func(*args, **kwargs)
             t = perf_counter() - s
     
             return t
         return wrapper
     
     def insertion_sort(arr):
         count = arr.size;
         if count <= 1: return
         i = 1
         while i != count:
             target = arr[i]
             low, high = 0, i
             while low != high:
                 mid = (high + low) // 2
                 if arr[mid] <= target:
                     low = mid + 1
                 else:
                     high = mid
             j = i
             while j != high:
                 arr[j] = arr[j - 1]
                 j -= 1
             arr[high] = target
             i += 1
     
     @timethis
     def merge_sort(arr, k):
         a = arr
         count = a.size;
         if count <= 1: return
         b = np.zeros_like(a)
         if count <= k:
             insertion_sort(arr)
             return
     
         start = 0
         while start < count:
             insertion_sort(arr[start:start + k])
             start += k
         seg = k
         while seg < count:
             start = 0
             while start < count:
                 low, high, mid = start, min(start + (seg * 2), count), min(start + seg, count)
                 i, j, k = low, mid, low
                 while i != mid and j != high:
                     if a[j] < a[i]:
                         b[k] = a[j]
                         j += 1
                     else:
                         b[k] = a[i]
                         i += 1
                     k += 1
                 while i != mid:
                     b[k] = a[i]
                     k += 1
                     i += 1
                 while j != high:
                     b[k] = a[j]
                     k += 1
                     j += 1
                 start += seg * 2
             a, b = b, a
             seg *= 2
         if b is arr:
             arr[:] = a
     
     def main():
         for k in range(10, 100, 10):
             ns = np.array([5_000, 10_000, 50_000, 100_000])
             ts = np.empty_like(ns, dtype=np.float64)
             for i, n in enumerate(ns):
                 ts[i] = avg_time(n, k)
             plt.plot(np.log(ns), ts, label=str(k))
             print(ts)
         plt.legend()
         plt.show()
     ~~~
     
     通过改变 $$k$$ 和数组长度，随着数组长度的变化（$$5000 \to 2^{24}$$）， $$k$$ 没有大幅改变，在此环境上可以认为 $$k$$ 在 $$(32,34)$$ 附近。
     
     ![image-20220123225051206](assets/img/Introduction to Algorithms.assets/image-20220123225051206.png)
  
- 霍纳（Horner）规则的正确性

  ~~~cpp
  int y = 0;
  for (int i = n; i >= 0; --i) y = a[i] + x * y;
  ~~~

  $$
  P(x) = \sum^n_{k=0}a_k x^k = a_0 + x(a_1 + x(a_2 + \cdots + x(a_{n-1} + xa_n)\cdots))
  $$

  数学归纳法（循环不变式）证明：
  $$
  \begin{align}
  \text{若 } & P_i(x) = \sum_{k=i}^{n}a_{k} x^{k-i}, \\
  \text{则 } & P_{i-1}(x) = a_{i-1} + xP_i(x) = a_{i-1} + \sum_{k=i}^{n}a_{k} x^{k-
  i+1} = \sum_{k=i-1}^{n}a_k x^{k-(i-1)}. \\[2ex]
  \text{由于 } & P_n(x) = a_n = \sum_{k=n}^{n}a_k x^{k-n}, \\
  \text{所以 } & P(x) = P_0(x) = \sum^n_{k=0}a_{k} x^{k}.
  \end{align}
  $$
  
  可以取 $$P_{n+1} = 0$$
  {.note title="notice"}
  

  可以计算机系统相关联
  
  ~~~cpp
  # 1
  int y = 0;
  for (int i = n; i >= 0; --i) y = a[i] + x * y;
  
  # 2
  int y = 0;
  int p = 1;
  for (int i = 0; i <= n; ++i) {
      y += p * a[i];
      p *= x;
  }
  ~~~
  
  由于 `#2` 做了两次乘法一次加法，`#1` 只做了一次乘法一次加法，`#1` 效率会更高。
  
- 逆序对

  - 插入排序与逆序对数量的关系

    设 `a[n]` 与 `a[0..n-1]` 构成 $$k_n$$ 个逆序对，则逆序对数量和为 $$K = \sum_{i=1}^n k_i$$，排序 `a[0..n-1]` 对 $$k_n$$ 没有影响。
    $$
    \begin{align}
    T(n) &=
        \begin{cases}
        1                  & n = 1, \\[2ex]
        T(n-1) + \lg n + k_n & n \ne 1, \\[2ex]
        \end{cases} \\[2ex]
    T(n) &= \lg(n!) + K.
    \end{align}
    $$
    其中 $$\lg(n!)$$ 为二分搜索消耗，$$K$$ 为移动元素消耗。

    ~~~python
    ns = np.array(2 << np.arange(10, 28))
    ts = np.empty_like(ns, dtype=np.float64)
    facts = np.empty_like(ts)
    
    for i, n in enumerate(ns):
        a = np.arange(1, n + 1)
        facts[i] = np.sum(np.log2(a))
        ts[i] = insertion_sort(a)
    
    plt.plot(np.arange(ts.size), ts / (np.log2(ns) * ns), label='log')
    plt.plot(np.arange(ts.size), ts / facts , label='fact')
    plt.legend()
    plt.show()
    ~~~
  
    ![image-20220123224946817](assets/img/Introduction to Algorithms.assets/image-20220123224946817.png)
  
    随着数组长度的增加，对已排序数组的插入排序耗时与 $$\lg(n!),n \lg n$$ 接近。事实上 $$\lg(n!),n \lg n$$ 两者也很接近。$$n>300$$ 后，两者的商就小于 $$1.2$$ 了，$$n>30000$$ 后，两者的商就小于 $$1.1$$ 了。
  
    ![image-20220123230134824](assets/img/Introduction to Algorithms.assets/image-20220123230134824.png)
  
  - 给出 $$\Theta(n \lg n)$$ 的求逆序对数量的算法
  
    修改归并排序
  
    逆序对数量等于两个子数组中的逆序对数量和两个子数组之间的逆序对数量。
  
    当 `a1[i] > a2[j]` 时，表明 `a1[i..mid] > a2[j]`，所以两个子数组之间的逆序对数为出现 `a1[i] > a2[j]` 时 `mid - i` 的和。
  
    ~~~cpp
    // 递归
    
    int invasions_count(vector<int> &arr, int low, int high)
    {
        if (low >= high) return 0;
        int mid = ((high - low) >> 1) + low;
        int count = invasions_count(arr, low, mid) +
                    invasions_count(arr, mid, high);
        count += invasions_merge(arr, low, mid, high);
        return count;
    }
    
    int invasions_merge(vector<int> &arr, int low, int mid, int high)
    {
        int len1 = mid - low, len2 = high - mid;
        vector<int> a1(len1);
        vector<int> a2(len2);
        for (int i = 0; i != len1; ++i) a1[i] = arr[low + i];
        for (int i = 0; i != len2; ++i) a2[i] = arr[mid + i];
        
        int count = 0;
        // merge
        int i = 0, j = 0, k = low;
        while (i != len1 && j != len2) {
            if (a1[i] > a2[j]) {
                arr[k++] = a2[j++];
                // 只需要在这里计数即可
                count += len1 - i;
            } else {
                arr[k++] = a1[i++];
            }
        }
        while (i != len1) arr[k++] = a1[i++];
        while (j != len2) arr[k++] = a2[j++];
        return count;
    }
    ~~~
  
    ~~~cpp
    // 迭代
    
    int invasions_count(vector<int> &a)
    {
        int size = a.size();
        if (size <= 1) return 0;
        
        vector<int> b(size);
    
        int count = 0;
        for (int seg = 1; seg < size; seg <<= 1) {
            for (int start = 0; start < size; start += seg << 1) {
                int low = start;
                int mid = min(start + seg, size);
                int high = min(start + (seg << 1), size);
                int i = low, j = mid, k = low;
                while (i != mid && j != high) {
                    if (a[i] > a[j]) {
                        b[k++] = a[j++];
                        // 只需要在这里计数即可
                        count += mid - i;
                    } else {
                        b[k++] = a[i++];
                    }
                }
                while (i != mid) b[k++] = a[i++];
                while (j != high) b[k++] = a[j++];
            }
            swap(a, b);
        }
    
       	return count;
    }
    ~~~
