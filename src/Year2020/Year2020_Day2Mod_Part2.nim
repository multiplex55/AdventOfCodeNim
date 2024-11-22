import strutils, strformat, streams, os, times, tables, sequtils, algorithm

proc PasswordPhilosphy*(fileName: string): int =
    echo fileName
    var
        sum: int
        fileStrm = openfilestream(fileName, fmRead)
        inputSeq: seq[string]

    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    for iSeq in inputSeq:
        var splitLine = iSeq.split(":")
        var nums = splitLine[0].split(" ")[0]
        var letter = splitLine[0].split(" ")[1][0]
        var passwordString = splitLine[1].split(" ")[1]

        #echo "Nums " & $nums
        var
            lower: int
            upper: int
        lower = parseInt(nums.split("-")[0])
        upper = parseInt(nums.split("-")[1])

        #echo "letter " & $letter
        #echo "passwordString: " & $passwordString
        var 
            currentCount: int
        for i,l in passwordString:
            #echo l
            if((i+1 == lower and l == letter) or (i+1 == upper and l == letter)):
                currentCount += 1
        #echo "CurrentCount " & $currentCount
        if(currentCount == 1):
            sum += 1
            echo "Valid Pass: " & iSeq 
        else:
            echo "Invalid Pass: " & iSeq 


    return sum

