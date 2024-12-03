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
        for m in findAll(iseq,re2"(mul\([[:digit:]]+,[[:digit:]]+\))|(don't)|(do)"):
            for g in 0..m.groupsCount-1:
                if m.group(g).allIt(it > 0):
                    captures.add(iseq[m.group(g)])

    var answer = 0    
    captures = captures.filterIt(it != "")
    var enableInstructions = true
    for c in captures:
        case c:
        of "don't":
            enableInstructions = false
        of "do":
            enableInstructions = true
        else:
            if enableInstructions:
                var cleanedString = c.replace("mul(","").replace(")","")
                var splitString = cleanedString.split(",")
                answer += (parseInt(splitString[0]) * parseInt(splitString[1]))

    echo "Answer is " & $answer
    return answer