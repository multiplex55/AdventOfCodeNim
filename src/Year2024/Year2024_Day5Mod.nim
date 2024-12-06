#https://adventofcode.com/2024/day/5
import strutils, strformat, streams, os, times, tables, sequtils, sets, algorithm
import std/[asyncdispatch, threadpool]

import strutils, sequtils

proc parseRules(rules: seq[string]): seq[(int, int)] =
    var parsedRules: seq[(int, int)] = @[]
    for rule in rules:
        let parts = rule.split("|")
        parsedRules.add((parts[0].parseInt(), parts[1].parseInt()))
    return parsedRules

proc isValidUpdate(update: seq[int], rules: seq[(int, int)]): bool =
    for (x, y) in rules:
        if x in update and y in update:
            if update.find(x) > update.find(y):
                return false
    return true

proc middlePage(update: seq[int]): int =
    update[update.len div 2]

proc getInputFromFile(fileName: string): seq[string] =
    var
        inputSeq: seq[string]
        fileStrm = openFileStream(fileName, fmRead)
    defer: fileStrm.close()

    for line in fileStrm.lines:
        inputSeq.add(line)

    inputSeq

proc PrintQueue*(fileName: string): int =
    let inputLines = getInputFromFile(fileName)
    let sections = inputLines.join("\n").split("\n\n")
    let orderingRules = parseRules(sections[0].splitLines())
    let updates = sections[1].splitLines().mapIt(it.split(",").map(parseInt))

    var validMiddlePages: seq[int] = @[]
    for update in updates:
        if isValidUpdate(update, orderingRules):
            validMiddlePages.add(middlePage(update))

    let answer = validMiddlePages.foldl(a + b)
    return answer
