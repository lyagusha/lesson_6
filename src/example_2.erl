-module(example_2).

-export([start/0]).
-export([process_loop/0]).

start() ->
    ok = io:format("Starting example_2~n"),
    spawn(example_2, process_loop, []).

process_loop() ->
    _ = receive
        {ping, Pid} = Msg ->
            ok = io:format("~p: receive ~p~n", [self(), Msg]),
            Pid ! pong;
        Msg ->
            io:format("~p: receive wrong message ~p~n", [self(), Msg])
    end,
    process_loop().
