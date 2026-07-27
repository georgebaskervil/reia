#!/usr/bin/env escript
%%! -smp enable

%% Reia compilation script for rebar3
%% Compiles .re files to .reb (Reia bytecode)

main(_Args) ->
  compile_reia_files(),
  halt(0).

compile_reia_files() ->
  % Compile builtins to ebin/
  compile_directory("src/builtins", "ebin"),
  % Compile core to ebin/  
  compile_directory("src/core", "ebin"),
  % Compile lib files to lib/
  compile_directory("lib", "lib").

compile_directory(InputDir, OutputDir) ->
  case filelib:wildcard(InputDir ++ "/*.re") of
    [] ->
      ok;
    Files ->
      ensure_output_dir(OutputDir),
      lists:foreach(fun(File) -> compile_reia_file(File, OutputDir) end, Files)
  end.

compile_reia_file(InputFile, OutputDir) ->
  BaseName = filename:basename(InputFile, ".re"),
  OutputFile = filename:join(OutputDir, BaseName ++ ".reb"),
  Cmd = io_lib:format("./bin/reiac -o ~s ~s", [OutputFile, InputFile]),
  io:format("Compiling: ~s -> ~s~n", [InputFile, OutputFile]),
  case os:cmd(Cmd) of
    [] -> 
      io:format("  ✓ Success~n");
    Error -> 
      io:format("  ⚠ Warning: ~s~n", [Error])
  end.

ensure_output_dir(Dir) ->
  case filelib:is_dir(Dir) of
    true -> ok;
    false -> file:make_dir(Dir)
  end.
