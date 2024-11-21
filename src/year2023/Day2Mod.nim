# https://adventofcode.com/2023/day/2
import strutils, strformat, streams, os, times, tables

proc CubeConundrumPart1*(fileName: string): int =
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

proc CubeConundrumPart2*(fileName: string): int =
    const
        RED_LIMIT: int = 12
        GREEN_LIMIT: int = 13
        BLUE_LIMIT: int = 14

    var
        fileStrm = openfilestream(fileName, fmRead)
        line: string
        sum: int
        gameIndex: int
        min_green: int
        min_blue: int
        min_red: int


    for line in fileStrm.lines:
        min_green = 0
        min_blue = 0
        min_red = 0
        var splitSequence = split(line, ":")

        for x in splitSequence[1].strip().replace(";", ",").split(", "):
            let num = parseint(x.split(" ")[0])
            let color = x.split(" ")[1]

            case color
            of "green":
                if min_green < num: min_green = num
            of "blue":
                if min_blue < num: min_blue = num
            of "red":
                if min_red < num: min_red = num

        # echo "Red " , min_red
        # echo "Green ", min_green
        # echo "Blue ", min_blue
        # echo (min_red * min_green * min_blue)
        sum = sum + (min_red * min_green * min_blue)

    defer: fileStrm.close()
    return sum
