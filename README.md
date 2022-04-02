# Overview
# git clone with submodules
```bash
git clone --recurse-submodules git@github.com:yanboyang713/DotFiles.git
```
# Git Push include submodulediles
```bash
$ cd your_submodule
$ git checkout master
<hack,edit>
$ git commit -a -m "commit in submodule"
$ git push
$ cd ..
$ git add your_submodule
$ git commit -m "Updated submodule"
```
