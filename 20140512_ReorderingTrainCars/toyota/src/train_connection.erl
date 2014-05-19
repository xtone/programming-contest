%%%-------------------------------------------------------------------
%%% @author toyota
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 5 2014 21:35
%%%-------------------------------------------------------------------
-module(train_connection).
-author("toyota").

-record(trains, {id, cars=[]}).

%% API
-export([train_list/1,last/1]).
-export([foo/1, foo1/3, foo2/4, piyo/2, fuga/4, add_train_list/3, get_train_rest/3]).


hoge(List) ->
  [get_train_rest(X, [], List) || X <- List].

foo(List) ->
  foo1(hd(List), tl(List), []).

foo1(Head, Rest, Current) ->
  % io:format("foo1: Head=~p, Rest=~p, Current=~p~n", [Head, Rest, Current]),
  if Current =:= [] ->
    foo1(hd(Rest), tl(Rest), [[Head]]);
    Current =/= [] ->
      if Rest =:= [] ->
        foo2(Head, hd(Current), tl(Current), []);
        Rest =/= [] ->
          foo1(hd(Rest), tl(Rest), foo2(Head, hd(Current), tl(Current), []))
      end
  end.

foo2(Head, List, Rest, Result) ->
  % io:format("foo2: Head=~p, List=~p, Rest=~p, Result=~p~n", [Head, List, Rest, Result]),
  if Rest =:= [] ->
    Result ++ piyo(Head, List);
    Rest =/= [] ->
      foo2(Head, hd(Rest), tl(Rest), Result ++ piyo(Head, List))
  end.

last([H|[]]) -> H;
last([_|T]) -> last(T);
last(_) -> ng.



piyo(Add, List) ->
  [[Add|List] | fuga(Add, [hd(List)], tl(List), [])].

fuga(Add, Head, Tail, Current) ->
  if Tail =:= [] ->
    Current ++ [Head ++ [Add]];
    Tail =/= [] ->
      fuga(Add, Head ++ [hd(Tail)], tl(Tail), Current ++ [Head ++ [Add] ++ Tail])
  end.

train_list(TrainStringList) ->
  add_train_list(TrainStringList, [], 1).

add_train_list(TrainStringList, TrainList, Index) ->
  if TrainStringList =:= [] ->
    TrainList;
    TrainStringList =/= [] ->
      add_train_list(tl(TrainStringList), TrainList ++ [#trains{id=Index, cars=hd(TrainStringList)}], Index+1)
  end.

get_train_rest(Head, HeadList, TailList) ->
  if Head =:= hd(TailList) ->
    HeadList ++ tl(TailList);
    Head =/= hd(TailList) ->
      if tl(TailList) =:= [] ->
        ng;
        tl(TailList) =/= [] ->
          get_train_rest(Head, HeadList ++ [hd(TailList)], tl(TailList))
      end
  end.




