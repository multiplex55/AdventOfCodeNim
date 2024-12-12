#https://adventofcode.com/2024/day/4
import strutils, strformat, streams, os, times, sequtils, algorithm

proc parseRules(rules: seq[string]): seq[(int, int)] =
    var parsedRules: seq[(int, int)] = @[]
    for rule in rules:
        let parts = rule.split("|")
        parsedRules.add((parts[0].parseInt(), parts[1].parseInt()))
    return parsedRules

proc reorderUpdate(update: seq[int], rules: seq[(int, int)]): seq[int] =
    var result = update
    var changed = true
    
    while changed:
        changed = false
        for rule in rules:
            let (beforePage, afterPage) = rule
        
            # Only apply rule if both pages are in the update
            if beforePage in update and afterPage in update:
                let beforeIndex = result.find(beforePage)
                let afterIndex = result.find(afterPage)
                
                # If the order is wrong, perform a swap and mark as changed
                if beforeIndex > afterIndex:
                    swap(result[beforeIndex], result[afterIndex])
                    changed = true
    
    result

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc PrintQueue*(fileName: string): int =
    let inputLines = getInputFromFile(fileName)
    let sections = inputLines.join("\n").split("\n\n")
    let orderingRules = parseRules(sections[0].splitLines())
    let updates = sections[1].splitLines().mapIt(it.split(",").map(parseInt))

    var middlePages: seq[int] = @[]
    for update in updates:
        # Reorder only if the update violates rules
        let reordered = reorderUpdate(update, orderingRules)
        if reordered != update:
            let middleIndex = reordered.len div 2
            middlePages.add(reordered[middleIndex])

    return middlePages.foldl(a + b)

when isMainModule:
    if paramCount() == 1:
        echo PrintQueue(paramStr(1))


