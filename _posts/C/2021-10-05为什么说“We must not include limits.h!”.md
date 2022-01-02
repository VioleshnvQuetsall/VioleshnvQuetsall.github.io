---
layout: post
title: 为什么说“We must not include limits.h!”
description: >
  看头文件时发现的
sitemap: false
hide_last_modified: true
categories: [c]
tags: [c]
---

0. this line will be replaced by toc
{:toc}

### 问题

```c
#include <dirent.h>

struct dirent *d;
d->d_name;
```

IDE 提示时出现如下字样

![image-20211105225750248](/assets/img/为什么说.assets/image-20211105225750248.png)

头文件中则是

```c
struct dirent
{
    __ino_t d_ino;
    __off_t d_off;

    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];		/* We must not include limits.h! */
};
```

### 原因

**先说结论，这句话不是给你（调用者）看的，而是给实现 `dirent.h` 的人看的。**

头文件的实现需要遵守[命名空间的规范](https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_02_02)，其中就包括全局宏和预处理常量的定义。

因为宏和常量之间的名称不能相同，而头文件中又规定了大量宏和常量，需要有一套标准规范。

比如，`aio.h` 中定义的都是以 `aio_, lio_, AIO_, LIO_` 开头的。

![image-20211105230530475](/assets/img/为什么说.assets/image-20211105230530475.png)

同时也规定了部分头文件不能包含某些头文件，`dirent.h` 就是其中之一。这可能是出于减少宏和常量的数量的考虑，不能让调用者在不知情时包含 `limits.h`，所以 `dirent.h` 不能包含 `limits.h`。

---

那为什么要在文件中特别指出呢？

因为`limits.h` 中有规定文件名的最大长度

```c
#define NAME_MAX         255	/* # chars in a file name */
```

而 `dirent.d_name[256]` 表示的是文件的名称，正需要用到 `NAME_MAX`。

本来 `256` 应该用 `NAME_MAX + 1` 表示，但是由于命名空间的规定不能这么做，只好硬编码（hardcode）256。

