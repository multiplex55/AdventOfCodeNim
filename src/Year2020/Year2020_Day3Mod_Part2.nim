# https://adventofcode.com/2020/day/3
import strutils, strformat, streams, os, times, tables, sequtils, algorithm, math

type
    Slope = object
        right: int
        down: int

proc TobogganTrajectory*(fileName: string): int =
    const
        SLOPE_Y_DOWN = 1
        SLOPE_X_RIGHT = 3
        TREE_CHAR = "#"
        OPEN_CHAR = "."
        START_POSITION = 0

    var
        answer = 1
        fileStrm = openfilestream(fileName, fmRead)
        inputSeq: seq[string]
        currentYPos = 0
        currentXPos = 0
        slopeSeq: seq[Slope]
    slopeSeq.add(Slope(right: 1, down: 1))
    slopeSeq.add(Slope(right: 3, down: 1))
    slopeSeq.add(Slope(right: 5, down: 1))
    slopeSeq.add(Slope(right: 7, down: 1))
    slopeSeq.add(Slope(right: 1, down: 2))

    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    for ss in slopeSeq:
        let
            rightSlope = ss.right
            downSlope = ss.down

        var
            currentXCounter = 0
            currentYCounter = 0
            currentAnswer = 0

        while currentYCounter < inputSeq.len():
            var
                currentInputSeqRow = inputSeq[currentYCounter]
                modulatedXPos = floorMod(currentXCounter,
                        currentInputSeqRow.len())
                charAtPos = currentInputSeqRow[modulatedXPos]

            if $charAtPos == TREE_CHAR:
                currentAnswer += 1

            currentYCounter += downSlope
            currentXCounter += rightSlope
        echo "Current answer is " & $currentAnswer
        answer *= currentAnswer

    echo "Answer is " & $answer
    return answer

when isMainModule:
    if paramCount() == 1:
        echo TobogganTrajectory(paramStr(1))