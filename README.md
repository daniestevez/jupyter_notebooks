# jupyter_notebooks
Assorted Jupyter notebooks by Daniel Estévez

This git repository is huge, and most people will only be interested in part of it.

Individual Jupyter notebooks can be downloaded by using the "Raw" button when viewing the
notebook (right click the "Raw" button and choose "Save link as..." is advised).

Complete folders can be downloaded using `svn` as indicated [here](https://stackoverflow.com/questions/7106012/download-a-single-folder-or-directory-from-a-github-repo/18194523#18194523).
Basically, navigate to the folder you wish to download, replace `tree/master` with `trunk` and use that URL to do an `svn checkout`.

Example: To download only the `eshail2` folder, the Github URL is `https://github.com/daniestevez/jupyter_notebooks/tree/master/eshail2`, so you
should do

```
svn checkout https://github.com/daniestevez/jupyter_notebooks/trunk/eshail2
```

