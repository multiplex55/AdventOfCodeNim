#https://adventofcode.com/2024/day/3
import strutils, strformat, streams, os, times, tables, sequtils, sets,algorithm
import regex

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc MullItOver*(fileName: string): int =
    let
        inputSeq: seq[string] = getInputFromFile(fileName) 
    var
        captures = newSeq[string]()

    for iseq in inputSeq:
        for m in findAll(iseq,re2"(mul\([[:digit:]]+,[[:digit:]]+\))"):
            captures.add(iseq[m.group(0)])

    var answer = 0    
    for c in captures:
        var cleanedString = c.replace("mul(","").replace(")","")
        var splitString = cleanedString.split(",")
        answer += (parseInt(splitString[0]) * parseInt(splitString[1]))

    echo "Answer is " & $answer
    return answer