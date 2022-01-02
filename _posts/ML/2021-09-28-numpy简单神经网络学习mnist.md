---
layout: post
title: 用numpy实现最简单的前馈神经网络——正向网络建立篇
description: >
  正向网络建立
sitemap: false
hide_last_modified: true
categories: [ml]
tags: [ml]
related_posts:
  - _posts/ML/2021-09-28-numpy简单神经网络.md
  - _posts/ML/2021-09-28-numpy反向神经网络学习mnist.md
  - _posts/ML/2022-01-01-卷积层和池化层的实现.md
---

0. this line will be replaced by toc
{:toc}

根据[上一篇文章]({% post_url /ML/2021-09-28-numpy简单神经网络 %})，来构建神经网络吧

1. 明确**输入和输出**
2. 选择合适的**各种函数**
3. 用**矩阵**和**激活函数**建立起从输入到输出的**拟合函数**
4. 用**正向传播或反向传播**获得**损失函数**的偏导数（注意对一定的数据集来说自变量为$\bold{W}$，$\bold{A}$固定）
5. 用**梯度下降法**努力使**损失函数**最小

## mnist分析（输入分析）

### 下载

在[这里](http://yann.lecun.com/exdb/mnist/)下载mnist数据集

关于mnist的详细说明在其他人的文章里有

### 说明

`images`前16个字节包含了数据的说明，之后的所有字节以$784$字节为一组，是一个个$28\times28$像素的图像，像素为一字节的灰度像素

`labels`前8个字节包含了数据的说明，之后的所有字节以$1$字节为一组，是一个个对应着`images`中图像的数字

### 加载

以下函数的关键点在于`np.fromfile()`以及`dtype, offset`参数

```python
import numpy as np

from os import listdir
from typing import Dict, NoReturn

S = 784               # area of image
C = 28                # edge length of image

def load_data(dir_path: str) -> Dict[str, np.ndarray]:
    """
    加载图像和标签
    load images and labels
    :param dir_path: directory that contains training files and test files
    """
    resource = {}
    file_names = listdir(dir_path)
    for file_name in file_names:
        full_path = path.join(dir_path, file_name)
        name, _ = path.splitext(file_name)
        if "images" in name:
            images = np.fromfile(full_path, dtype=np.uint8, offset=16)
            resource[name] = images.reshape(images.size // S, S)
        elif "labels" in name:
            labels = np.fromfile(full_path, dtype=np.uint8, offset=8)
            resource[name] = labels
    return resource

# images.shape == (60000, 784)
# labels.shape == (10000, )
```

### 显示

```python
from PIL import Image

def display_images(resource, row: int, column: int,
                   interval: slice = slice(None, None, None)) -> NoReturn:
    """
    将多个图像显示在一张图像上
    :param row: 行数
    :param column: 列数
    :param interval: 图像区间
    """
    images = Image.new("L", (column * C, row * C))
    resource = resource["t10k-images"][interval]
    for i in range(column):
        for j in range(row):
            index = i * row + j
            array = resource[index].reshape(C, C)
            img = Image.fromarray(array)
            images.paste(img, (i * 28, j * 28))
    images.show()   # 效果如下
```

![image-20210908191817746](C:\Users\Monika\AppData\Roaming\Typora\typora-user-images\image-20210908191817746.png)

## 输出分析

显然，输出是10个数字中的一个，也就是预测结果。但是一个结果难以使用损失函数确定拟合程度，所以我们希望**输出是一个长度为10的向量，包含了每个数字的预测概率**。

通过普通的矩阵函数产生的输出不一定是概率（就是相加为1且没有负数），可以通过`softmax()`矫正
$$
softmax(e_i)=\frac{e_i}{\sum_i{e}} \\
$$

```python
def softmax(x: np.ndarray) -> np.ndarray:
    t = np.exp(x - x.max())
    y = np.sum(t, axis=1).reshape(t.shape[0], 1)
    return t / y
```

由输出的概率和标签，通过交叉熵损失函数算出损失

```python
def cross_entropy_error(result: np.ndarray, labels: np.ndarray) -> np.ndarray:
    """
    交叉熵损失函数
    :param result: 长度为10的向量，包含每个数字的预测概率
    :param labels: 图像的标签，即图像的真实数字
    """
    return -np.sum(np.log(result[np.arange(labels.size), labels] + 1e-7))
```

## 拟合函数建立

### 激活函数

由于计算过程中可能会出现一定程度的上溢或下溢，并且数字过大也会影响计算

可以使用值域在$(0,1)$的`sigmoid()`，同时它的导数也很好计算
$$
sigmoid(x) = \frac{1}{1+e^{-z}}. \\
sigmoid(x) \in (0,1) \\
sigmoid'(x) = \frac{e^{−z}}{(1+e^{−z})^2} = (1-sigmoid(x)) \cdot sigmoid(x)
$$


```python
def sigmoid(x: np.ndarray) -> np.ndarray:
    return 1 / (1 + np.exp(-x))

def derivative_sigmoid(x: np.ndarray) -> np.ndarray:
    y = sigmoid(x)
    return (1 - y) * y
```

### 拟合函数

只是演示代码，并不能一定运行

```python
def predict(input_images: np.ndarray, layer_count: int, W: np.ndarray, B: np.ndarray) -> np.ndarray:
    """
    获得预测结果的概率
    obtain the probabilities of results (namely 0-9)
    :param W: 矩阵数组
    :param B: 偏置数组
    :return: 预测结果概率
    """
    layer = input_images
    for i in range(layer_count):
        layer = sigmoid(layer @ W[i] + B[i])
    layer = soft_max(layer)
    return layer

# 如果a, b都是np.ndarray
# 那么
# a.dot(b)
# np.dot(a, b)
# a @ b
# 都代表矩阵乘法
```

`input_images`就是待预测图像（$28 \times 28$字节），`layer_count`是神经网络层数，`W`是权重也就是矩阵函数，`B`是偏置

这样就完成了一次预测，当然最后的代码会复杂很多

## 正向计算梯度

只是演示代码，并不能一定运行

```python
def numerical_gradient(input_images: np.ndarray,
                       w_grad: np.ndarray,
                       b_grad: np.ndarray) -> NoReturn:
    """
    正向求梯度
    forward gradient
    :param step_length: 训练步长，学习率 learning rate
    """
    h = 1e-5         # 求偏导数需要的微小量
    for i in range(W.size):
        for j in range(W[i].size):
            # 这里就是用偏导数定义求偏导数
	        t = W[i, j]

            W[i, j] = t - h
            f1 = loss(predict())
            W[i, j] = t + h
            f2 = loss(predict())

        	w_grad[i, j] = (f2 - f1) / (2 * h)

        W[i, j] = t
	
    for i in range(B.size):
        for j in range(B[i].size):
	        t = B[i, j]

            B[i, j] = t - h
            f1 = loss(predict())
            B[i, j] = t + h
            f2 = loss(predict())

        	b_grad[i, j] = (f2 - f1) / (2 * h)

        B[i, j] = t
```

`w_grad`是权重的梯度，`b_grad`是偏置的梯度，这样就用梯度下降法了

## 梯度下降

```python
learning_rate = 0.02

W -= w_grad * learning_rate
B -= b_grad * learning_rate
```

完成一次梯度下降！

多次重复即可提高拟合度

> 由于正向求梯度，该方法非常缓慢，可能需要3-4天才能有80%-90%的准确率
>
> 下一篇会介绍反向求梯度，可以在十几分钟内达到90%的准确率

## 最终代码

[feedforward-mnist](https://github.com/VioleshnvQuetsall/feedforward-mnist)

我也是第一次用github，只放了代码