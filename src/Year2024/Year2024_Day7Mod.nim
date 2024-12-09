import strutils, strformat, streams, os, times, sequtils, algorithm, sets, bigints
import std/[asyncdispatch, threadpool]

proc tokenize(equation: string): seq[string] =
    var tokens: seq[string]
    var currentToken: string

    for ch in equation:
        if ch in {'*', '+'}:
            if currentToken.len > 0:
                tokens.add(currentToken)  
                currentToken = ""
            tokens.add($ch)  
        else:
            currentToken.add(ch) 

    if currentToken.len > 0:
        tokens.add(currentToken)  
    tokens


proc evaluateEquation(equationPermutation: string): BigInt =

    var tokens = tokenize(equationPermutation) 

    if tokens.len == 0:
        raise newException(ValueError, "Invalid equation: Empty input")
    
    # Parse the first number as BigInt
    var result: BigInt = (tokens[0].strip()).initBigInt
    
    # Iterate through the rest of the tokens
    var i = 1
    while i < tokens.len:
        let operator = tokens[i].strip()
        let nextNumber = (tokens[i + 1].strip()).initBigInt
        case operator:
        of "*":
            result *= nextNumber
        of "+":
            result += nextNumber
        else:
            raise newException(ValueError, &"Invalid operator: {operator}")
        i += 2

    result


proc generatePermutationsOfEquation(equation: string, operators: seq[string]): seq[string] =
    var
        permutations: seq[string]
        splitEquation = equation.split(" ").filterIt(it.len > 0)

    proc helper(current: string, index: int) =
        if index >= splitEquation.len:
            permutations.add(current)
            return
        for op in operators:
            helper(&"{current}{op}{splitEquation[index]}", index + 1)

    if splitEquation.len > 0:
        helper(splitEquation[0], 1)

    permutations

# Function to read input from file
proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line.strip())
    inputSeq

proc BridgeRepair*(fileName: string): BigInt =
    let
        inputLines = getInputFromFile(fileName)
        operators = @["*", "+"]
    var
        validEquations: seq[BigInt]

    for il in inputLines:
        let testValue: BigInt = il.split(":")[0].initBigInt
        var equation = il.split(":")[1]
        let equationPermutations = generatePermutationsOfEquation(equation, operators)

        var foundMatchingValue = false
        for eq in equationPermutations:
            let eeValue = evaluateEquation(eq)
            if eeValue == testValue:
                foundMatchingValue = true
        if foundMatchingValue:
            validEquations.add(testValue)
    
    for ve in validEquations:
        echo &"{ve=}"

    var answers = validEquations.foldl(a + b)
    echo &"Final Answers Count: {answers}"
    answers