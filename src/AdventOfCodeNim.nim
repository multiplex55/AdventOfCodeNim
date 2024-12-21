import std/[strutils,strformat,streams,os,osproc,times,tables,sequtils,algorithm,terminal,cmdline,
    compilesettings,dynlib]

# Utility to get input file path
proc getDayInputFile*(year: string, day: string): string =
    &"{os.getcurrentdir()}\\inputFiles\\{year}\\day{day}.txt"

proc compileModule*(year, day, part: string):string =
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
        echo &"Command executed successfully, output redirected to {outputFileName}.txt"

# Main command processor
proc runAdventCommand*(year, day, part: string): string =
    let
        inputFile = getDayInputFile(year, day)
    let exePath = compileModule(year, day, part)
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

proc createDayFileTemplate(dayPath:string)=
    echo "TODO Create Day File Template"

proc createDayTemplate(inputString: string) =
    # TODO THIS IS ALL IN DEV STILL
    let (year, day, part) = parseRunCommand(inputString)

    # Create src Folder if it doesn't exist
    let yearFolderSource= &"src\\Year{year}" 
    if not dirExists(yearFolderSource):
        createDir(yearFolderSource)
        echo &"Created folder {yearFolderSource=}"

    # Create Part 1 and Part 2 src files
    var 
        part1File = &"{yearFolderSource}\\Year{year}_Day{day}.nim"
        part2File = &"{yearFolderSource}\\Year{year}_Day{day}_Part2.nim"

    # TODO Create Template File
    if not fileExists(part1File):
        writeFile(part1File, "")  
        echo &"Created {part1File=}"
    
    if not fileExists(part2File):
        writeFile(part2File, "")  
        echo &"Created {part2File=}"

    # Create input folder
    let yearFolderInputFiles = &"InputFiles\\{year}" 
    if not dirExists(yearFolderInputFiles):
        createDir(yearFolderInputFiles)
        echo &"Created Folder {yearFolderInputFiles=}"
    
    var inputFile = &"{yearFolderInputFiles}\\day{day}.txt"
    if not fileExists(inputFile):
        writeFile(inputFile, "")  

    # Create input file if

when isMainModule:
    try:
        createDayTemplate("2069 1 0")
        quit()
        let enableHardcode = true
        if enableHardcode:
            runAndBenchmark("2020 4 2")
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
