/*
* Top level file to run Interpreter
* Compile using `ozc -c Main.oz -o Interpreter`
* Execute `ozengine Interpreter`
*/
functor
import
  Browser(browse: Browse)
define
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
    % end
end