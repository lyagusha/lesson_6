-module(example_4).

-export([start/1]).
-export([stop/1]).
-export([process_loop/1]).

-record(state, {
    handler
}).

start(Module) ->
    io:format("Starting example_4~n"),
    State = #state{handler = Module},
    spawn(?MODULE, process_loop, [State]).

stop(Pid) ->
    Pid ! stop.

process_loop(State = #state{handler = Mod}) ->
    receive
        stop ->
            ok;
        Msg ->
            ok = Mod:handle(Msg),
            process_loop(State)
    end.
