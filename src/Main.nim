import year2023/Day1Mod
import year2023/Day2Mod
import year2023/Day3Mod
import year2023/Day3Mod_Part2
import year2023/Day4Mod
import year2023/Day4Mod_Part2
import year2023/Day5Mod
import year2023/Day5Mod_Part2
import year2023/Day6Mod
import year2023/Day6Mod_Part2

import strutils, strformat, streams, os, times, tables, sequtils, algorithm, terminal

when isMainModule:
    echo "Which function do you want to run?\n"
    var AVAILABLE_FUNCTIONS_TO_RUN = @[
        "2023 1 1 -> Day 1 2023 Part 1",
        "2023 1 2 -> Day 1 2023 Part 2",
        "2023 2 1 -> Day 2 2023 Part 1",
        "2023 2 2 -> Day 2 2023 Part 2",
        "2023 3 1 -> Day 3 2023 Part 1",
        "2023 3 2 -> Day 3 2023 Part 2",
        "2023 4 1 -> Day 4 2023 Part 2",
        "2023 4 2 -> Day 4 2023 Part 2",
        "2023 5 1 -> Day 5 2023 Part 1",
        "2023 5 2 -> Day 5 2023 Part 1",
        "2023 6 1 -> Day 6 2023 Part 2",
        "2023 6 2 -> Day 6 2023 Part 2",
        ]

    for af in AVAILABLE_FUNCTIONS_TO_RUN:
        echo af

    echo "----------------\n\r\nEnter ID:"

    var consoleInput = readline(stdin)
    echo consoleInput

    var startTimeCPU = cpuTime()
    var startTimeDT = now()

    case consoleInput:
        of "2023 1 1":
            echo "Day1Part1 " & $Day1Mod.TrebuchetPart1(os.getCurrentDir() & "\\inputFiles\\2023\\day1.txt") 
        of "2023 1 2":
            echo "Day1Part2 " & $Day1Mod.TrebuchetPart2(os.getCurrentDir() & "\\inputFiles\\2023\\day1.txt")
        of "2023 2 1":
            echo "Day2Part1 " & $Day2Mod.CubeConundrumPart1(os.getCurrentDir() & "\\inputFiles\\2023\\day2.txt")
        of "2023 2 2":
            echo "Day2Part2 " & $Day2Mod.CubeConundrumPart2(os.getCurrentDir() & "\\inputFiles\\2023\\day2.txt")
        of "2023 3 1":
            echo "Day3Part1 " & $Day3Mod.GearRatioPart1(os.getCurrentDir() & "\\inputFiles\\2023\\day3.txt")
        of "2023 3 2":
            echo "Day3Part2 " & $Day3Mod_Part2.GearRatioPart2(os.getCurrentDir() & "\\inputFiles\\2023\\day3.txt")
        of "2023 4 1":
            echo "Day4Part1" & $Day4Mod.Scratchcards(os.getCurrentDir() & "\\inputFiles\\2023\\day4.txt")
        of "2023 4 2":
            echo "Day4Part2 " & $Day4Mod_Part2.Scratchcards(os.getCurrentDir() & "\\inputFiles\\2023\\day4.txt")
        of "2023 5 1":
            echo "Day5Part1 " & $Day5Mod.IfYouGiveASeedAFertilizer(os.getCurrentDir() & "\\inputFiles\\2023\\day5.txt")
        of "2023 5 2":
            echo "Day5Part2 " & $Day5Mod_Part2.IfYouGiveASeedAFertilizer(os.getCurrentDir() & "\\inputFiles\\2023\\day5.txt")
        of "2023 6 1":
            echo "Day6Part1 " & $Day6Mod.WaitForIt(os.getCurrentDir() & "\\inputFiles\\2023\\day6.txt")
        of "2023 6 2":
            echo "Day6Part2 " & $Day6Mod_Part2.WaitForIt(os.getCurrentDir() & "\\inputFiles\\2023\\day6.txt")
        else:
            echo "Unknown ID for what to run"

    var endTimeCPU = cpuTime()
    var endTimeDT = now()

    echo endTimeCPU - startTimeCPU
    echo endTimeDT - startTimeDT

