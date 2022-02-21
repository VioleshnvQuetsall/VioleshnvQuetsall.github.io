---
layout: post
title: Wireshark使用入门
description: >
  Wireshark入门
sitemap: false
hide_last_modified: true
categories: [network]
tags: [network]
---

0. this line will be replaced by the toc
{:toc}

[下载地址](https://www.wireshark.org/#download)

Wireshark 是一个拦截和观察网络包的工具。

### 工作原理

由于更上层的数据最终都会成为链路层的一个个帧（frame），Wireshark 接受链路层（link-layer）的数据包（packet）的副本后，经过内部的包分析工具（packet analyzer）实现包的拦截和观察。包分析工具可以识别上层协议的结构，逐渐将帧还原为更上层的形式。

![Packet sniffer structure](/assets/img/Wireshark使用.assets/image-20220117195144393.png)

### 启动 Wireshark

![Initial Wireshark Screen](/assets/img/Wireshark使用.assets/image-20220117200610814.png)

1 区显示了可供选择的接口，最经常使用的是 WLAN 和以太网。

---

![Wireshark Graphical User Interface, during packet capture and analysis](/assets/img/Wireshark使用.assets/image-20220117200938605.png)

- 命令菜单栏（文件、编辑、视图、……）；
- 捕获菜单栏，有各种图标的那一栏，可以对捕获进行各种操作；
- 过滤器栏，可以使用过滤器命令来选择某一些包进行显示，这里使用了 `ip.addr == 163.177.151.110`，就说明只显示 IP 地址为 `163.177.151.110` 的包；
- 1 区列出捕获的包的各种信息。包括序号、事件、源地址、目的地址、协议（最高层的协议）、信息等，其中序号是 Wireshark 自行标记的；
- 2 区是选择的包的头部的详细信息，包括帧的信息、IP 数据报信息以及其他协议的信息（比如 TCP 或者 UDP，如果有的话）；
- 3 区是选择的包的内容的十六进制和 ASCII 表示。

### 使用 Wireshark

1. 打开 Wireshark，选择 WLAN 接口开始捕获；

2. 启动浏览器，打开浏览器的网络监视器；

3. 访问 `https://www.wireshark.org/#download`；

4. 此时浏览器会发起 HTTP 连接，此时 Wireshark 已经捕获了这次连接；

5. 在过滤器栏输入 `http`，点击过滤器栏右侧的应用（apply）按钮；

   ![http apply](/assets/img/Wireshark使用.assets/image-20220117204359981.png)

6. 观察捕获的信息。