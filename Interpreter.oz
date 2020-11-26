\insert 'Unify.oz'

proc {Execute ExecStack} 
    case ExecStack of nil then skip
    [] es(st: SemStack sas: XSAS) then
        case SemStack of nil then skip
        [] TopSemStack|RemSemStack then
            case TopSemStack of nil then skip
            [] ss(s: Statement env: Env) then 
                case Statement of nil then skip
                [] [nop] then 
                    {Browse 'skip statement'} 
                    {Execute es(st: RemSemStack sas:XSAS)}
                [] [var ident(X) S] then Key = {AddKeyToSAS} in
                    {Browse "Variable creation"}
                    {Execute es(st: ss(s: S env: {AdjoinAt Env X Key})|RemSemStack sas)}
                [] S1|S2 then 
                    % {Browse S1} 
                    {Execute es(st: ss(s:S1 env:Env)|ss(s:S2 env:Env)|RemSemStack sas:XSAS)}
                else {Browse 'Error: Statement invalid'} skip
                end
            else {Browse 'Error: TopSemStack invalid'} skip
            end
        else {Browse 'Error: SemStack invalid'} skip
        end
    else {Browse 'Error: ExecStack invalid'} skip
    end
end
