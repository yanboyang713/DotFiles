# Overview

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
