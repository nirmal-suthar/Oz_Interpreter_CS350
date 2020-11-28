\insert 'Unify.oz'
%==================
% Takes the AST as input, and output the 
% sequence of execution states during the 
% execution of the statement.
% The argument to Execute are,
% (1) SemStack - Semantic Stack
% (2) SAS - Single assignment Store
%=================
proc {Execute SemStack SAS} 
    case SemStack of nil then skip
    [] TopSemStack|RemSemStack then
        case TopSemStack of nil then skip
        [] ss(s: Statement env: Env) then 
            case Statement of nil then skip
            % part 1.1 Skip 
            [] [nop] then 
                {Browse 'skip statement'} 
                {Execute RemSemStack SAS}
            % part 2 Variable Creation
            [] [var ident(X) S] then 
                Key = {AddKeyToSAS} in
                {Browse 'Variable creation'}
                {Execute ss(s: S env: {AdjoinAt Env X Key})|RemSemStack SAS}
            % part 3 Variable to Variable Binding
            [] [bind ident(X) ident(Y)] then
                {Unify ident(X) ident(Y) Env}
                {Browse 'Variable to Variable Binding'}
                {Execute RemSemStack SAS}
            % part 4.1 Variable to Value Binding
            [] [bind ident(X) literal(N)] then
                % FIXME: do we require to init new store for <v> ?? 
                {Unify ident(X) literal(N) Env}
                {Browse 'Variable to Value Binding'}
                {Execute RemSemStack SAS}
            % part 1.2 Compound Statement
            [] S1|S2 then 
                % {Browse S1} 
                {Execute ss(s:S1 env:Env)|ss(s:S2 env:Env)|RemSemStack SAS}
            else {Browse 'Error: Statement invalid'} skip
            end
        else {Browse 'Error: TopSemStack invalid'} skip
        end
    else {Browse 'Error: SemStack invalid'} skip
    end
end

% proc {Execute ExecStack} 
%     case ExecStack of nil then skip
%     [] es(st: SemStack sas: XSAS) then
%         case SemStack of nil then skip
%         [] TopSemStack|RemSemStack then
%             case TopSemStack of nil then skip
%             [] ss(s: Statement env: Env) then 
%                 case Statement of nil then skip
%                 [] [nop] then 
%                     {Browse 'skip statement'} 
%                     {Execute es(st: RemSemStack sas:XSAS)}
%                 [] [var ident(X) S] then Key = {AddKeyToSAS} in
%                     {Browse "Variable creation"}
%                     {Execute es(st: ss(s: S env: {AdjoinAt Env X Key})|RemSemStack sas:XSAS)}
%                 [] S1|S2 then 
%                     % {Browse S1} 
%                     {Execute es(st: ss(s:S1 env:Env)|ss(s:S2 env:Env)|RemSemStack sas:XSAS)}
%                 else {Browse 'Error: Statement invalid'} skip
%                 end
%             else {Browse 'Error: TopSemStack invalid'} skip
%             end
%         else {Browse 'Error: SemStack invalid'} skip
%         end
%     else {Browse 'Error: ExecStack invalid'} skip
%     end
% end