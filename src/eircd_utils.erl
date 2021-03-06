-module(eircd_utils).

-export([join_list/2]).
-export([random_string/1, random_string/2]).
-export([get_ip_address_string/1]).
-export([timestamp/0]).
-export([binary_to_upper/1]).

-compile([{nowarn_deprecated_function, [{erlang, now, 0}]}]).

join_list(List, Separator) -> join_list(List, Separator, []).

join_list([], _, _) -> [];
join_list([H], _, Acc) -> lists:reverse([H|Acc]);
join_list([H|T], S, Acc) -> join_list(T, S, [S|[H|Acc]]).

random_string(N) ->
    Alaphbet = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
      "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
      "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"},
    random_string(N, Alaphbet).

random_string(N, Alphabet) ->
    S = lists:foldl(fun(_, Acc) -> [element(random:uniform(size(Alphabet)), Alphabet)|Acc] end, [], lists:seq(1, N)),
    list_to_binary(S).

get_ip_address_string(Address) ->
    {O1, O2, O3, O4} = Address,
    list_to_binary(io_lib:format("~b.~b.~b.~b", [O1, O2, O3, O4])).

timestamp() ->
    try
        erlang:system_time(micro_seconds)
    catch
        error:undef ->
            {Mega, Sec, Micro} = erlang:now(),
            Mega * 1000000 * 1000000 + Sec * 1000000 + Micro
    end.

binary_to_upper(B) ->
     list_to_binary(string:to_upper(binary_to_list(B))).
