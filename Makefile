.PHONY: all compile test benchmark clean

all: compile

compile:
	rebar3 compile

escript:
	rebar3 escript

test: compile
	./_build/default/bin/reia test/runner.re

benchmark: compile
	./_build/default/bin/reia benchmarks/runner.re

clean:
	rebar3 clean
