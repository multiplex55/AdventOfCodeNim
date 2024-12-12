# https://adventofcode.com/2020/day/5
import strutils, strformat, streams, os, times, tables, sequtils, algorithm, math

proc calculateSeatID(column: int, row: int): int =
    (row * 8) + column

proc calculateBoardingCol(boardingSequence: string, boardingMin: int,
        boardingMax: int): int =
    var
        colLower = boardingMin
        colUpper = boardingMax

    for i in 0..boardingSequence.len()-1:
        case boardingSequence[i]:
            of 'R':
                colLower = ((colUpper + colLower) / 2).ceil().toint()
            of 'L':
                colUpper = ((colUpper + colLower) / 2).floor().toint()
            else:
                echo &"unknown {boardingSequence[i]}"
    colUpper

proc calculateBoardingRow(boardingSequence: string, boardingMin: int,
        boardingMax: int): int =
    var
        rowLower = boardingMin
        rowUpper = boardingMax

    for i in 0..boardingSequence.len()-1:
        case boardingSequence[i]:
            of 'F':
                rowUpper = ((rowUpper + rowLower) / 2).floor().toint()
            of 'B':
                rowLower = ((rowUpper + rowLower) / 2).ceil().toint()
            else:
                echo &"unknown {boardingSequence[i]}"
    rowUpper

func splitBoardingSequence(inputToProcess: string, fb_partition: int,
        lf_partiion: int): seq[string] =
    var toReturn = @[inputToProcess.substr(0, fb_partition-1),
            inputToProcess.substr(fb_partition)]
    toReturn

proc processBoardingInput(inputToProcess: string): int =
    const
        FB_PARTITION_COUNT = 7
        LR_PARTITION_COUNT = 3
        FB_MIN = 0
        FB_MAX = 127
        LR_MAX = 7
        LR_MIN = 0

    let
        splitInputToProcessByPartition: seq[string] = splitBoardingSequence(
                inputToProcess, FB_PARTITION_COUNT, LR_PARTITION_COUNT)

        row: int = calculateBoardingRow(splitInputToProcessByPartition[0],
                FB_MIN, FB_MAX)
        column: int = calculateBoardingCol(splitInputToProcessByPartition[1],
                LR_MIN, LR_MAX)
        calculatedSeatID: int = calculateSeatID(column, row)
    calculatedSeatID

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc calculateAllBoardingInput(inputBoardingSeq: seq[string]): seq[int] =
    var boardingSeatIds: seq[int]
    for bs in inputBoardingSeq:
        boardingSeatIds.add(processBoardingInput(bs))
    boardingSeatIds

proc BinaryBoarding*(fileName: string): int =
    let
        inputBoardingSeq = getInputFromFile(fileName)
    var answer = 0

    var allSeatIds: seq[int] = calculateAllBoardingInput(inputBoardingSeq)
    answer = allSeatIds.max()

    echo "Answer is " & $answer
    return answer

when isMainModule:
    if paramCount() == 1:
        echo BinaryBoarding(paramStr(1))