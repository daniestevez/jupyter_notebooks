# Assorted Jupyter notebooks by Daniel Estévez

Starting from 2020-04-25 this repository has been converted to use
[git-annex](https://git-annex.branchable.com/) to store data files.
The old version of the repository that stored all data files has been
saved as a backup in
[jupyter_notebooks_old](https://github.com/daniestevez/jupyter_notebooks_old).

To download data files you must have git-annex installed.
After cloning the repository, do

```
git remote add -f eala http://eala.destevez.net/~daniel/jupyter_notebooks.git
```

to add the remote where the data files are stored. The missing data files are
represented as broken symbolic links. Individual files can be
downloaded by using `git annex get`, as in this example:

```
git annex get fmt.all
```

To download all the data files you can do

```
git annex sync eala --content
```

