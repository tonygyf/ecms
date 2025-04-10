# ecms
 电商系统
2025 软件工程实训
https://github.com/tonygyf/ecms
Git 使用说明
（1）Fork 仓库

alt text

单击 Fork 按钮，将在你的用户名下创建一个仓库副本，比如 https://github.com/你的名字/ecms

（2）将远程仓库 Clone 到本地

# Clone  fork的仓库到本地并进入 项目文件夹
➜  git clone https://github.com/你的名字/ecms
➜  cd ecms
3）创建本地分支

你需要创建一个新的分支来开发代码

# 创建并切换到一个名为 my-cool-staff 的分支
(my-cool-staff换成你自己的名字，下文同理)

➜ eg:  git checkout -b  my-cool-staff
4）编码

5）提交

git add .
git commit -m "一段对你修改内容的描述"
6）保持本地仓库最新 在向原仓库发起 Pull Request 合入代码之前，需要同步原仓库最新的代码。

首先通过 git remote 查看当前远程仓库的名字。

➜  git remote -v

origin    https://github.com/USERNAME/ecms (fetch)
origin    https://github.com/USERNAME/ecms (push)
这里命名为 origin 的远程仓库是之前 Fork 到自己用户名下的仓库。

接下来需要创建一个原始仓库的远程主机，命名为 upstream。

➜  git remote add upstream https://github.com/tonygyf/ecms
➜  git remote -v

origin    https://github.com/USERNAME/Paddle.git (fetch)
origin    https://github.com/USERNAME/Paddle.git (push)
upstream     https://github.com/tonygyf/ecms (fetch)
upstream     https://github.com/tonygyf/ecms (push)
获取原始仓库的最新代码并更新当前分支。

➜  git fetch upstream
➜  git pull upstream master
7）Push 到远程仓库

将本地的修改推送到 GitHub 上。如果遇到冲突问题，可以参考 GitHub 文档 来解决。

➜  git push origin my-cool-stuff
8）提交 Pull Request（PR）合入代码

打开（https://github.com/你的名字/ecms）页面，并切换到所建分支，然后单击 Compare & pull request 按钮。 alt text

选择目标分支:

alt text

添加必要的评论信息，然后单击 Create pull request 按钮。

在这里进行测试
@tonygyf : Hello

@你的用户名： 随便输入内容
