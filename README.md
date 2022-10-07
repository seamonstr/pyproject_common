# pyproject_common

Framework for creating little python projects for things like interview take-home exercises.  Provides for:
* Pre-commit hooks that do `black`, `flake8` and `mypy` before allowing commit.
* A basic pyproject.toml file if one doesn't exist.
* A Debian linux container for testing the project:
	* Build a debian linux container image with the required python files
	* Run the container on the local workstation interactively
	* Run the container non-interactively (in the case of a server)
