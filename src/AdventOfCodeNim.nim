import std/[strutils,strformat,streams,os,osproc,times,tables,sequtils,algorithm,terminal,cmdline,
    compilesettings,dynlib
    ]

# Utility to get input file path
proc getDayInputFile*(year: string, day: string): string =
    &"{os.getcurrentdir()}\\inputFiles\\{year}\\day{day}.txt"

# Dynamically compile and load a Nim module
proc compileAndLoadModule*(year, day, part: string):string =
    var
        moduleName = &"Year{year}_Day{day}Mod"
    if part == "2":
        moduleName = &"{moduleName}_Part2"
    var
        sourceFile = &"src/Year{year}/{moduleName}.nim"
        outputDir = getCurrentDir() / "bin"
        outputExe = outputDir / &"{moduleName}.exe"

    # Ensure output directory exists
    createDir(outputDir)

    # Compile the specific module
    let compileCmd = &"nim c -d:release --outDir:{outputDir} {sourceFile}"
    let res = execProcess(compileCmd)
    echo res
    return outputExe


proc executeWithRedirection(exePath: string, inputFile: string, outputFileName = "output_debug.txt") =
    
    # let shellCommand = "cmd /C " & exePath & " " & inputFile & " >> " & outputFileName & " 2>&1"
    let shellCommand = &"cmd /C {exePath} {inputFile} > {outputFileName} 2>&1"
    echo "Executing command: " & shellCommand
    
    # Ensure that the output file is writable and accessible
    if not fileExists(outputFileName):
        echo "Creating output file test.txt at: " & outputFileName
        writeFile(outputFileName, "")  # Create an empty file if it doesn't exist
    
    # Execute the command through cmd.exe (shell)
    let result = execCmdEx(shellCommand)
    
    echo "Execution result: ", result.output
    echo "Exit code: ", result.exitCode
    
    if result.exitCode != 0:
        echo "Error executing the command."
    else:
        echo "Command executed successfully, output redirected to test.txt"

# Main command processor
proc runAdventCommand*(year, day, part: string): string =
    let
        inputFile = getDayInputFile(year, day)
    let exePath = compileAndLoadModule(year, day, part)
    echo &"{exePath=}"
    echo &"{inputFile=}"
    executeWithRedirection(exePath, inputFile)

# Command line argument parsing
proc parseRunCommand*(input: string): tuple[year, day, part: string] =
    let splitInput = input.split(" ")
    if splitInput.len != 3:
        raise newException(ValueError, "Invalid input format. Use 'YEAR DAY PART'")

    result = (
        year: splitInput[0],
        day: splitInput[1],
        part: splitInput[2]
    )

proc runAndBenchmark(inputString: string) =
    let startTimeCPU = cpuTime()
    let startTimeDT = now()

    let (year, day, part) = parseRunCommand(inputString)
    let result = runAdventCommand(year, day, part)
    echo result

    let endTimeCPU = cpuTime()
    let endTimeDT = now()
    echo "CPU Time: ", endTimeCPU - startTimeCPU
    echo "Duration: ", endTimeDT - startTimeDT

when isMainModule:
    try:
        let enableHardcode = true
        if enableHardcode:
            runAndBenchmark("2024 7 1")
        else:
            if commandLineParams().len == 0:
                echo "Available Functions:"
                echo "----------------\n\r\nEnter ID:"
                let consoleInput = readline(stdin)
                runAndBenchmark(consoleInput)
            else:
                runAndBenchmark(commandLineParams()[0])

    except:
        let e = getCurrentException()
        echo "Error: ", e.msg
