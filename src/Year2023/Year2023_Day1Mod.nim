# https://adventofcode.com/2023/day/1
import strutils, strformat, streams, os, times, tables

proc Trebuchet*(fileName: string): int =
    var
        sum = 0
        fileStrm = openfilestream(fileName, fmRead)
        line: string

    for line in fileStrm.lines:
        var
            first: int
            last: int
            foundFirst: bool
            foundLast: bool

        for mightBeInt in line:
            # Is it a num
            if mightBeInt.isDigit:
                # Have you found the first one
                if foundFirst == false:
                    first = parseInt($mightBeInt)
                    foundFirst = true
                else:
                    last = parseInt($mightBeInt)
                    foundLast = true
        if foundLast:
            sum = sum + parseInt($first & $last)
        else:
            sum = sum + parseInt($first & $first)

    defer: fileStrm.close()
    #echo &"Current Sum {sum}"

    return sum


####################
proc TableContainsKeyParseInt*(tableToSearch: Table[string, int],
        stringToFind: string): int =

    for key, value in tableToSearch:
        if stringToFind.contains(key):
            # echo &"This key {key} contains the number? {stringToFind}"
            return value
    return 0

when isMainModule:
    if paramCount() == 1:
        echo Trebuchet(paramStr(1))