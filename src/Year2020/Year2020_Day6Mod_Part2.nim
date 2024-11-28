import strutils, strformat, streams, os, times, tables, sequtils, algorithm, math

func groupInputSequenceByBlank(inputSeq: seq[string]): seq[string] =
    var 
        returnSeq: seq[seq[string]]
        activeSeq: seq[string]

    for line in inputSeq:
        if not line.isEmptyOrWhitespace():
            activeSeq.add(line)
        else:
            returnSeq.add(activeSeq)
            activeSeq.setLen(0)

    returnSeq.add(activeSeq)
    activeSeq = returnSeq.mapIt(it.join(" "))
    activeSeq
    
proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc CustomCustoms*(fileName: string): int =
    let
        inputCustoms: seq[string] = groupInputSequenceByBlank(getInputFromFile(fileName)) 
    var answer: int 
    for ic in inputCustoms:
        var icGroupLength = ic.split(" ").len()
        let letterCount = toCountTable(ic.replace(" ",""))
        for k,v in letterCount:
            if v == icGroupLength:
                answer += 1

    echo "Answer is " & $answer
    return answer
