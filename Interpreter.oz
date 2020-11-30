\insert 'Unify.oz'

fun {FV S}
    case S
    of [nop] then nil
    [] [var ident(X) S2] then {Filter {FV S2} fun{$ A} A \= X end}
    [] [bind ident(X) ident(Y)] then [X Y]
    [] [bind ident(X) V] then {UnionList [X] {FV V}}
    [] [match ident(X) P S1 S2] then local FVP = {FV P} in {UnionList [X] {UnionList {FV S2} {Filter {FV S1} fun{$ A} {Member A FVP}==false end}}} end
    [] [record L Pairs] then {Map Pairs fun{$ [literal(A) ident(B)]} B end}
    [] [procedure Args S] then {Filter {FV S} fun{$ A} {Member ident(A) Args}==false end}
    [] S1|S2 then {UnionList {FV S1} {FV S2}}
    else nil
    end
end

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
            % part 4.1+4.2+4.3 Variable to Value Binding
            [] [bind ident(X) Xs] then
                case Xs
                of [procedure Args S] then 
                    {Unify ident(X) procedure(definition: Xs closure: {FoldR {FV Xs} fun{$ A B} {AdjoinAt B A Env.A} end c()}) Env}
                    {Browse 'Variable to procedure Binding'}
                    {Execute RemSemStack SAS}
                else
                    % FIXME: do we require to init new store for <v> ?? 
                    {Unify ident(X) Xs Env}
                    {Browse 'Variable to Value Binding'}
                    {Execute RemSemStack SAS}
                end
            % part 5 Pattern match
            [] [match ident(X) P S1 S2] then
                local Rec T1 T2 NewEnv in
                    Rec = {RetrieveFromSAS Env.X} 
                    case Rec of nil then {Browse 'Error: match, ident(X) is nil'} skip
                    [] record|XLabel|XFeaturePairs|nil then
                        case P of nil then skip
                        [] record|PLabel|PFeaturePairs|nil then
                            T1 = {List.map PFeaturePairs fun {$ Pair} Pair.1 end}
                            T2 = {List.map XFeaturePairs fun {$ Pair} Pair.1 end}
                            if XLabel == PLabel andthen T1 == T2 then
                            % Pattern match
                            {Browse 'Pattern matched'}                      
                            {AdjoinList Env %Create the new env
                                {List.zip XFeaturePairs PFeaturePairs 
                                    fun {$ XFeaturePair PFeaturePair}
                                        % {Browse 'match new env binding pairs:'#XFeaturePair#PFeaturePair}
                                        case PFeaturePair.2.1 of ident(Xp) then
                                            case XFeaturePair.2.1 of equivalence(Xkey) 
                                                then Xp#Xkey
                                            [] reference(Xkey) 
                                                then Xp#Xkey
                                            else raise incompatibleTypes(PFeaturePair XFeaturePair) end
                                            end
                                        else raise incompatibleTypes(PFeaturePair XFeaturePair) end
                                        end
                                    end
                                ?} 
                            NewEnv}
                            % {Browse 'Env:'#Env}
                            % {Browse 'NewEnv:'#NewEnv}
                            {Execute ss(s: S1 env: NewEnv)|RemSemStack SAS}
                            else
                            % Pattern did not match
                            {Browse 'Pattern not matched'}
                            {Execute ss(s: S2 env: Env)|RemSemStack SAS}
                            end
                        else {Browse 'Error: match, P is not a valid record'} skip
                        end
                    else {Browse 'Error: match, ident(X) is not a valid record'} skip
                    end
                end
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