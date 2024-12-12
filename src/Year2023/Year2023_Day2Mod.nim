# https://adventofcode.com/2023/day/2
import strutils, strformat, streams, os, times, tables

proc CubeConundrum*(fileName: string): int =
    var
        fileStrm = openfilestream(fileName, fmRead)
        line: string
        sum: int
        gameIndex: int

    const
        RED_LIMIT: int = 12
        GREEN_LIMIT: int = 13
        BLUE_LIMIT: int = 14

    for line in fileStrm.lines:
        var splitSequence = split(line, ":")
        # Get game num
        var
            gameNum = parseint(splitSequence[0].split(' ')[^1].strip())
            validGame: bool = true

        for x in splitSequence[1].strip().replace(";", ",").split(", "):
            let num = parseint(x.split(" ")[0])
            let color = x.split(" ")[1]

            case color
            of "green":
                if num > GREEN_LIMIT:
                    validGame = false
            of "blue":
                if num > BLUE_LIMIT:
                    validGame = false
            of "red":
                if num > RED_LIMIT:
                    validGame = false

        if validGame:
            sum = sum + gameNum

    defer: fileStrm.close()
    return sum

when isMainModule:
    if paramCount() == 1:
        echo CubeConundrum(paramStr(1))