-module(process_3).

-export([start/0]).
-export([stop/1]).
-export([process_loop/0]).

start() ->
    io:format("Starting process_3~n"),
    spawn(?MODULE, process_loop, []).

stop(Pid) ->
    Pid ! stop.

process_loop() ->
    receive
        {ping, Pid} = Msg ->
            io:format("~p: receive ~p~n", [self(), Msg]),
            Pid ! pong,
            process_loop();
        stop ->
            ok;
        Msg ->
            io:format("~p: receive wrong message ~p~n", [self(), Msg]),
            process_loop()
    end.
