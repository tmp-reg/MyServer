%%%----------------------------------------------------------------------
%%%
%%% @copyright wg
%%%
%%% @doc the simple supervisour with temporary restart strategy
%%%
%%%----------------------------------------------------------------------
-module(wg_tmp_sup).
-vsn('0.1').
-behaviour(supervisor).
-include("wg_internal.hrl").

-export([start_link/2, init/1]).

%% @doc start the supervisor
start_link(Name, Module) ->
    supervisor:start_link({local, Name}, ?MODULE, Module).

%% @doc the supervisor callback
init(Module) ->
    {ok, {{simple_one_for_one, 10, 1},
        [{undefined, {Module, start_link, []},
        temporary, 1000, worker, [Module]}]}}.
