#https://adventofcode.com/2024/day/4
import strutils, strformat, streams, os, times, tables, sequtils, sets, algorithm

proc validateIndexForInput(inputSeq:seq[string], potentialIndexes:seq[(int,int)], targetString: string): int = 
    var answer: int
    var outOfBounds = false
    if potentialIndexes.countIt(it[0] < 0) > 0 or
            potentialIndexes.countIt(it[1] < 0) > 0 or
            potentialIndexes.countIt(it[0] > inputSeq.len()-1) > 0 or
            potentialIndexes.countIt(it[1] > inputSeq.len()-1) > 0:
        outOfBounds = true
    if not outOfBounds:
        # echo potentialIndexes
        var potentialString = ""
        for pi in potentialIndexes:
            potentialString.add(inputSeq[pi[0]][pi[1]])
        if potentialString == targetString:
            answer += 1
    answer 

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc CeresSearch*(fileName: string): int =
    let
        inputSeq: seq[string] = getInputFromFile(fileName)
        targetString = "XMAS"
    var
        answer = 0

    for row, iseq in inputSeq:
        for col in 0..iseq.len()-1:
            # echo &"{row=} {col=}"
            var potentialIndexes = newSeq[(int, int)]()
            #Up
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row, col-x))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #Down
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row, col+x))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #Left
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row-x, col))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #Right
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row+x, col))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #UpRight
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row-x, col+x))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #DownRight
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row+x, col+x))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #DownLeft
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row+x, col-x))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)
            #UpLeft
            potentialIndexes = newSeq[(int, int)]()
            for x in 0..targetString.len()-1:
                potentialIndexes.add((row-x, col-x))
            answer += validateIndexForInput(inputSeq, potentialIndexes, targetString)

    echo "Answer is " & $answer
    return answer
