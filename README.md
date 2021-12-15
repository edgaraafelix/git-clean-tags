Git Clean Tags
-------

A simple way of cleaning old tags in a Git repo.

#### Setup

Navigate to any directory of your choice and ```git clone``` the repository as follows:

- ```git clone git@github.com:edgaraafelix/git-clean-tags.git```

#### Usage

Navigate to the cloned repository and run ```./clean.sh``` with the ```-p``` argument followed by the path to the repository:

- ```./clean.sh -p ~/Projects/MyApp```

#### Next...

After you clean up a repo's tags, ask your team to run the following commands for each project:

- ```git tag -d $(git tag -l) && git fetch```
