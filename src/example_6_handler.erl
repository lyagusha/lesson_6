-module(example_6_handler).

-behavior(example_6).

-export([init/0]).
-export([handle_call/2]).
-export([handle_cast/2]).

init()->
    {ok, undefined}.

handle_call(ping, State) ->
    io:format("~p receive ping~n", [self()]),
    Result = pong,
    {ok, Result, State};
handle_call(_, State) ->
    io:format("~p receive wrong_message~n", [self()]),
    {ok, wrong_message, State}.

handle_cast(_Msg, State) ->
    {ok, State}.
