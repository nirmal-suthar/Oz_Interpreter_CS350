\insert 'Interpreter.oz'

proc {TestCases}
    local Program Environment SemanticStack in
        {Browse 'Test 1'}
        Program = [[nop] [nop] [nop] [nop]] %statement in kernel language
        Environment = env() %set of mappings {X=<x>, Y=<y>}
        SemanticStack = [ss(s:Program env:Environment)] % stack of ss(s: env: )

        {Execute SemanticStack Store}
        {PrintAll}
    end

    local Program Environment SemanticStack in
        {Browse 'Test 2'}
        Program = [var ident(x) [nop]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]
        {Execute SemanticStack Store}
        {PrintAll}
    end

    local Program Environment SemanticStack in
        {Browse 'Test 3'}
        Program = [var ident(x) [[var ident(y) [var ident(x) [nop]]] [nop]]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]

        {Execute SemanticStack Store}
        {PrintAll}
    end
    
    local Program Environment SemanticStack in
        {Browse 'Test 4: Variable to Variable Binding'}
        Program = [var ident(x) 
                    [var ident(y) 
                        [bind ident(x) ident(y)]]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]

        {Execute SemanticStack Store}
        {PrintAll}
    end

    local Program Environment SemanticStack in
        {Browse 'Test 5: Variable to Value Binding'}
        Program = [var ident(x) 
                    [bind ident(x) literal(1)]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]

        {Execute SemanticStack Store}
        {PrintAll}
    end

    local Program Environment SemanticStack in
        {Browse 'Test 6: Variable to Variable + Value Binding'}
        Program = [var ident(x) 
                    [var ident(y) 
                        [[bind ident(x) ident(y)] [bind ident(x) literal(5)]] ]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]

        {Execute SemanticStack Store}
        {PrintAll}
        % {Browse {Dictionary.entries Store}}
    end
end

{TestCases}