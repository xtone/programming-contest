%%%-------------------------------------------------------------------
%%% @author toyota
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 5 2014 20:45
%%%-------------------------------------------------------------------
-module(yahya).
-author("toyota").

%% API
-export([is_valid/1, check_edge/3, check_character/4, list_length/1, list_length_rec/2, check_car/4, get_first_and_last_per_char/4]).

is_valid(CarList) ->
  Mid = check_character("abcdefghijklmnopqrstuvwxyz", CarList, 0, []),
  {Loop, LeftEdge, RightEdge} = check_edge(CarList, Mid, {[], [], []}).

check_edge([], _, Result) ->
  Result;
check_edge(CarList, Mid, Result) ->
  Car = hd(CarList),
  CarHead = hd(Car),
  CarTail = lists:last(Car),
  {Loop, LeftEdge, RightEdge} = Result,

  HeadIncludeMid = proplists:is_defined(CarHead, Mid),
  TailIncludeMid = proplists:is_defined(CarTail, Mid),
  if HeadIncludeMid =:= true; TailIncludeMid =:= true ->
    _Result = Result,
    throw(invalid);
    true ->
      if CarHead =:= CarTail ->
        HeadIncludeLoop = proplists:is_defined(CarHead, Loop),
        if HeadIncludeLoop =:= true ->
          _Loop = lists:keyreplace(CarHead, 1, Loop, proplists:get_value(CarHead, Loop) + 1);
          true ->
            _Loop = [{CarHead, 1}]
        end,
        _Result = {_Loop, LeftEdge, RightEdge};
        CarHead =/= CarTail ->
          HeadIncludeEdge = proplists:is_defined(CarHead, LeftEdge),
          if HeadIncludeEdge =:= true->
            _LeftEdge = lists:keyreplace(CarHead, 1, LeftEdge, [CarTail | proplists:get_value(CarHead, LeftEdge)]);
            true ->
              _LeftEdge = [{CarHead, [CarTail]}, LeftEdge]
          end,
          TailIncludeEdge = proplists:is_defined(CarTail, RightEdge),
          if TailIncludeEdge =:= true ->
            _RightEdge = lists:keyreplace(CarTail, 1, RightEdge, [CarHead | proplists:get_value(CarTail, RightEdge)]);
            true ->
              _RightEdge = [{CarTail, [CarHead]}, RightEdge]
          end,
          _Result = {Loop, _LeftEdge, _RightEdge}
      end
  end,
  check_edge(tl(CarList), Mid, _Result).

check_character(Characters, CarList, Index, Result) ->
  Char = hd(Characters),
  Mid = check_car(Char, CarList, 1, Result),
  if tl(Characters) =:= [] ->
    Mid;
    tl(Characters) =/= [] ->
      check_character(tl(Characters), CarList, Index + 1, Mid)
  end.

list_length(List) ->
  list_length_rec(List, 0).

list_length_rec([], Offset) ->
  Offset;
list_length_rec(List, Offset) ->
  list_length_rec(tl(List), Offset+1).

check_car(_, [], _, Result) ->
  Result;
check_car(Char, CarList, Index, Result) ->
  Car = hd(CarList),
  {First, Last} = get_first_and_last_per_char(Char, Car, 0, {-1, -1}),
  if Last >= 0 ->
    if First > 0, Last < length(Car) - 1 ->
      _MidState = proplists:get_value(Char, Result),
      if _MidState =:= true ->
        Mid = Result,
        throw(invalid);
        _MidState =/= true ->
          Mid = [{Char, true} | Result]
      end;
      true ->
        Mid = Result
    end;
    Last < 0 ->
      Mid = Result
  end,
  check_car(Char, tl(CarList), Index + 1, Mid).


% 列車ごとに、ある文字Aが最初に現れるのが何文字目か、最後に現れるのは何文字目かを求める
% @retval {First, Last}
get_first_and_last_per_char(_, [], _, Result) ->
  Result;
get_first_and_last_per_char(Char, Car, Index, Result) ->
  if Char =:= hd(Car) ->
    {_F, _L} = Result,
    if _F =:= -1 ->
      First = Index;
      _F =/= -1 ->
        First = _F
    end,
    if _L =/= -1, _L =/= Index - 1 ->
      Last = _L,
      throw(invalid);
      true ->
        Last = Index
    end;
    Char =/= hd(Car) ->
      {First, Last} = Result
  end,
  get_first_and_last_per_char(Char, tl(Car), Index + 1, {First, Last}).

