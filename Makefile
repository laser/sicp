all:
	mit-scheme --batch-mode --eval "(set! load/suppress-loading-message? #t)" --load test/all-tests.scm --eval "(%exit (run-registered-tests))"

repl:
	rlwrap -r -c -f $(HOME)/scheme_completion.txt mit-scheme
