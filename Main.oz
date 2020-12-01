/*
* Top level file to run Interpreter
* Execute directly using Oz Interpreter
*/
declare 
Unify % Unification
Store Index % Store varible
RetrieveFromSAS BindValueToKeyInSAS BindRefToKeyInSAS % SAS function
HasUniqueEntries MixedCompare Canonize % record function

\insert 'Interpreter.oz'

% local Program SemanticStack Environment in

% ************ Interpreter Statement starts ************
Program = [[nop] [nop] [nop] [nop]]
% ************ Interpreter Statement ends ************

% Interpreter ExecutionState info
Environment = env()
SemanticStack = [ss(s:Program env:Environment)]

% Call Interpreter
{Execute SemanticStack Store}