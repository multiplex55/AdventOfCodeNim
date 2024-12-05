#https://adventofcode.com/2024/day/4
import strutils, strformat, streams, os, times, tables, sequtils, sets, algorithm
import std/[asyncdispatch, threadpool]

proc validateIndexForInput(inputSeq: seq[string], potentialIndexes: seq[(int, int)]): int {.thread.} =
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
            # potentialIndexes.add((row, col)) # Center
            # potentialIndexes.add((row-1, col-1)) # Top Left
            # potentialIndexes.add((row-1, col+1)) # Top Right
            # potentialIndexes.add((row+1, col-1)) # Bottom Left
            # potentialIndexes.add((row+1, col+1)) # Bottom Right
        var
            topLeft = inputSeq[potentialIndexes[1][0]][potentialIndexes[1][1]]
            topRight = inputSeq[potentialIndexes[2][0]][potentialIndexes[2][1]]
            bottomLeft = inputSeq[potentialIndexes[3][0]][potentialIndexes[3][1]]
            bottomRight = inputSeq[potentialIndexes[4][0]][potentialIndexes[4][1]]
        if (topLeft != bottomRight) and (topRight != bottomLeft) and (topLeft !=
                'A') and (topRight != 'A') and (bottomLeft != 'A') and (
                bottomRight != 'A') and (topLeft != 'X') and (topRight !=
                        'X') and (bottomLeft != 'X') and (bottomRight != 'X'):
            answer += 1
            # echo &"{topLeft=} {bottomRight=} {topRight=} {bottomLeft=}"
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
    var
        answer = 0
        futures: seq[FlowVar[int]]

    for row, iseq in inputSeq:
        for col in 0..iseq.len()-1:
            if inputSeq[row][col] != 'A':
                continue
            var potentialIndexes = newSeq[(int, int)]()
            potentialIndexes.add((row, col)) # Center
            potentialIndexes.add((row-1, col-1)) # Top Left
            potentialIndexes.add((row-1, col+1)) # Top Right
            potentialIndexes.add((row+1, col-1)) # Bottom Left
            potentialIndexes.add((row+1, col+1)) # Bottom Right
            futures.add(spawn validateIndexForInput(inputSeq, potentialIndexes))
    for future in futures:
        answer += ^future
    echo "Answer is " & $answer
    return answer
