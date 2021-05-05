-module(example_6).

%% API
-export([start/1]).
-export([stop/1]).
-export([process_init/1]).
-export([call/2]).
-export([cast/2]).

-record(state, {
    handler,
    handler_state
}).

-callback init() -> {ok, tuple()}.
-callback handle_call(any(), tuple()) -> {ok, any(), tuple()}.
-callback handle_cast(any(), tuple()) -> {ok, tuple()}.

%% API
start(Module) ->
    ok = io:format("Starting example_6~n"),
    State = #state{handler = Module},
    spawn(?MODULE, process_init, [State]).

stop(Pid) ->
    Pid ! stop.

call(Pid, Msg) ->
    _ = Pid ! {call, self(), Msg},
    receive
        {result, Res} ->
            Res
    end.

cast(Pid, Msg) ->
    _ = Pid ! {cast, Msg},
    ok.

process_init(State = #state{handler = Mod}) ->
    {ok, HandlerState} = Mod:init(),
    process_loop(State#state{handler_state = HandlerState}).

%% internal
process_loop(State = #state{handler = Mod, handler_state = HandlerState}) ->
    receive
        {call, From, Msg} ->
            {ok, Result, HandlerState2} = Mod:handle_call(Msg, HandlerState),
            _ = From ! {result, Result},
            process_loop(State#state{handler_state = HandlerState2});
        {cast, Msg} ->
            {ok, HandlerState2} = Mod:handle_cast(Msg, HandlerState),
            process_loop(State#state{handler_state = HandlerState2});
        stop ->
            ok
    end.
