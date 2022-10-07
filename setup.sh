set -e 

# Copy precommit hooks
cp pyproject_common/pre-commit .git/hooks/
# Set up python
[-d ".venv"] || {
	 python -m env .venv
	. .venv/bin/activate
	pip install --upgrade pip
	pip install poetry
	poetry install
}

# Copy other template files & commit to github	
for i in ls $SUBMODULE/template/*; do
	if cp -n $SUBMODULE/template/$i .; then
		git add $i
	fi
done

# Finally, docker setup
[-d Docker] || {
	cp -R $SUBMODULE/Docker .
	git add Docker

}

git commit -m "Adding template files"