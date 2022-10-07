set -e 
SUBMODULE=pyproject_common

[ -d $SUBMODULE ]

# Copy precommit hooks
cp $SUBMODULE/pre-commit .git/hooks/
chmod ugo+x .git/hooks/pre-commit

# Copy other template files & commit to github	
for i in $(ls $SUBMODULE/template); do
	echo Copying $i
	if cp -n $SUBMODULE/template/$i . ; then
		git add $i
	fi
done

# Set up python
[ -d ".venv" ] || {
	python -m venv .venv
	. .venv/bin/activate
	pip install --upgrade pip
	pip install poetry
	poetry install
}

# Finally, docker setup
[ -d Docker ] || {
	cp -R $SUBMODULE/docker .
	git add docker
}

git commit -m "Adding template files"
