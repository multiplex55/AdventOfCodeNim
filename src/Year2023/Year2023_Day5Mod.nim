import strutils, strformat, streams, os, times, tables, sequtils, sets

# Apply mapping directly to a seed number if it hasn't been transformed by the current line index before.
proc applyMappingDirectly(seed: int, line: string, appliedMaps: var HashSet[int], lineIndex: int): int =
    let parts = line.split(" ").mapIt(parseInt(it))
    if parts.len != 3:
        return seed  # Skip invalid lines
    
    let (destinationStart, sourceStart, rangeLength) = (parts[0], parts[1], parts[2])
    if seed >= sourceStart and seed < sourceStart + rangeLength:
        # If the seed is in range and hasn't been transformed in this map yet
        if appliedMaps.len == 0:
            let offset = seed - sourceStart
            result = destinationStart + offset
            appliedMaps.incl(lineIndex)
            return result
    return seed

# Main function to read and process mappings one line at a time
proc IfYouGiveASeedAFertilizer*(fileName: string): int =
    var
        lowestSeedNumber = 0
        fileStrm = openFileStream(fileName, fmRead)
        seedList: seq[int] = @[]
        appliedMapsPerSeed: seq[HashSet[int]] = @[]
        readMapMode = false
        currentMap = ""

    defer: fileStrm.close()

    # Read through the file and process the mappings directly on the seeds
    for line in fileStrm.lines():
        if line.isEmptyOrWhitespace:
            readMapMode = false
            # Reset applied maps when we finish a section
            for i in 0 ..< appliedMapsPerSeed.len:
                appliedMapsPerSeed[i] = initHashSet[int]()
        elif line.contains("seeds:"):
            seedList = line.split(":")[1].split(" ").filterIt(it.len > 0).mapIt(parseInt(it))
            appliedMapsPerSeed = newSeqWith(seedList.len, initHashSet[int]())
        elif line.contains("map"):
            readMapMode = true
            currentMap = line
            # Reset applied maps when we start a new section
            for i in 0 ..< appliedMapsPerSeed.len:
                appliedMapsPerSeed[i] = initHashSet[int]()
        elif readMapMode:
            # Apply the mapping to each seed in the list directly
            for i in 0 ..< seedList.len:
                let oldValue = seedList[i]
                seedList[i] = applyMappingDirectly(seedList[i], line, appliedMapsPerSeed[i], 0)
                if oldValue != seedList[i]:
                    echo fmt"Transformed {oldValue} -> {seedList[i]} in {currentMap}"

    if seedList.len > 0:
        lowestSeedNumber = seedList.min()
    return lowestSeedNumber