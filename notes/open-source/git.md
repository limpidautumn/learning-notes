# git

已熟练掌握。

## commit

Prompt:

```txt
Read the Staged changes and draft a commit message.

Requirements: Follow the template and keep it as concise as possible. Omit sections that do not apply. Use American English.
<type>(<scope>): <short description>
<detailed body: explain the reason, content, and impact of the change>
<footer: related issues or breaking changes>

Note: Refer to previous commit messages. There are new changes in the staging area; please review the modifications again.
```

## merge
```bash
# 准备工作
git status  # 确保工作区干净
git fetch origin  # 获取远程最新信息
git switch main  # 切换到目标分支
git pull origin main  # 更新

# 执行合并
git merge feat/foo
# 参数:
# --no-ff 强制生成合并提交, 保留历史
# --ff-only 只允许快进合并
# --squash 压缩成一个普通提交, 不保留历史

# 处理冲突
git status
vim <file>  # 编辑冲突文件, 保留正确内容
git add <file>
git commit

git merge --abort  # 放弃合并

# 清理分支
git branch -d feat/foo
git push origin --delete feat/foo
```
