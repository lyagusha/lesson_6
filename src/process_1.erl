-module(process_1).

-export([start/0]).
-export([process_loop/0]).

start() ->
    io:format("Starting process_1~n"),
    spawn(process_1, process_loop, []).

process_loop() ->
    receive
        {ping, Pid} = Msg->
            io:format("~p: receive ~p~n", [self(), Msg]),
            Pid ! pong
    end,
    process_loop().
