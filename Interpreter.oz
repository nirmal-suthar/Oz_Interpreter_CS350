declare Program SemanticStack Environment Execute ExecutionState SAS

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

Program = [[nop] [nop] [nop] [nop]] %statement in kernel language
Environment = '#' %set of mappings {X=<x>, Y=<y>}
%ss: semantic statement, s: statement in kernel lang, env: environment
SAS = '#'
SemanticStack = [ss(s:Program env:Environment)] % stack of ss(s: env: )
ExecutionState = es(st: SemanticStack sas: SAS) %es(st: sas: )
{Execute ExecutionState}