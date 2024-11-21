#https://adventofcode.com/2023/day/6
import strutils, strformat, streams, os, times, tables, sequtils, sets

proc CalculateDistance(time: int, distance:int, holdTime:int): bool =
    echo &"{time} {distance} {holdTime}"
    var
        success:bool
    
    if distance < ((time-holdTime) * holdTime):
        success = true
    else:
        success = false
    return success
        
proc WaitForIt*(fileName: string): int =
    var
        fileStrm = openFileStream(fileName, fmRead)
        raceWins: seq[int]
        raceTimes: seq[int]
        distances: seq[int]

    defer: fileStrm.close()

    # Read through the file and process the mappings directly on the seeds
    for line in fileStrm.lines():
        if "Time" in line:
            raceTimes = line.replace("Time:","").split(" ").filterIt(it != "").map(parseInt).toSeq()
        if "Distance" in line:
            distances = line.replace("Distance:","").split(" ").filterIt(it != "").map(parseInt).toSeq()
            
    for t in raceTimes:
        raceWins.add(0)
    
    for i,race in raceTimes:
        for holdTime in 0 ..< race+1:
            if CalculateDistance(race,distances[i],holdTime):
                raceWins[i] += 1

    var res = foldl(raceWins,a * b) 

    return res 
