---
title: 远程架设 Jupyter notebook
description: >
  远程架设 Jupyter notebook 操作记录
sitemap: false
hide_last_modified: true
categories: [jupyter notebook]
tags: [jupyter notebook]
---

0. this line will be replaced by toc
{:toc}

### 远程架设 Jupyter notebook

~~~shell
# 安装
pip3 install Jupyter
jupyter notebook --generate-config
# output: Writing default config to: /root/.jupyter/jupyter_notebook_config.py
~~~

在 Python 中输入命令

~~~python
from notebook.auth import passwd
passwd()
~~~

会让你输入密码，这个在远程登录时会用到

~~~python
Enter password: 
Verify password: 
# output: argon2:$argon2id$v...
~~~

会得到一个字符串，需要记录下来

在 jupyter notebook 的配置文件 `jupyter notebook --generate-config` 生成的文件中修改。

~~~python
c.NotebookApp.password = 'argon2:$argon2id$v...'  # 刚刚生成的密钥
c.NotebookApp.ip= '0.0.0.0'                       # 服务器 ip，也可以是 '*'
c.NotebookApp.open_browser = False                # 禁止浏览器打开，因为是远程登录
c.NotebookApp.port = 8888                         # 自定义端口
~~~

之后在远程运行 jupyter notebook，`jupyter notebook`；本地用浏览器登录 `<远程服务器IP>:<自定义端口>`，比如 `8.123.12.66:8888`，再输入密码即可。

