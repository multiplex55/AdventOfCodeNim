import strutils, strformat, streams, os, times, tables, sequtils, algorithm, math

proc TobogganTrajectory*(fileName: string): int =
    const
        SLOPE_Y_DOWN = 1
        SLOPE_X_RIGHT = 3
        TREE_CHAR = "#"
        OPEN_CHAR = "."
        START_POSITION = 0

    var
        answer: int
        fileStrm = openfilestream(fileName, fmRead)
        inputSeq: seq[string]
        currentYPos = 0
        currentXPos = 0

    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    for currentInputSeqRow in inputSeq:
        var modulatedXPos = 0
        if currentXPos > currentInputSeqRow.len():
            modulatedXPos = floorMod(currentXPos, currentInputSeqRow.len())
        else:
            modulatedXPos = currentXPos

        var charAtPos = currentInputSeqRow[modulatedXPos]
        if $charAtPos == TREE_CHAR:
            answer += 1
        currentXPos += SLOPE_X_RIGHT

    echo "Answer is " & $answer
    return answer

