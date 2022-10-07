set -e 
SUBMODULE=pyproject_common

[ -d $SUBMODULE ]

# Copy other template files & commit to github	
cp -R $SUBMODULE/template/* .
git add .
git commit -m "Adding template files"

# Set up python
[ -d ".venv" ] || {
	python -m venv .venv
	. .venv/bin/activate
	pip install --upgrade pip
	pip install poetry
	poetry install
}

# Copy precommit hooks last so the above doesn't bork
cp $SUBMODULE/pre-commit .git/hooks/
chmod ugo+x .git/hooks/pre-commit