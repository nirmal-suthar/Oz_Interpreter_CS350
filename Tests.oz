declare 
Unify % Unification
Store Index % Store varible
RetrieveFromSAS BindValueToKeyInSAS BindRefToKeyInSAS % SAS function
HasUniqueEntries MixedCompare Canonize % record function

\insert 'Interpreter.oz'

proc {TestCases}
    % local Program Environment SemanticStack in
    %     {Browse 'Test 1'}
    %     Program = [[nop] [nop] [nop] [nop]] %statement in kernel language
    %     Environment = env() %set of mappings {X=<x>, Y=<y>}
    %     SemanticStack = [ss(s:Program env:Environment)] % stack of ss(s: env: )

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 2'}
    %     Program = [var ident(x) [nop]]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]
    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 3'}
    %     Program = [var ident(x) [[var ident(y) [var ident(x) [nop]]] [nop]]]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    
    % local Program Environment SemanticStack in
    %     {Browse 'Test 4: Variable to Variable Binding'}
    %     Program = [var ident(x) 
    %                 [var ident(y) 
    %                     [bind ident(x) ident(y)]]]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 5: Variable to Value Binding'}
    %     Program = [var ident(x) 
    %                 [bind ident(x) literal(1)]]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 6: Variable to Literal + Value Binding'}
    %     Program = [var ident(x) 
    %                 [var ident(y) 
    %                     [[bind ident(x) ident(y)] [bind ident(x) literal(5)]] ]]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    % local Program Environment SemanticStack in
    %     {Browse 'Test 7: Variable to Record Binding'}
    %     Program = [var ident(z) [var ident(y) [var ident(x) 
    %                 [bind ident(x) [record literal(2) [
    %                     [literal(1) ident(y)]
    %                     [literal(2) ident(z)]
    %                 ]]]]]]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    % local Program Environment SemanticStack in
    %     {Browse 'Test 8: Pattern match'}
    %     Program = [var ident(z) 
    %                 [var ident(y) 
    %                     [var ident(x) 
    %                         [
    %                             [bind ident(x) 
    %                                 [record literal(2) [
    %                                     [literal(1) ident(y)]
    %                                     [literal(2) ident(z)]
    %                                 ]]
    %                             ]
    %                             [match ident(x) 
    %                                 [record literal(2) [
    %                                     [literal(1) ident(a)]
    %                                     [literal(2) ident(b)]
    %                                 ]] [nop] [nop]
    %                             ]
    %                         ]
    %                     ]
    %                 ]
    %             ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    % local Program Environment SemanticStack in
    %     {Browse 'Test 9: Pattern not match1'}
    %     Program = [var ident(z) 
    %                 [var ident(y) 
    %                     [var ident(x) 
    %                         [
    %                             [bind ident(x) 
    %                                 [record literal(2) [
    %                                     [literal(1) ident(y)]
    %                                     [literal(2) ident(z)]
    %                                 ]]
    %                             ]
    %                             [match ident(x) 
    %                                 [record literal(2) [
    %                                     [literal(5) ident(a)]
    %                                     [literal(2) ident(b)]
    %                                 ]] [nop] [nop]
    %                             ]
    %                         ]
    %                     ]
    %                 ]
    %             ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    % local Program Environment SemanticStack in
    %     {Browse 'Test 10: Pattern not match2'}
    %     Program = [var ident(z) 
    %                 [var ident(y) 
    %                     [var ident(x) 
    %                         [
    %                             [bind ident(x) 
    %                                 [record literal(2) [
    %                                     [literal(1) ident(y)]
    %                                     [literal(2) ident(z)]
    %                                 ]]
    %                             ]
    %                             [match ident(x) 
    %                                 [record literal(10) [
    %                                     [literal(1) ident(a)]
    %                                     [literal(2) ident(b)]
    %                                 ]] [nop] [nop]
    %                             ]
    %                         ]
    %                     ]
    %                 ]
    %             ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    %  local Program Environment SemanticStack in
    %     {Browse 'Test 11: Pattern not match3'}
    %     Program = [var ident(z) 
    %                 [var ident(y) 
    %                     [var ident(x) 
    %                         [
    %                             [bind ident(x) 
    %                                 [record literal(2) [
    %                                     [literal(1) ident(y)]
    %                                     [literal(2) ident(z)]
    %                                 ]]
    %                             ]
    %                             [match ident(x) 
    %                                 [record literal(10) [
    %                                     [literal(1) ident(a)]
    %                                 ]] [nop] [nop]
    %                             ]
    %                         ]
    %                     ]
    %                 ]
    %             ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]

    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    % local Program Environment SemanticStack in
    %     {Browse 'Test 12: Bind a procedure'}
    %     Program = [var ident(p1)
    %         [var ident(p2)
    %             [
    %                 [bind ident(p1) 
    %                     [procedure [ident(x1)] [bind ident(p2) ident(x1)]]
    %                 ]
    %             ]
    %         ]
    %     ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]
        
    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end
    % local Program Environment SemanticStack in
    %     {Browse 'Test 13: Bind a procedure'}
    %     Program = [var ident(p1)
    %         [var ident(p2)
    %             [
    %                 [bind ident(p1) 
    %                     [procedure [ident(x1)] [bind ident(p2) ident(x1)]]
    %                 ]
    %                 [bind ident(p2) ident(p1)]
    %             ]
    %         ]
    %     ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]
        
    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 14: Procedure application 1'}
    %     Program = [var ident(p1)
    %         [var ident(p2)
    %             [
    %                 [bind ident(p1) 
    %                     [procedure [ident(x1)] [nop]]
    %                 ]
    %                 [apply ident(p1) ident(p2)]
    %             ]
    %         ]
    %     ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]
        
    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 14: Procedure application 2'}
    %     Program = [var ident(p1)
    %         [var ident(p2)
    %             [
    %                 [bind ident(p1) 
    %                     [procedure nil [bind ident(p2) literal(2)]]
    %                 ]
    %                 [apply ident(p1)]
    %             ]
    %         ]
    %     ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]
        
    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

    % local Program Environment SemanticStack in
    %     {Browse 'Test 14: Procedure application 3'}
    %     Program = [var ident(p1)
    %         [var ident(p2)
    %             [var ident(p3)
    %                 [
    %                     [bind ident(p1) 
    %                         [procedure [ident(x1)] 
    %                             [ 
    %                                 [bind ident(x1) ident(p3)] 
    %                                 [nop] 
    %                             ]
    %                         ]
    %                     ]
    %                     [apply ident(p1) ident(p2)]
    %                     [bind ident(p3) literal(3)]
    %                 ]
    %             ]
    %         ]
    %     ]
    %     Environment = env()
    %     SemanticStack = [ss(s:Program env:Environment)]
        
    %     {Execute SemanticStack Store}
    %     {PrintAll}
    % end

end

{TestCases}


