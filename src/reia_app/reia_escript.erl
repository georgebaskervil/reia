%%%
%%% Reia command-line interface
%%% Entry point for the reia executable
%%%

-module(reia_escript).

-export([main/1]).

-define(USAGE, "
Usage: reia [OPTIONS] [FILE]

Options:
  --ire, -i         Start interactive REPL
  -o FILE           Compile FILE to bytecode
  --help, -h        Show this help message

Examples:
  reia script.re              Run a Reia script
  reia -i                     Start interactive REPL
  reia -o script.reb script.re  Compile to bytecode
").

%% Main entry point from escript
main(Args) ->
  case parse_args(Args) of
    {ok, {ire, []}} ->
      start_ire();
    {ok, {run, [File]}} ->
      run_file(File);
    {ok, {compile, {Output, Input}}} ->
      compile_file(Input, Output);
    {ok, {help, []}} ->
      io:format(?USAGE),
      halt(0);
    {error, Reason} ->
      io:format("Error: ~s~n", [Reason]),
      io:format(?USAGE),
      halt(1)
  end.

%% Parse command-line arguments
parse_args([]) ->
  {error, "No command specified"};
parse_args(["--help" | _]) ->
  {ok, {help, []}};
parse_args(["-h" | _]) ->
  {ok, {help, []}};
parse_args(["--ire" | _]) ->
  {ok, {ire, []}};
parse_args(["-i" | _]) ->
  {ok, {ire, []}};
parse_args(["-o", Output | Rest]) ->
  case Rest of
    [Input] -> {ok, {compile, {Output, Input}}};
    _ -> {error, "Option -o requires input file"}
  end;
parse_args([File]) ->
  {ok, {run, [File]}};
parse_args(_) ->
  {error, "Invalid arguments"}.

%% Run a Reia file
run_file(File) ->
  ensure_paths(),
  case filelib:is_file(File) of
    true ->
      case reia_internal:execute_file(File) of
        ok -> halt(0);
        Error -> 
          io:format("Error: ~p~n", [Error]),
          halt(1)
      end;
    false ->
      io:format("Error: File not found: ~s~n", [File]),
      halt(1)
  end.

%% Start interactive REPL
start_ire() ->
  ensure_paths(),
  ire:start().

%% Compile a Reia file
compile_file(Input, Output) ->
  ensure_paths(),
  case filelib:is_file(Input) of
    true ->
      case reia_internal:compile(Input, Output) of
        ok -> halt(0);
        Error ->
          io:format("Compilation failed: ~p~n", [Error]),
          halt(1)
      end;
    false ->
      io:format("Error: File not found: ~s~n", [Input]),
      halt(1)
  end.

%% Ensure ebin directories are in the code path
ensure_paths() ->
  code:add_pathsa([
    "ebin",
    "lib"
  ]).
