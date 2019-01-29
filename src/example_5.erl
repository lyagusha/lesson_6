-module(example_5).

%% API
-export([start/1]).
-export([stop/1]).
-export([process_init/1]).

-record(state, {
    handler,
    handler_state
}).

%% API
start(Module) ->
    ok = io:format("Starting example_5~n"),
    State = #state{handler = Module},
    spawn(?MODULE, process_init, [State]).

stop(Pid) ->
    Pid ! stop.

process_init(State = #state{handler = Mod}) ->
    {ok, HandlerState} = Mod:init(),
    process_loop(State#state{handler_state = HandlerState}).

%% internal
process_loop(State = #state{handler = Mod, handler_state = HandlerState}) ->
    receive
        stop ->
            ok;
        Msg ->
            {ok, HandlerState2} = Mod:handle(Msg, HandlerState),
            process_loop(State#state{handler_state = HandlerState2})
    end.
