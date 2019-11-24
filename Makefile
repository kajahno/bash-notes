BUILDDIR      = docs
CURRENT_DATE  ?= date -u "+%b %d, %Y"

clean:
	${INFO} "Cleaning $(BUILDDIR)..."
	-rm -rf $(BUILDDIR)

build: clean
	${INFO} "Building project..."
	# sed 's/PLC_LAST_UPDATED/$(shell $(CURRENT_DATE))/g' $(SOURCEDIR)/_themes/sphinx_rtd_theme/footer.html.template > $(SOURCEDIR)/_themes/sphinx_rtd_theme/footer.html
	# sed 's/PLC_LAST_UPDATED/$(shell $(CURRENT_DATE))/g' $(SOURCEDIR)/_themes/sphinx_rtd_theme/layout.html.template > $(SOURCEDIR)/_themes/sphinx_rtd_theme/layout.html
	@hugo --destination $(BUILDDIR)
	${INFO} "Build finished"

serve:
	${INFO} "Spinning up local server..."
	@hugo server -D

test:
	${INFO} "Running html tests..."
	@./bin/htmltest $(BUILDDIR)

.PHONY: help Makefile clean build serve test

# Cosmetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

# Shell Functions
INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

