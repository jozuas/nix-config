%%--------------------------------------------------------------------
%% @doc
%% TODO
%% @end
%%--------------------------------------------------------------------
-module(todo).

-behaviour(gen_server).

-include_lib("kernel/include/logger.hrl").

%% API
-export([start_link/0]).
%% gen_server callbacks
-export([init/1, handle_continue/2, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).

-record(state, {todo = "TODO" :: string()}).

%%====================================================================
%% API
%%====================================================================

%%--------------------------------------------------------------------
%% @doc
%% TODO
%% @end
%%--------------------------------------------------------------------
-spec start_link() -> {ok, pid()} | ignore | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%====================================================================
%% gen_server callbacks
%%====================================================================

%% @private
init([]) ->
    {ok, #state{}, {continue, init}}.

%% @private
handle_continue(init, State) ->
    {noreply, State}.

%% @private
handle_call(Msg, _From, State) ->
    log_unhandled(unhandled_call, Msg),
    {reply, ok, State}.

%% @private
handle_cast(Msg, State) ->
    log_unhandled(unhandled_cast, Msg),
    {noreply, State}.

%% @private
handle_info(Msg, State) ->
    log_unhandled(unhandled_info, Msg),
    {noreply, State}.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

log_unhandled(Type, Msg) ->
    ?LOG_WARNING(#{what => todo,
                   result => Type,
                   details => Msg}).
