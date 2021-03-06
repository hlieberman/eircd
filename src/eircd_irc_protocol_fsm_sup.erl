-module(eircd_irc_protocol_fsm_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([start_child/2]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_child(Protocol, Address) ->
  supervisor:start_child(?MODULE, [Protocol, Address]).

init([]) ->
  Children = [
    {
      eircd_irc_protocol_fsm,
      {eircd_irc_protocol_fsm, start_link, []},
      temporary, 5000, worker, [eircd_irc_protocol_fsm]
    }
  ],
  {ok, { {simple_one_for_one, 0, 1}, Children} }.
