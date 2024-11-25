import strutils, strformat, streams, os, times, tables, sequtils, algorithm, math

func doesTableContainAllValidKeys(passportTable: Table[string,string], passportValidKeys: seq[string]) : bool = 
    for ppvk in passportValidKeys:
        if not passportTable.hasKey(ppvk):
            return false
    return true

func validatePassportTableWithValidKeys(passportTable: seq[Table[string,string]], passportValidKeys: seq[string]) : int = 
    var answer: int

    for pt in passportTable:
        var validKeys = doesTableContainAllValidKeys(pt, passportValidKeys)
        if validKeys:
            answer += 1
    answer 

func splitPassportIntoKVPairs(inputString: string) : Table[string,string] = 
    var retTable: Table[string,string]

    for ss in inputString.split(" "):
        var splitSS = ss.split(":")
        retTable[splitSS[0]] = splitSS[1]
    return retTable

func createPassportTableFromGroupedInput(groupedInputSequence: seq[string]) : seq[Table[string,string]] = 
    var returnTables: seq[Table[string,string]]

    for i, row in groupedInputSequence:
        var currentTable = splitPassportIntoKVPairs(row)
        returnTables.add(currentTable) 
    returnTables
    
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

proc getInputFromFile(fileName:string) : seq[string] =
    var 
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines: 
        inputSeq.add(line)

    inputSeq

proc PassportProcessing*(fileName: string): int =
    let 
        passportValidKeys = @["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        groupedInputSequence = groupInputSequenceByBlank(getInputFromFile(fileName))
        passportTable = createPassportTableFromGroupedInput(groupedInputSequence)
    var answer = validatePassportTableWithValidKeys(passportTable, passportValidKeys)

    echo "Answer is " & $answer
    return answer
