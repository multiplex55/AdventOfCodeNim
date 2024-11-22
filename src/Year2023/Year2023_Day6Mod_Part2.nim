#https://adventofcode.com/2023/day/6
import strutils, strformat, streams, os, times, tables, sequtils, sets

proc CalculateDistance(time: int, distance: int, holdTime: int): bool =
    var
        success: bool

    if distance < ((time-holdTime) * holdTime):
        success = true
    else:
        success = false
    return success

proc WaitForIt*(fileName: string): int =
    var
        fileStrm = openFileStream(fileName, fmRead)
        raceWins: int
        raceTime: int
        distance: int

    defer: fileStrm.close()

    for line in fileStrm.lines():
        if "Time" in line:
            raceTime = line.replace("Time:", "").split(" ").filterIt(it !=
                    "").join("").parseInt()

        if "Distance" in line:
            distance = line.replace("Distance:", "").split(" ").filterIt(it !=
                    "").join("").parseInt()

    echo &"time {raceTime}"
    echo &"distance {distance}"

    for holdTime in 0 ..< raceTime:
        if CalculateDistance(raceTime, distance, holdTime):
            raceWins += 1

    return raceWins
