SUBMODULE=pyproject_common

if [[ ! -d $SUBMODULE ]]; then
	echo $SUBMODULE not found.
fi

# Copy other template files & commit to github - note -i for idempotency safety
cp -Ri $SUBMODULE/template/. .
if git add .; then
  git commit -m "Adding template files"
else
	echo "Nothing to add."
fi

# Set up python & poetry
[ -d ".venv" ] || {
	python -m venv .venv
}

. .venv/bin/activate
pip install --upgrade pip
pip install poetry
poetry add black
poetry add pyproject-flake8
poetry add mypy
poetry install

# Copy precommit hooks last so the above doesn't bork
cp $SUBMODULE/pre-commit .git/hooks/
chmod ugo+x .git/hooks/pre-commit