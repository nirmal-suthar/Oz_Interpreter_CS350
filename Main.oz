declare Program SemanticStack Environment Execute ExecutionState SAS

\insert 'Interpreter.oz'

Program = [[nop] [nop] [nop] [nop]] %statement in kernel language
Environment = env() %set of mappings {X=<x>, Y=<y>}
%ss: semantic statement, s: statement in kernel lang, env: environment
SemanticStack = [ss(s:Program env:Environment)] % stack of ss(s: env: )

% Call Interpreter
{Execute SemanticStack Store}
