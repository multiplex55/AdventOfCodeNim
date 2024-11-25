import strutils, strformat, streams, os, times, tables, sequtils, algorithm,
        math
import regex

proc validate_byr(fieldVal: string): bool =
    fieldVal.parseInt >= 1920 and fieldVal.parseInt <= 2002

proc validate_iyr(fieldVal: string): bool =
    fieldVal.parseInt >= 2010 and fieldVal.parseInt <= 2020

proc validate_eyr(fieldVal: string): bool =
    fieldVal.parseInt >= 2020 and fieldVal.parseInt <= 2030

func validate_hgt_in(fieldVal: string): bool =
    let cleanedVal = fieldVal.replace("in", "")
    return cleanedVal.parseInt >= 59 and cleanedVal.parseInt <= 76

func validate_hgt_cm(fieldVal: string): bool =
    let cleanedVal = fieldVal.replace("cm", "")
    return cleanedVal.parseInt >= 150 and cleanedVal.parseInt <= 193

proc validate_hgt(fieldVal: string): bool =
    if "cm" in fieldVal:
        return validate_hgt_cm(fieldVal)
    elif "in" in fieldVal:
        return validate_hgt_in(fieldVal)
    false

proc validate_hcl(fieldVal: string): bool =
    match(fieldVal, re2"\#[[:xdigit:]]{6}")

proc validate_ecl(fieldVal: string): bool =
    let validEyeColors = @["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    fieldVal in validEyeColors

proc validate_pid(fieldVal: string): bool =
    match(fieldVal, re2"[[:xdigit:]]{9}")

proc hasAllRequiredKeys(passportTable: Table[string, string]): bool =
    let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    for field in requiredFields:
        if not passportTable.hasKey(field):
            return false
    return true

proc validatePassportAgainstFields(passportTable: Table[string, string]): bool =
    var isValid = true

    if not hasAllRequiredKeys(passportTable):
        return false

    for field, val in passportTable:
        case field:
            of "byr":
                isValid = validate_byr(val)
            of "iyr":
                isValid = validate_iyr(val)
            of "eyr":
                isValid = validate_eyr(val)
            of "hgt":
                isValid = validate_hgt(val)
            of "hcl":
                isValid = validate_hcl(val)
            of "ecl":
                isValid = validate_ecl(val)
            of "pid":
                isValid = validate_pid(val)
            else:
                continue
        if not isValid:
            return isValid
    isValid

proc validatePassportTableWithValidKeys(passportTable: seq[Table[string,
        string]]): int =
    var answer: int
    for pt in passportTable:
        var isValid: bool = validatePassportAgainstFields(pt)
        if isValid:
            answer += 1
    answer

func splitPassportIntoKVPairs(inputString: string): Table[string, string] =
    var retTable: Table[string, string]

    for ss in inputString.split(" "):
        var splitSS = ss.split(":")
        retTable[splitSS[0]] = splitSS[1]
    return retTable

func createPassportTableFromGroupedInput(groupedInputSequence: seq[
        string]): seq[Table[string, string]] =
    var returnTables: seq[Table[string, string]]

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

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc PassportProcessing*(fileName: string): int =
    let
        groupedInputSequence = groupInputSequenceByBlank(getInputFromFile(fileName))
        passportTable = createPassportTableFromGroupedInput(groupedInputSequence)
    var answer = validatePassportTableWithValidKeys(passportTable)

    echo "Answer is " & $answer
    return answer
