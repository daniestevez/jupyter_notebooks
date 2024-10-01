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

## License

Source code in this repository is licensed under the MIT License
([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT) unless where
indicated otherwise.

Data in this repository is licensed under the CC BY 4.0 license
([LICENSE-CC-BY](LICENSE-CC-BY) or https://creativecommons.org/licenses/by/4.0/)
to the extent where this is possible. Some data in the repository is obtained
from other sources and added to the repository for convenience. This data
retains its original copyright. Other data is obtained by processing some other
data and this output might not fall under copyright law.

The vast collection of materials in this repository makes it difficult to have a
straightforward licensing scheme for the contents, but as indicated above, as a
general rule, source code is licensed as MIT and data as CC BY 4.0 whenever
possible. If you have doubts about the license of something in this repository,
please [ask in an
issue](https://github.com/daniestevez/jupyter_notebooks/issues/new/choose).
