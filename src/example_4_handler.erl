-module(example_4_handler).

-export([handle/1]).

handle(Msg) ->
    _ = case Msg of
        {ping, Pid} ->
            ok = io:format("~p receive ping~n", [self()]),
            Pid ! pong;
        _ ->
            wrong_message
    end,
    ok.
