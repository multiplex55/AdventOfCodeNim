import strutils, strformat, streams, os, times, tables, sequtils, algorithm

proc ReportRepair*(fileName: string) :int =
    var 
        sum: int
        fileStrm = openfilestream(fileName, fmRead)
        inputSeq: seq[int]
        
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(parseInt(line))

    for i in 0 .. inputSeq.len():
        for j in i+1 .. inputSeq.len()-1:
            #echo &"i {i}: {inputseq[i]} j {j}: {inputseq[j]}"
            if inputseq[i] + inputseq[j] == 2020:
                sum += inputseq[i] * inputseq[j]
    return sum 

