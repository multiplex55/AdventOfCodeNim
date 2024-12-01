#https://adventofcode.com/2024/day/1
import strutils, strformat, streams, os, times, tables, sequtils, sets,algorithm

proc calculateDifferences(inputSeq: seq[seq[int]]) : seq[int] = 
    var differences: seq[int]
    for i in 0..inputSeq[0].len()-1:
        differences.add(abs(inputseq[0][i] - inputseq[1][i]))
    differences    

proc sortSplitInputSeq(inputSeq: seq[seq[int]]) : seq[seq[int]] = 
    var sortedSeq = inputSeq

    for i,x in sortedSeq:
        sortedseq[i].sort()
    sortedSeq

proc splitInputSeqAndConvertToInt(inputSeq: seq[string]) : seq[seq[int]] =
    var returnSeq: seq[seq[int]]
    returnSeq.add(newSeq[int](0))
    returnSeq.add(newSeq[int](0))

    for i,r in inputSeq:
        let splitSeq = r.split(" ").filterIt(it != "")
        returnSeq[0].add(parseInt(splitSeq[0]))
        returnSeq[1].add(parseInt(splitSeq[1]))
    returnSeq

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc HistorianHysteria*(fileName: string): int =
    let
        inputSeq: seq[string] = getInputFromFile(fileName) 
        splitSeq: seq[seq[int]] = splitInputSeqAndConvertToInt(inputSeq)
        sortSplitSeq: seq[seq[int]] = sortSplitInputSeq(splitSeq)
        differenceBetweenSequence = calculateDifferences(sortSplitSeq)

    let answer = differenceBetweenSequence.foldl(a + b)
    echo "Answer is " & $answer
    return answer
