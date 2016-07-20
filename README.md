# Phage lab

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org:/repo/mikheyev/phage-lab)

This is an interactive tutorial teaching the principles of next-generation data analysis using a re-sequencing experiment.

You can launch it by clicling on the "Launch Binder" badge above. This will launch Binder and build a virutal environment (takes a few minutes), after which you can interactively analyze data.

Alternatively, on Mac and Linux you can [download](https://github.com/mikheyev/phage-lab/archive/master.zip) this repository, unzip it and go into the `phage-lab-master` folder you created. You can then install the environment using the [Miniconda](http://conda.pydata.org/miniconda.html) package manager in your computer's terminal. Make sure you can actually see the `environment.yml` file in your current path before you run these commands.

	conda install jupyter ipython
	conda env create -f environment.yml
	jupyter notebook

This should open the same environment, but locally.

If you ever need to reload the environment later, you can run `source activate phage-lab` and run `jupyter notebook` to restart the notebook. 