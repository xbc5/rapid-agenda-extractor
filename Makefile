EMACS ?= emacs

# Run the ert suite headless, loading the package and every *-test.el file.
.PHONY: test
test:
	$(EMACS) --batch -L elisp -l ert \
	  $(addprefix -l ,$(wildcard tests/*-test.el)) \
	  -f ert-run-tests-batch-and-exit
