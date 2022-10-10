SUBMODULE=pyproject_common

if [[ ! -d $SUBMODULE ]]; then
	echo $SUBMODULE not found.
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
poetry add pytest
poetry install

# Copy other template files  - note -i for idempotency safety
cp -Ri $SUBMODULE/template/. .

# Append pyproject.toml extras
cat $SUBMODULE/pyproject.toml.append >> pyproject.toml

# commit to github
if git add .; then
  git commit -m "Adding template files"
else
	echo "Nothing to add."
fi

# Copy precommit hooks last so the above doesn't bork
cp $SUBMODULE/pre-commit .git/hooks/
chmod ugo+x .git/hooks/pre-commit
