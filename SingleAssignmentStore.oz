declare Store
Store = {Dictionary.new}

%==================
% Retrieves Value from the key
% (1) retrieves recusively if Value is [ref]
% (2) returns Value if it is [determined/equivalence]
%=================
fun {RetrieveFromSAS Key}
    Val = {Dictionary.get Store Key} in
    case Val
        of equivalence(_) then Val
        [] ref(X) then {RetrieveFromSAS X}
        else Val
    end
end

%==================
% Binds Ref to the key in Store after checking
% (1) Value corresponding to Key is [equivalence]
%=================
fun {BindRefToKeyInSAS Key RefKey}
    Val = {Dictionary.get Store Key} in 
    case Val
        of equivalence(_) then {Dictionary.put Store Key ref(RefKey)}
        else raise incompatibleAssign(Key Val) end
    end
end

%==================
% Binds Value to the key in Store after checking
% (1) Value corresponding to Key is [equivalence]
%=================
fun {BindValueToKeyInSAS Key Val}
    Val = {Dictionary.get Store Key} in 
    case Val
        of equivalence(_) then {Dictionary.put Store Key Val}
        else raise incompatibleAssign(Key Val) end
    end
end
