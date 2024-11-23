# https://adventofcode.com/2023/day/1
import strutils, strformat, streams, os, times, tables

####################
proc TableContainsKeyParseInt*(tableToSearch: Table[string, int],
        stringToFind: string): int =

    for key, value in tableToSearch:
        if stringToFind.contains(key):
            # echo &"This key {key} contains the number? {stringToFind}"
            return value
    return 0

proc Trebuchet*(fileName: string): int =

    var outputDebug = newFileStream("DEBUG_OUTPUT.txt", fmWrite)
    defer: outputDebug.close()
    var
        sum = 0
        fileStrm = openfilestream(fileName, fmRead)
        line: string

    const
        digitTable: Table[system.string, system.int] = {"one": 1, "two": 2,
                "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7,
                "eight": 8, "nine": 9}.toTable()

    for line in fileStrm.lines:
        var
            first: int
            last: int
            foundFirst: bool
            foundLast: bool
            potentialStringNumber: string
            currentDigit: int
            backupLetter: char

        for mightBeInt in line:
            # echo &"Current char is {$mightBeInt}"
            if not mightBeInt.isDigit:
                potentialStringNumber = potentialStringNumber & $mightBeINt
                # echo &"DEBUG building up string, currently: {potentialStringNumber}"

                currentDigit = TableContainsKeyParseInt(digitTable, potentialStringNumber)
                if currentDigit == 0:
                    currentDigit = TableContainsKeyParseInt(digitTable,
                            $backupLetter & potentialStringNumber)
                if currentDigit != 0:
                    backupLetter = potentialStringNumber[^1]
                    potentialStringNumber = ""
                    # echo "backup letter " & backupLetter
            else:
                currentDigit = parseInt($mightBeInt)
                potentialStringNumber = ""
            # echo &"DEBUG Current digit is {currentDigit}"

            if currentDigit != 0:
                if foundFirst == false:
                    first = currentDigit
                    foundFirst = true
                else:
                    last = currentDigit
                    foundLast = true
                currentDigit = 0

        if foundLast:
            sum = sum + parseInt($first & $last)
            #echo &"End of line {line} : F: {first} L: {last}"
        else:
            sum = sum + parseInt($first & $first)
            #echo "DID NOT FIND LAST FOR THIS NUMBER " & line & &" End of line {line} : F: {first} F: {first}"
        # quit()

    defer: fileStrm.close()
    #echo &"Current Sum {sum}"

    return sum


#### Archive
