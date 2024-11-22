#https://adventofcode.com/2023/day/5 
import strutils, strformat, streams, os, times, tables, sequtils, sets
import std/[asyncdispatch, threadpool]

type
  Mapping = tuple
    destStart: int
    sourceStart: int
    rangeLength: int

  MapRange = seq[Mapping]
  AllMaps = seq[MapRange]

proc parseMapping(line: string): Mapping =
  let parts = line.splitWhitespace()
  result = (parseInt(parts[0]), parseInt(parts[1]), parseInt(parts[2]))

proc loadMappings(fileName: string): (seq[tuple[start: int, length: int]], AllMaps) =
  var
    seedRanges: seq[tuple[start: int, length: int]]
    currentMap: MapRange
    allMaps: AllMaps

  for line in lines(fileName):
    if line.len == 0:
      if currentMap.len > 0:
        allMaps.add(currentMap)
        currentMap = @[]
      continue

    if line.startsWith("seeds:"):
      let numbers = line.split(":")[1].splitWhitespace().map(parseInt)
      for i in countup(0, numbers.len - 2, 2):
        seedRanges.add((numbers[i], numbers[i + 1]))
    elif not line.contains("map"):
      currentMap.add(parseMapping(line))

  if currentMap.len > 0:
    allMaps.add(currentMap)

  return (seedRanges, allMaps)

proc applyMapping(value: int, maps: AllMaps): int =
  result = value
  for mapRange in maps:
    for mapping in mapRange:
      let offset = result - mapping.sourceStart
      if offset >= 0 and offset < mapping.rangeLength:
        result = mapping.destStart + offset
        break

proc processRange(startSeed: int, rangeLength: int,
    maps: AllMaps): int {.thread.} =
  result = high(int)
  for seed in countup(startSeed, startSeed + rangeLength - 1):
    result = min(result, applyMapping(seed, maps))

proc processSeedRangesParallel(seedRanges: seq[tuple[start: int, length: int]],
    maps: AllMaps): int =
  var futures: seq[FlowVar[int]]

  # Split large ranges into smaller chunks for better parallelization
  const chunkSize = 1_000_000

  for (start, length) in seedRanges:
    var remaining = length
    var currentStart = start

    while remaining > 0:
      let currentChunkSize = min(remaining, chunkSize)
      futures.add(spawn processRange(currentStart, currentChunkSize, maps))
      remaining -= currentChunkSize
      currentStart += currentChunkSize

  result = high(int)
  for future in futures:
    result = min(result, ^future)

proc IfYouGiveASeedAFertilizer*(fileName: string): int =
  let (seedRanges, maps) = loadMappings(fileName)
  result = processSeedRangesParallel(seedRanges, maps)
