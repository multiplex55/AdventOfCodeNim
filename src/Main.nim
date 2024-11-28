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


proc getDayInputFile(year: string, day: string): string =
    var retPath = ""

    retPath = &"{os.getcurrentdir()}\\inputFiles\\{year}\\day{day}.txt"
    retPath

when isMainModule:

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
        "2023 5 2 -> Day 5 2023 Part 1",
        "2023 6 1 -> Day 6 2023 Part 2",
        "2023 6 2 -> Day 6 2023 Part 2",
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
        else:
            echo "Unknown ID for what to run"

    var endTimeCPU = cpuTime()
    var endTimeDT = now()

    echo endTimeCPU - startTimeCPU
    echo endTimeDT - startTimeDT

