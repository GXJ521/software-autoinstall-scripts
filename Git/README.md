## Git命令

### 1. 基本命令
```bash
git init
    # 初始化本地库.
git config --global user.name "mrlapulga"
    # 初始化用户名.
git config --global user.email "mrlapulga@126.com"
    # 初始化邮箱地址.

git status
    # 查看当前版本状态（是否修改）.
git add readme.txt
    # 添加readme.txt文件至index.
git add .
    # 增加当前子目录下所有更改过的文件至index.
git commit -m 'xxx'
    # 提交.
git pull origin master              
    # 获取远程分支master并merge到当前分支
git pull --rebase origin master
    # 解决远程库与本地库不一致导致错误.
git push origin master
    # 推送本地库到远程库.
# 例如：
cd Workspace
mkdir Front-end
cd Front-end
vim README.md
git add README.md
    # 在github新建远程仓库后，执行下述命令：
git commit -m "first commit front-end code."
git remote add origin https://github.com/mrlapulga/Front-end.git
git remote -v
git pull --rebase origin master
git push origin master
git rm -r --cached .
    # 删除本地缓存.
git push -u origin master -f
    # 强制push，远程仓库可能会丢失数据.
# 例如：
git rm -r --cached .idea
    #--cached不会把本地的.idea删除
git commit -m 'delete .idea dir'
git push -u origin master
git log                                         
    # 显示提交日志.
git log -1 
    # 显示1行日志 -n为n行. 
git log -5
    # 显示5行日志.
git log --stat 
    # 显示提交日志及相关变动文件. 
git show dfb02e6e4f2f7b573337763e5c0013802e392818
    # 显示某个提交的详细内容. 
git show dfb02
    # 可只用commitid的前几位. 
git show HEAD
    # 显示HEAD提交日志.
git show HEAD^
    # 显示HEAD的父（上一个版本）的提交日志 ^^为上两个版本 ^5为上5个版本.
```

---

### 2. 其他不常用命令
```bash
git clone git://github.com/mrlapulga/LearnPython.git
    # 检出仓库.
git remote -v
    # 查看远程仓库.
git remote add [name] [url]
    # 添加远程仓库.
git remote rm [name]
    # 删除远程仓库.
git remote set-url --push [name] [newUrl]
    # 修改远程仓库.
git pull [remoteName] [localBranchName]
    # 拉取远程仓库.
git push [remoteName] [localBranchName]
    # 推送远程仓库.

# 如果想把本地的某个分支test提交到远程仓库，并作为远程仓库的master分支，或者作为另外一个名叫test的分支，如下：
git push origin test:master
    # 提交本地test分支作为远程的master分支
git push origin test:test
    # 提交本地test分支作为远程的test分支
```
