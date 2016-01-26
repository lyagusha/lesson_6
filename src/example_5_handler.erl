-module(example_5_handler).

-export([init/0]).
-export([handle/2]).

init()->
    {ok, undefined}.

handle({ping, Pid}, State) ->
    Pid ! pong,
    io:format("~p receive ping~n", [self()]),
    {ok, State};
handle(_, State) ->
    io:format("~p receive wrong _message~n", [self()]),
    {ok, State}.
