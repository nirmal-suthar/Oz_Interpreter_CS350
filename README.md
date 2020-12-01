# Oz Interpreter (Assignment2 CS350 2020-I)

## Members

- [Sarthak Dubey](https://github.com/srthkdb)
- [Dev Chauhan](https://github.com/dev-chauhan)
- [Nirmal Suthar](https://github.com/nirmal-suthar)

## Description of files

- Main.oz - [Live mode] Top level file to run the interpreter
- Main2.oz - [Compile mode] Top level file to run the interpreter
- Interpreter.oz - Interpreter for Abstract Syntax Tree as input
- SingleAssignmentStore.oz - Implementation of Single Assignment Store
- Test.oz - Custom Test cases.
- Unify.oz - Unification algorithm (Provided as part of assign)
- ProcessRecords.oz - Utils for Records manipulation (Provided as part of assign)

## Usage example



### Oz Interpreter [Main.oz]

    `ctrl+. ctrl+b` [feed file Main.oz]
 
### Compiled Mode [Main2.oz]

    - Compile
        `ozc -c Main2.oz -o Interpreter`
    - Execute
        `ozengine Interpreter`
