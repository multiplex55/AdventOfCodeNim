# https://adventofcode.com/2023/day/3
import strutils, strformat, streams, os, times, tables, algorithm, sequtils

type
    Cell = tuple[letter: char, row: int, col: int]
    MergedCell = tuple[number: int, row: int, col: int]

proc flatten[T](seq: seq[seq[T]]): seq[T] =
    var result: seq[T]
    for innerSeq in seq:
        for item in innerSeq:
            result.add(item)
    return result

proc WalkAndFindNumbers(engineSchematic: seq[seq[string]],
        originalRowIndex: int, originalColIndex: int): MergedCell =
    var
        cells: seq[Cell]
        mergedCells: seq[MergedCell]
    let
        maxRow: int = engineSchematic.len - 1
        maxCol: int = engineSchematic[0].len - 1

    var
        currentRowIndex = originalRowIndex
        currentColIndex = originalColIndex
        currentChar: char = engineSchematic[currentRowIndex][currentColIndex][0]

    # Walk left
    #echo "Walk left"
    #echo &"currentChar {currentChar}"
    #echo &"row {currentRowIndex}"
    #echo &"col {currentColIndex}"

    while currentChar.isDigit():
        currentChar = engineSchematic[currentRowIndex][currentColIndex][0]
        #echo &"Current Char is {currentChar} Current location is row {currentRowIndex} col {currentColIndex}"
        cells.add((currentChar, currentRowIndex, currentColIndex))
        #echo &"Adding cell: cells is now: "
        #############
        #for c in cells:
            #echo c
        ############
        currentColIndex = currentColIndex - 1
        if currentColIndex < 0:
            break

    # Reset indexes
    currentRowIndex = originalRowIndex
    currentColIndex = originalColIndex + 1
    currentChar = engineSchematic[currentRowIndex][currentColIndex][0]
    # Walk Right
    #echo "Walk right"
    while currentChar.isDigit():
        currentChar = engineSchematic[currentRowIndex][currentColIndex][0]
        #echo &"Current Char is {currentChar} Current location is row {currentRowIndex} col {currentColIndex}"
        cells.add((currentChar, currentRowIndex, currentColIndex))
        #echo &"Adding cell: cells is now: "
        #############
        #for c in cells:
            #echo c
        ############
        currentColIndex = currentColIndex + 1
        if currentColIndex > maxCol:
            break

    #echo &"Cells before sorting is"
    #for c in cells:
        #echo c
    cells = cells.sortedByIt(it.col)
    cells = cells.filterIt(it.letter != '.')
    # TODO Find a better way to do this
    cells = cells.filterIt(it.letter != '*')
    cells = cells.filterIt(it.letter != '$')
    cells = cells.filterIt(it.letter != '#')
    cells = cells.filterIt(it.letter != '+')
    cells = cells.filterIt(it.letter != '=')
    cells = cells.filterIt(it.letter != '@')
    cells = cells.filterIt(it.letter != '/')
    cells = cells.filterIt(it.letter != '%')
    cells = cells.filterIt(it.letter != '-')
    cells = cells.filterIt(it.letter != '&')

    cells = cells.deduplicate()
    #########################
    # Debugging print cells
    #echo &"Cells after sorting is"
    #for c in cells:
        #echo c
    #########################
    var mergedNumString: string
    var mergedRowString: string
    var mergedColString: string
    apply(cells, proc(item: Cell) = mergedNumString.add($item.letter))
    apply(cells, proc(item: Cell) = mergedRowString.add($item.row))
    apply(cells, proc(item: Cell) = mergedColString.add($item.col))
    #echo &"Merged Row is {mergedRowString}"
    #echo &"Merged Col is {mergedColString}"
    let mc: MergedCell = (parseInt(mergedNumString), mergedRowString.parseInt(),
            mergedColString.parseInt())

    return mc

proc CheckForNumbers(engineSchematic: seq[seq[string]], originalRowIndex: int,
        originalColIndex: int): seq[MergedCell] =
    var
        numbersEncountered: seq[int]
        characterAtIndex: char
        cells: seq[Cell]
        mergedCells: seq[MergedCell]
    let
        maxRow: int = engineSchematic.len - 1
        maxCol: int = engineSchematic[0].len - 1

    #echo &"String character {engineSchematic[originalRowIndex][originalColIndex]} index is row {originalRowIndex} col {originalColIndex}"
    #echo "=============="
    # check in all directions from c

    # check up
    if originalRowIndex - 1 >= 0:
        characterAtIndex = engineSchematic[originalRowIndex-1][
                originalColIndex][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - up - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"
            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex-1, originalColIndex))

            #echo &"Current mergedcells is"
            ##for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check right
    if originalColIndex + 1 <= maxCol:
        characterAtIndex = engineSchematic[originalRowIndex][
                originalColIndex+1][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - right - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]}ogRow {originalRowIndex} ogCol {originalColIndex}"

            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex, originalColIndex+1))
            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check down
    if originalRowIndex + 1 <= maxRow:
        characterAtIndex = engineSchematic[originalRowIndex+1][
                originalColIndex][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - down - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"

            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex+1, originalColIndex))

            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check left
    if originalColIndex - 1 >= 0:
        characterAtIndex = engineSchematic[originalRowIndex][
                originalColIndex-1][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - left - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"

            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex, originalColIndex-1))

            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check up right
    if originalRowIndex - 1 >= 0 and originalColIndex + 1 <= maxCol:
        characterAtIndex = engineSchematic[originalRowIndex-1][
                originalColIndex+1][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - up right - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"

            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex-1, originalColIndex+1))

            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check up left
    if originalRowIndex - 1 >= 0 and originalColIndex - 1 <= maxCol:
        characterAtIndex = engineSchematic[originalRowIndex-1][
                originalColIndex-1][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - up left - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"

            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex-1, originalColIndex-1))

            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check down right
    if originalRowIndex + 1 >= 0 and originalColIndex + 1 <= maxCol:
        characterAtIndex = engineSchematic[originalRowIndex+1][
                originalColIndex+1][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - down right - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"

            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex+1, originalColIndex+1))

            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"
            #echo "================="

        # check down left
    if originalRowIndex + 1 >= 0 and originalColIndex - 1 <= maxCol:
        characterAtIndex = engineSchematic[originalRowIndex+1][
                originalColIndex-1][0]
        if characterAtIndex.isDigit():
            #echo &"We found a digit - down left - {$characterAtIndex} currentCharacter is {engineSchematic[originalRowIndex][originalColIndex][0]} ogRow {originalRowIndex} ogCol {originalColIndex}"
            mergedCells.add(WalkAndFindNumbers(engineSchematic,
                    originalRowIndex+1, originalColIndex-1))

            #echo &"Current mergedcells is"
            #for mc in mergedCells:
                #echo &"{mc}"

            #echo "-----------------------------------"
    mergedCells = mergedCells.deduplicate()
    #for mc in mergedCells:
        #echo &"{mc}"
    return mergedCells

proc GearRatioPart2*(fileName: string): int =
    var
        sum = 0
        fileStrm = openfilestream(fileName, fmRead)
        line: string
        engineSchematic = @[@[""]]
        lineCounter: int
        mergedCells: seq[seq[MergedCell]]
    defer: fileStrm.close()

    lineCounter = 0
    # Read file and built engineSchematic
    for line in fileStrm.lines:
        engineSchematic.add(@[""])
        var currentLineArray: seq[string] = @[]
        for ch in line:
            currentLineArray.add($ch)
        engineSchematic[lineCounter] = currentLineArray
        lineCounter += 1
    discard engineSchematic.pop()

    #Print all sequences
    #for line in engineSchematic:
        #echo &"line: {line}"

    var
        currentRowCounter: int
        currentColCounter: int

    for currentRowCounter, rowV in engineSchematic:
        # echo &"currentRowCounter {currentRowCounter} rowV {rowV}"
        for currentColCounter, colV in engineSchematic[currentRowCounter]:
            # echo &"CurrentColCounter {currentColCounter} colV {colV}"
            if engineSchematic[currentRowCounter][currentColCounter] != ".":
                if not engineSchematic[currentRowCounter][currentColCounter][0].isDigit:
                    if engineSchematic[currentRowCounter][currentColCounter][
                            0] == '*':
                        #This is not a dot or digit
                        var currentSeq = CheckForNumbers(engineSchematic,
                                currentRowCounter, currentColCounter)
                        #echo "$$$$$$$$$$$$$$$$$$$$$$$$ - " & $currentSeq.len()
                        if currentSeq.len() == 2:
                            var temp = CheckForNumbers(engineSchematic,
                                    currentRowCounter, currentColCounter)
                            temp = temp.deduplicate()
                            # Debug
                            #for i,mc in temp:
                                #echo &"i {i} mc {mc}"
                            # Debug
                            var tempSum = temp[0].number * temp[1].number
                            sum += tempSum
                            #echo &"tempsum {tempSum}"
                            #echo &"Current sum is {sum}"

                            #echo "%%%%%%%%%%%%% Current total mergedCells is %%%%%%%%%%%"
                            #for mc in mergedCells:
                                #echo mc
    #echo "==== final ===="
    #for mc in mergedCells:
        #echo mc

    #echo "===== Flatten and deduped ====="
    var flattenCells = flatten(mergedCells.deduplicate())
    flattenCells = flattenCells.deduplicate()
    apply(flattenCells, proc(x: MergedCell) = sum = sum + x.number)
    #for fs in flattenCells:
        #echo fs
    return sum

