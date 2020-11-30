declare Store Index RetrieveFromSAS BindValueToKeyInSAS BindRefToKeyInSAS
Store = {Dictionary.new}
Index = {NewCell 0}

%==================
% Add new Key in Store
%=================
fun {AddKeyToSAS}
    Index := @Index + 1
    {Dictionary.put Store @Index equivalence(@Index)}
    @Index
end

%==================
% Retrieves Value from the key
% (1) retrieves recusively if Value is [ref]
% (2) returns Value if it is [determined/equivalence]
%=================
fun {RetrieveFromSAS Key}
    Val = {Dictionary.get Store Key} in
    case Val
        of equivalence(!Key) then Val
        [] ref(X) then {RetrieveFromSAS X}
        else Val
    end
end

%==================
% Binds Ref to the key in Store after checking
% (1) Value corresponding to Key is [equivalence]
%=================
proc {BindRefToKeyInSAS Key RefKey}
    Val = {Dictionary.get Store Key} in 
    case Val
        of equivalence(!Key) then {Dictionary.put Store Key ref(RefKey)}
        else raise incompatibleAssign(Key Val) end
    end
end

%==================
% Binds Value to the key in Store after checking
% (1) Value corresponding to Key is [equivalence]
%=================
proc {BindValueToKeyInSAS Key Val}
    CurVal = {Dictionary.get Store Key} in 
    case CurVal
        of equivalence(!Key) then {Dictionary.put Store Key Val}
        else raise incompatibleAssign(Key Val) end
    end
end


fun {UnionList X Y}
    case X
    of nil then Y
    [] H|T then H|{Filter {UnionList T Y} fun{$ A} A \= H end}
    end
end


proc {PrintAll}
    {Browse 'Printing Single Assigment Store:'}
    {Browse {Dictionary.entries Store}} 
    {Browse 'Done Printing Single Assigment Store'}
end