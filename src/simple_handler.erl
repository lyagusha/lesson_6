-module(simple_handler).

-export([handle/1]).

handle(Msg) ->
    case Msg of
        {ping, Pid} ->
            io:format("~p receive ping~n", [self()]),
            Pid ! pong;
        _ ->
            wrong_message
    end,
    ok.
