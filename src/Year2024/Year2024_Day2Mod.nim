#https://adventofcode.com/2024/day/2
import strutils, strformat, streams, os, times, tables, sequtils, sets,algorithm

proc evaluateReports(reportsSeq: seq[string]): seq[bool] = 
    var retSeq: seq[bool]

    let 
        differenceAmountMin = 1
        differenceAmountMax = 3
    
    for report in reportsSeq:
        var 
            reportAsInts:seq[int] = report.split(" ").mapIt(parseInt(it))
            sortedAscending = reportAsInts.isSorted(Ascending)
            sortedDescending = reportAsInts.isSorted(Descending)
            maintainedOrder = true
            differences: seq[int]
        for i,ri in reportAsInts:
            if(i+1 < reportAsInts.len()):
                differences.add((ri - reportAsInts[i+1]).abs())
        if(differences.max <= differenceAmountMax and differences.min >= differenceAmountMin and (sortedAscending or sortedDescending)):
            retSeq.add(true)
        else:
            retSeq.add(false)
    retSeq

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc RedNosedReports*(fileName: string): int =
    let
        inputSeq: seq[string] = getInputFromFile(fileName) 
        areReportsSafe:seq[bool] = evaluateReports(inputSeq)
        answer = areReportsSafe.countIt(it == true)
        
    echo "Answer is " & $answer
    return answer

when isMainModule:
    if paramCount() == 1:
        echo RedNosedReports(paramStr(1))