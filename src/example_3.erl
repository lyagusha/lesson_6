-module(example_3).

-export([start/0]).
-export([stop/1]).
-export([process_loop/0]).

start() ->
    ok = io:format("Starting example_3~n"),
    spawn(?MODULE, process_loop, []).

stop(Pid) ->
    Pid ! stop.

process_loop() ->
    receive
        {ping, Pid} = Msg ->
            ok = io:format("~p: receive ~p~n", [self(), Msg]),
            _ = Pid ! pong,
            process_loop();
        stop ->
            ok;
        Msg ->
            ok = io:format("~p: receive wrong message ~p~n", [self(), Msg]),
            process_loop()
    end.
