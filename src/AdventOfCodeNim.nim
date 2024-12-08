import strutils, strformat, streams, os, times, tables, sequtils, algorithm, terminal
import Year2020/Year2020_Day1Mod
import Year2020/Year2020_Day1Mod_Part2
import Year2020/Year2020_Day2Mod
import Year2020/Year2020_Day2Mod_Part2
import Year2020/Year2020_Day3Mod
import Year2020/Year2020_Day3Mod_Part2
import Year2020/Year2020_Day4Mod
import Year2020/Year2020_Day4Mod_Part2
import Year2020/Year2020_Day5Mod
import Year2020/Year2020_Day5Mod_Part2
import Year2020/Year2020_Day6Mod
import Year2020/Year2020_Day6Mod_Part2

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

import Year2024/Year2024_Day1Mod
import Year2024/Year2024_Day1Mod_Part2
import Year2024/Year2024_Day2Mod
import Year2024/Year2024_Day2Mod_part2
import Year2024/Year2024_Day3Mod
import Year2024/Year2024_Day3Mod_Part2
import Year2024/Year2024_Day4Mod
import Year2024/Year2024_Day4Mod_Part2
import Year2024/Year2024_Day5Mod
import Year2024/Year2024_Day5Mod_Part2
import Year2024/Year2024_Day6Mod
import Year2024/Year2024_Day6Mod_Part2
import Year2024/Year2024_Day7Mod
import Year2024/Year2024_Day7Mod_Part2


proc getDayInputFile(year: string, day: string): string =
    var retPath = ""

    retPath = &"{os.getcurrentdir()}\\inputFiles\\{year}\\day{day}.txt"
    retPath

when isMainModule:

    # echo $Year2024_Day7Mod.BridgeRepair(getDayInputFile("2024", "7"))
    # echo $Year2024_Day7Mod_Part2.BridgeRepair(getDayInputFile("2024", "7"))
    # quit()

    # There is probably a better way to do all this
    # TODO later on
    echo "Which function do you want to run?\n"
    var AVAILABLE_FUNCTIONS_TO_RUN = @[
        "2020 1 1 -> Day 1 2020 Part 1",
        "2020 1 2 -> Day 1 2020 Part 2",
        "2020 2 1 -> Day 2 2020 Part 1",
        "2020 2 2 -> Day 2 2020 Part 2",
        "2020 3 1 -> Day 3 2020 Part 1",
        "2020 3 2 -> Day 3 2020 Part 2",
        "2020 4 1 -> Day 4 2020 Part 1",
        "2020 4 2 -> Day 4 2020 Part 2",
        "2020 5 1 -> Day 5 2020 Part 1",
        "2020 5 2 -> Day 5 2020 Part 2",
        "2020 6 1 -> Day 6 2020 Part 1",

        "2023 1 1 -> Day 1 2023 Part 1",
        "2023 1 2 -> Day 1 2023 Part 2",
        "2023 2 1 -> Day 2 2023 Part 1",
        "2023 2 2 -> Day 2 2023 Part 2",
        "2023 3 1 -> Day 3 2023 Part 1",
        "2023 3 2 -> Day 3 2023 Part 2",
        "2023 4 1 -> Day 4 2023 Part 2",
        "2023 4 2 -> Day 4 2023 Part 2",
        "2023 5 1 -> Day 5 2023 Part 1",
        "2023 5 2 -> Day 5 2023 Part 2",
        "2023 6 1 -> Day 6 2023 Part 1",
        "2023 6 2 -> Day 6 2023 Part 2",
        
        "2024 1 1 -> Day 1 2024 Part 1",
        "2024 1 2 -> Day 1 2024 Part 2",
        "2024 2 1 -> Day 2 2024 Part 1",
        "2024 2 2 -> Day 2 2024 Part 2",
        "2024 3 1 -> Day 3 2024 Part 1",
        "2024 3 2 -> Day 3 2024 Part 2",        
        "2024 4 1 -> Day 4 2024 Part 1",
        "2024 4 2 -> Day 4 2024 Part 2", 
        "2024 5 1 -> Day 5 2024 Part 1",
        "2024 5 2 -> Day 5 2024 Part 2",
        "2024 6 1 -> Day 6 2024 Part 1",
        "2024 6 2 -> Day 6 2024 Part 2",
        ]

    for af in AVAILABLE_FUNCTIONS_TO_RUN:
        echo af

    echo "----------------\n\r\nEnter ID:"

    var consoleInput = readline(stdin)
    echo consoleInput

    var
        splitInput = consoleInput.split(" ").toSeq()
        yearInput = splitInput[0]
        dayInput = splitInput[1]
        partInput = splitInput[2]
        inputFilePath = getDayInputFile(yearInput, dayInput)

    var startTimeCPU = cpuTime()
    var startTimeDT = now()

    case consoleInput:
        of "2020 1 1":
            echo $Year2020_Day1Mod.ReportRepair(inputFilePath)
        of "2020 1 2":
            echo $Year2020_Day1Mod_Part2.ReportRepair(inputFilePath)
        of "2020 2 1":
            echo $Year2020_Day2Mod.PasswordPhilosphy(inputFilePath)
        of "2020 2 2":
            echo $Year2020_Day2Mod_Part2.PasswordPhilosphy(inputFilePath)
        of "2020 3 1":
            echo $Year2020_Day3Mod.TobogganTrajectory(inputFilePath)
        of "2020 3 2":
            echo $Year2020_Day3Mod_Part2.TobogganTrajectory(inputFilePath)
        of "2020 4 1":
            echo $Year2020_Day4Mod.PassportProcessing(inputFilePath)
        of "2020 4 2":
            echo $Year2020_Day4Mod_Part2.PassportProcessing(inputFilePath)
        of "2020 5 1":
            echo $Year2020_Day5Mod.BinaryBoarding(inputFilePath)
        of "2020 5 2":
            echo $Year2020_Day5Mod_Part2.BinaryBoarding(inputFilePath)
        of "2020 6 1":
            echo $Year2020_Day6Mod.CustomCustoms(inputFilePath)
        of "2020 6 2":
            echo $Year2020_Day6Mod_Part2.CustomCustoms(inputFilePath)

        of "2023 1 1":
            echo $Year2023_Day1Mod.Trebuchet(inputFilePath)
        of "2023 1 2":
            echo $Year2023_Day1Mod_Part2.Trebuchet(inputFilePath)
        of "2023 2 1":
            echo $Year2023_Day2Mod.CubeConundrum(inputFilePath)
        of "2023 2 2":
            echo $Year2023_Day2Mod_Part2.CubeConundrum(inputFilePath)
        of "2023 3 1":
            echo $Year2023_Day3Mod.GearRatio(inputFilePath)
        of "2023 3 2":
            echo $Year2023_Day3Mod_Part2.GearRatio(inputFilePath)
        of "2023 4 1":
            echo $Year2023_Day4Mod.Scratchcards(inputFilePath)
        of "2023 4 2":
            echo $Year2023_Day4Mod_Part2.Scratchcards(inputFilePath)
        of "2023 5 1":
            echo $Year2023_Day5Mod.IfYouGiveASeedAFertilizer(inputFilePath)
        of "2023 5 2":
            echo $Year2023_Day5Mod_Part2.IfYouGiveASeedAFertilizer(inputFilePath)
        of "2023 6 1":
            echo $Year2023_Day6Mod.WaitForIt(inputFilePath)
        of "2023 6 2":
            echo $Year2023_Day6Mod_Part2.WaitForIt(inputFilePath)
        
        of "2024 1 1":
            echo $Year2024_Day1Mod.HistorianHysteria(inputFilePath)
        of "2024 1 2":
            echo $Year2024_Day1Mod_Part2.HistorianHysteria(inputFilePath)
        of "2024 2 1":
            echo $Year2024_Day2Mod.RedNosedReports(inputFilePath)
        of "2024 2 2":
            echo $Year2024_Day2Mod_Part2.RedNosedReports(inputFilePath)
        of "2024 3 1":
            echo $Year2024_Day3Mod.MullItOver(inputFilePath)
        of "2024 3 2":
            echo $Year2024_Day3Mod_Part2.MullItOver(inputFilePath)
        of "2024 4 1":
            echo $Year2024_Day4Mod.CeresSearch(inputFilePath)
        of "2024 4 2":
            echo $Year2024_Day4Mod_Part2.CeresSearch(inputFilePath)
        of "2024 5 1":
            echo $Year2024_Day5Mod.PrintQueue(inputFilePath)
        of "2024 5 2":
            echo $Year2024_Day5Mod_Part2.PrintQueue(inputFilePath)
        of "2024 6 1":
            echo $Year2024_Day6Mod.GuardGallivant(inputFilePath)
        of "2024 6 2":
            echo $Year2024_Day6Mod_Part2.GuardGallivant(inputFilePath)

        else:
            echo "Unknown ID for what to run"

    var endTimeCPU = cpuTime()
    var endTimeDT = now()

    echo endTimeCPU - startTimeCPU
    echo endTimeDT - startTimeDT

