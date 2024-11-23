import Year2020/Year2020_Day1Mod
import Year2020/Year2020_Day1Mod_Part2
import Year2020/Year2020_Day2Mod
import Year2020/Year2020_Day2Mod_Part2
import Year2020/Year2020_Day3Mod

import Year2023/Year2023_Day1Mod
import Year2023/Year2023_Day1Mod_Part2
import Year2023/Year2023_Day2Mod
import Year2023/Year2023_Day2Mod_Part2
import Year2023/Year2023_Day3Mod
import Year2023/Year2023_Day3Mod_Part2
import Year2023/Year2023_Day4Mod
import Year2023/Year2023_Day4Mod_Part2
import Year2023/Year2023_Day5Mod
import Year2023/Year2023_Day5Mod_Part2
import Year2023/Year2023_Day6Mod
import Year2023/Year2023_Day6Mod_Part2

import strutils, strformat, streams, os, times, tables, sequtils, algorithm, terminal

when isMainModule:
    
    echo "Day3Part1 " & $Year2020_Day3Mod.TobogganTrajectory(os.getcurrentdir() & "\\inputFiles\\2020\\day3.txt")
    quit()


    # There is probably a better way to do all this
    # TODO later on
    echo "Which function do you want to run?\n"
    var AVAILABLE_FUNCTIONS_TO_RUN = @[
        "2020 1 1 -> Day 1 2020 Part 1",
        "2020 1 2 -> Day 1 2020 Part 2",
        "2020 2 1 -> Day 2 2020 Part 1",
        "2020 2 2 -> Day 2 2020 Part 2",
        "2020 3 1 -> Day 3 2020 Part 1",

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
        of "2020 1 1":
            echo "Day1Part1 " & $Year2020_Day1Mod.ReportRepair(os.getcurrentdir() & "\\inputFiles\\2020\\day1.txt")
        of "2020 1 2":
            echo "Day1Part2 " & $Year2020_Day1Mod_Part2.ReportRepair(os.getcurrentdir() & "\\inputFiles\\2020\\day1.txt")
        of "2020 2 1":
            echo "Day2Part1 " & $Year2020_Day2Mod.PasswordPhilosphy(os.getcurrentdir() & "\\inputFiles\\2020\\day2.txt")
        of "2020 2 2":
            echo "Day2Part2 " & $Year2020_Day2Mod_Part2.PasswordPhilosphy(os.getcurrentdir() & "\\inputFiles\\2020\\day2.txt")
        of "2020 3 1":
            echo "Day3Part1 " & $Year2020_Day3Mod.TobogganTrajectory(os.getcurrentdir() & "\\inputFiles\\2020\\day3.txt")




        of "2023 1 1":
            echo "Day1Part1 " & $Year2023_Day1Mod.Trebuchet(os.getCurrentDir() & "\\inputFiles\\2023\\day1.txt") 
        of "2023 1 2":
            echo "Day1Part2 " & $Year2023_Day1Mod_Part2.Trebuchet(os.getCurrentDir() & "\\inputFiles\\2023\\day1.txt")
        of "2023 2 1":
            echo "Day2Part1 " & $Year2023_Day2Mod.CubeConundrum(os.getCurrentDir() & "\\inputFiles\\2023\\day2.txt")
        of "2023 2 2":
            echo "Day2Part2 " & $Year2023_Day2Mod_Part2.CubeConundrum(os.getCurrentDir() & "\\inputFiles\\2023\\day2.txt")
        of "2023 3 1":
            echo "Day3Part1 " & $Year2023_Day3Mod.GearRatio(os.getCurrentDir() & "\\inputFiles\\2023\\day3.txt")
        of "2023 3 2":
            echo "Day3Part2 " & $Year2023_Day3Mod_Part2.GearRatio(os.getCurrentDir() & "\\inputFiles\\2023\\day3.txt")
        of "2023 4 1":
            echo "Day4Part1 " & $Year2023_Day4Mod.Scratchcards(os.getCurrentDir() & "\\inputFiles\\2023\\day4.txt")
        of "2023 4 2":
            echo "Day4Part2 " & $Year2023_Day4Mod_Part2.Scratchcards(os.getCurrentDir() & "\\inputFiles\\2023\\day4.txt")
        of "2023 5 1":
            echo "Day5Part1 " & $Year2023_Day5Mod.IfYouGiveASeedAFertilizer(os.getCurrentDir() & "\\inputFiles\\2023\\day5.txt")
        of "2023 5 2":
            echo "Day5Part2 " & $Year2023_Day5Mod_Part2.IfYouGiveASeedAFertilizer(os.getCurrentDir() & "\\inputFiles\\2023\\day5.txt")
        of "2023 6 1":
            echo "Day6Part1 " & $Year2023_Day6Mod.WaitForIt(os.getCurrentDir() & "\\inputFiles\\2023\\day6.txt")
        of "2023 6 2":
            echo "Day6Part2 " & $Year2023_Day6Mod_Part2.WaitForIt(os.getCurrentDir() & "\\inputFiles\\2023\\day6.txt")
        else:
            echo "Unknown ID for what to run"

    var endTimeCPU = cpuTime()
    var endTimeDT = now()

    echo endTimeCPU - startTimeCPU
    echo endTimeDT - startTimeDT

