---
layout: post
title: Git 使用笔记
description: >
  学习 Git 时所做的笔记
sitemap: false
hide_last_modified: true
categories: [other]
tags: [other]
---

0. this line will be replaced by toc
{:toc}

# Git 使用笔记

### Git简介

Git是目前世界上最先进的分布式版本控制系统。

Git能做到

- 记录文件改动
- 协作编辑

### Git使用

#### 初始化

```shell
git config --global user.name "Name"
git config --global user.email "email@example.com"
```

其中`"Name"` `"email@example.com"`换成自己的

#### 仓库操作（repository）

Git仓库中包含很多文件，所有文件都可以被Git管理起来，每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原。

###### 创建仓库

```shell
mkdir test
cd test
git init
```

###### 查看仓库状态

```shell
git status
# display: branch; changes not committed;
```

###### 查看历史记录

```shell
git log [--pretty={oneline}] [--graph] [--abbrev-commit]
# display: commit history (id, head, author, date, change)
```

###### 版本回退

```shell
git reset --hard [id, HEAD^]
# id: commit id
# HEAD^: move forward
# display: HEAD position

git reflog
# display command history
```

#### 文件操作

###### 添加文件

```shell
# git add <filename>
git add readme.txt
```

Git无法管理没有被添加的文件

###### 提交文件

```shell
# git commit -m <message>
git commit -m "wrote a readme" # -m 后接说明
# display: file changed; insertions; changes; 
```

一个`commit`之前可以有多个`add`，可以一次提交多个文件

###### 查看文件变化

```shell
# git diff <filename>
git diff readme.txt
# display: changes
```

###### 放弃修改

修改必须没有推送到远程

```shell
# git checkout -- <filename>
git checkout -- readme.txt
# if file in stage: to stage version
# else: to branch version
```

```shell
# git reset [id, HEAD] <filename>
git reset HEAD readme.txt
# move stage to working directory
```

###### 删除文件

```shell
# git rm <filename>
git rm readme.txt
```

从版本库中删除文件，与`git add`相反

#### 远程

###### 关联仓库

```shell
# git remote add <remote repo name> <address>
# default: <remote repo name>: origin
# <address>: git@<server-name>:<path>/<repo-name>.git
```

###### 查看仓库

```shell
git remote [-v]
# display: remote repo name; author
```

###### 推送

```shell
# git push -u <remote repo name> <branch>
# default: git push -u origin master
```

###### 拉取

```shell
# git clone <address>
# git pull <remote> <branch>
# git branch --set-upstream-to=origin/<branch> <branch>
```

###### 删除仓库

```shell
# git remote rm <remote repo name>
```

删除本地仓库和远程仓库的关联

#### Git结构

Git目录下有两个区域：工作区（Working Directory）、版本库（Repository）

- 工作区就是我们看到的文件储存的地方，也就是当前版本情况下的文件

- 版本库中包括暂存区（stage）、分支（branch）和指针（HEAD）
  - `git add`将更改添加到暂存区
  - `git commit`会把暂存区的更改提交到当前分支

#### 分支操作

`HEAD`会指向当前分支
每次提交，`master`分支都会延长一步

###### 创建分支

```shell
# git branch <branch>
git branch dev


# create and switch
# git checkout -b <branch>
git checkout -b dev
# git switch -c <branch>
git switch -c dev
```

###### 查看分支

```shell
git checkout
# display: branches
```

###### 切换分支

通过改变`HEAD`指向的分支完成

```shell
# git checkout <branch>
git checkout master
# git switch <branch>
git switch master
```

###### 合并分支

```shell
# git merge <to be merged>
git merge [--no-ff] dev
```

###### 删除分支

```shell
# git branch -d <branch>
# git brach -D <branch>
# -D: 强制删除
git branch -d dev
```

###### 保存现场

```shell
# 保存
git stash
# 查看
git stash list
# 还原
git stash apply [id]
# 删除
git stash drop
# 还原且删除
git stash pop
```

###### 变基

```shell
git rebase
```

#### 标签

```shell
# 创造标签
# git tag <tag name> [commit id]
# git tag -a <tag name> -m <annotation> [commit id]
git tag v1.0

# 查看标签
git tag
# git show <tag name>
git show v1.0

# 删除标签
# git tag -d <tag name>
git tag -d v1.0
# 远程删除
# git push <remote repo name> :refs/tags/<tag name>

# 推送
# git push <remote repo name> <{tag name, --tags}>

```



