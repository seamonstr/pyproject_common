# pyproject_common

Framework for creating little python projects for things like interview take-home exercises.  Provides for:
* A setup section to set up a new project.
* Pre-commit hooks that do `black`, `flake8` and `mypy` before allowing commit.
* A basic Poetry project
* A Debian linux container for testing the project:
	* Build a debian linux container image with the required python files
	* Run the container on the local workstation interactively
	* Run the container non-interactively (in the case of a server)
* Git initialisation and some initial commits

To get started with a project, copy the following into a shell file and run it with your desired project name as an argument (`bash project.sh mynewprojectwithcats`). Note it's not posix compliant, so Bash in posix-mode (ie. `sh`) may not work.

```bash
#! /bin/bash

if [[ $# -ne 1 ]]; then
  echo "Expected one argument"
  exit 1
fi

PROJECT_NAME=$1
if [[ -d $PROJECT_NAME ]]; then
  echo "Directory $PROJECT_NAME already exists."
fi

if  [[ ! ( -x "$(command -v poetry)" && -x "$(command -v python)" ) ]]; then
  echo "Python or poetry not installed"
fi

set -e

poetry new --src $PROJECT_NAME
cd $PROJECT_NAME

git init
git submodule add https://github.com/seamonstr/pyproject_common
git commit -m "Adding submodule"
cat <<- EOF > Makefile
    include ./pyproject_common/makefile-include
EOF
git add Makefile && git commit -m "Adding makefile"
make setup

```
