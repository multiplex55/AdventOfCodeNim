#https://adventofcode.com/2024/day/2
import strutils, strformat, streams, os, times, tables, sequtils, sets,algorithm

proc evaluateReport(reportSeq: seq[int]) : bool =
    let 
        differenceAmountMin = 1
        differenceAmountMax = 3
        sortedAscending = reportSeq.isSorted(Ascending)
        sortedDescending = reportSeq.isSorted(Descending)
    var
        differences: seq[int]
        retStatus: bool

    for i,ri in reportSeq:
        if(i+1 < reportSeq.len()):
            differences.add((ri - reportSeq[i+1]).abs())
    
    if (differences.max <= differenceAmountMax and differences.min >= differenceAmountMin) and
        (sortedAscending or sortedDescending):
        retStatus = true
    else:
        retStatus = false

    retStatus
proc evaluateReports(reportsSeq: seq[string]): seq[bool] = 
    var retSeq: seq[bool]
    
    for report in reportsSeq:
        var 
            reportAsInts:seq[int] = report.split(" ").mapIt(parseInt(it))
            reportEvalPermutations:seq[bool]

        for i in 0..reportAsInts.len()-1:
            var currentReportWithRemovedElement = reportAsInts
            currentReportWithRemovedElement.delete(i)
            reportEvalPermutations.add(evaluateReport(currentReportWithRemovedElement))
        if reportEvalPermutations.countIt(it == true) >= 1:
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