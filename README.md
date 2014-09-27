# cis194

Homework solutions for ADUni.org's The Structure and Interpretation of Computer Programs problem sets:

http://www.aduni.org/courses/sicp/index.php?view=cw

## Installation

On a mac:

```
brew install mit-scheme
```

If you'd like tab-completion in the REPL, follow the steps [in this Stack Overflow answer](http://stackoverflow.com/questions/11908746/mit-scheme-repl-with-command-line-history-and-tab-completion). I've added the `repl` target to the Makefile for you. Enjoy.

## How to run tests

Run the tests by running the default Makefile task:

```
~/dev/sicp (master)$ make
mit-scheme --batch-mode --eval "(set! load/suppress-loading-message? #t)" --load test/all-tests.scm --eval "(%exit (run-registered-tests))"
.

1 tests, 0 failures, 0 errors.
```

For more documentation (how to write assertions, etc.), check out [the test-manager docs](http://web.mit.edu/~axch/www/testing.html). I've stubbed `Problem_Set_01.scm` out in the `src` and `test` directories; follow this convention for future assignments.

## Branching Strategy

Branch `master` will contain tests and stubbed homework assignments only; please create a topic branch for yourself to which you'll commit your homework solutions.

## Miscellaneous Links

1. [Video lectures](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/)
1. [Paper book for purchase @ Amazon](http://www.amazon.com/Structure-Interpretation-Computer-Programs-Engineering/dp/0262510871)
1. [Link to free, online text](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-4.html)
