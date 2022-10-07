# pyproject_common

Framework for creating little python projects for things like interview take-home exercises.  Provides for:
* A setup section to set up a new project.
* Pre-commit hooks that do `black`, `flake8` and `mypy` before allowing commit.
* A basic pyproject.toml file if one doesn't exist.
* A Debian linux container for testing the project:
	* Build a debian linux container image with the required python files
	* Run the container on the local workstation interactively
	* Run the container non-interactively (in the case of a server)

To get started with a project "my-cat-project", copy the following into a shell file and run it:
```bash
set -e

mkdir my-cat-project
cd my-cat-project
git init
git submodule add https://github.com/seamonstr/pyproject_common
git commit -m "Adding submodule"
cat <<- EOF > Makefile
    include ./pyproject_common/makefile-include
EOF
git add Makefile && git commit -m "Adding makefile"
make setup
```