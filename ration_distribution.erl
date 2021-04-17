-module(chattwo).
-compile(export_all).


start_machine() ->
    spawn(?MODULE, reply_from_machine, []).
    
ask_machine(Pid,Question) ->
    Pid ! {self(), Question},
    receive
        {Pid, Answer} -> Answer
    end.
    
    
reply_from_machine() ->
    receive
        {from, {"Who are U?"}} ->
            from ! {self(), "I am robot to Answer Your Question"};
        {from, {"how r u?"}} ->
            from ! {self(), "I am good hope u are also doing good"};
        {from, {"how can u help"}} ->
            from ! {self(), "I can help you i way u want me to ask question"};
        {from, {"your specific working field"}} ->
            from ! {self(), "I am specifically working for the type of services we are providing in our organisation"};
        {from, {_Question}}->
            from ! {self(), "sorry! I don't know that"}
    end,
    reply_from_machine().