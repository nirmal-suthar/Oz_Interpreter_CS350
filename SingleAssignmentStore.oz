declare Store
Store = {Dictionary.new}

declare Index
Index = {NewCell 0}

%==================
% Add new Key in Store
%=================
declare
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
declare
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
declare
fun {BindRefToKeyInSAS Key RefKey}
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
declare
fun {BindValueToKeyInSAS Key Val}
    CurVal = {Dictionary.get Store Key} in 
    case CurVal
        of equivalence(!Key) then {Dictionary.put Store Key Val}
        else raise incompatibleAssign(Key Val) end
    end
end
