### https://github.com/mwouts/jupytext
pip install jupytext --upgrade
jupyter notebook --generate-config
.jupyter/jupyter_notebook_config.py -> c.NotebookApp.contents_manager_class = "jupytext.TextFileContentsManager"

### https://github.com/jwkvam/jupyterlab-vim
jupyter labextension install jupyterlab_vim
### https://github.com/jupyterlab/jupyterlab-toc
jupyter labextension install @jupyterlab/toc
### https://github.com/lckr/jupyterlab-variableInspector
###
jupyter labextension install @oriolmirosa/jupyterlab_materialdarker

###
ipython profile create
~/.ipython/profile_default/ipython_config.py
c.TerminalInteractiveShell.editing_mode = 'vi'
