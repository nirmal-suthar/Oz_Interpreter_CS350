\insert 'Interpreter.oz'

proc {TestCases}
    local Program Environment SemanticStack in
        Program = [[nop] [nop] [nop] [nop]] %statement in kernel language
        Environment = env() %set of mappings {X=<x>, Y=<y>}
        SemanticStack = [ss(s:Program env:Environment)] % stack of ss(s: env: )

        {Execute SemanticStack Store}
    end

    local Program Environment SemanticStack in
        Program = [var ident(x) [nop]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]
        {Execute SemanticStack Store}
    end

    local Program Environment SemanticStack in
        Program = [var ident(x) [[var ident(y) [var ident(x) [nop]]] [nop]]]
        Environment = env()
        SemanticStack = [ss(s:Program env:Environment)]

        {Execute SemanticStack Store}
    end
end

{TestCases}