declare Program SemanticStack Environment Execute ExecutionState SAS

\insert 'Interpreter.oz'
\insert 'Tests.oz'

Program = [[nop] [nop] [nop] [nop]] %statement in kernel language
Environment = env() %set of mappings {X=<x>, Y=<y>}
%ss: semantic statement, s: statement in kernel lang, env: environment
SAS = '#'
SemanticStack = [ss(s:Program env:Environment)] % stack of ss(s: env: )
ExecutionState = es(st: SemanticStack sas: SAS) %es(st: sas: )

% driver to call tests defined in Tests.oz
% {TestCases}

% Call Interpreter
{Execute SemanticStack Store}
