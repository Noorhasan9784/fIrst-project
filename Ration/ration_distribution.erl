-module(ration_distribution).
-compile(export_all).

start_process() ->
    spawn(?MODULE, store1, [[]]).
    
store1(Namelist) ->
    receive
        {From, {add, Name}} ->
             From ! {self(), {ok,dear_name_added},
             store1([Name|Namelist]);
        {From, {distribute, Name}} ->
           case lists:member(Name, Namelist) of
               true ->
                   From ! {self(), {ok, Ration_given}},
                   store1(list:delete(Name, Namelist));
               false ->
                   From ! {self(), not_in_ the_list}
            end;
        {From, {remove, Name}} ->
            case lists:member(Name, Namelist) of
                true ->
                    From ! {self(), {ok, removed}},
                    store1(lists:delete(Name, Namelist));
                false -> 
                    From ! {self(), not_foun},
                    store1(Namelist);
            end;
        terminate ->
            ok
    end.
    
 add(Pid, Name) ->
    Pid ! {self(), {add, Name}},
    receive
        {Pid, Msg} -> Msg
    end.
    
distribute(Pid, Name) ->
    Pid ! {self(), {distibute, Name}},
    receive
        {Pid, Msg} -> Msg
    end.
    
remove(Pid, Name) ->
    Pid ! {self(), {remove, Name}},
    receive 
        {Pid, Msg} -> Msg
    end.