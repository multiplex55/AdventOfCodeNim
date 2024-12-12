#https://adventofcode.com/2024/day/6
import strutils, strformat, streams, os, times, sequtils, algorithm

# Update grid dynamically, only modifying affected cells
proc updateGrid(grid: var seq[seq[char]], guardPos: (int, int), prevGuardPos: (int, int), visited: seq[(int, int)], currentDir: int, dirSymbols: seq[string]) =
    # Update the previous guard position to 'X' if it was visited
    if prevGuardPos in visited:
        grid[prevGuardPos[0]][prevGuardPos[1]] = 'x'
    
    # Update the current guard position with its direction symbol
    grid[guardPos[0]][guardPos[1]] = dirSymbols[currentDir][0]

# Reads input from a file and returns as a sequence of strings
proc getInputFromFile(fileName: string): seq[string] =
    var inputSeq: seq[string]
    for line in lines(fileName):
        inputSeq.add(line.strip())
    inputSeq

proc GuardGallivant*(fileName: string): int =
    # Parse input
    let inputLines = getInputFromFile(fileName)
    let rows = inputLines.len
    let cols = inputLines[0].len

    # Directions: (dy, dx) for up, right, down, left
    let directions = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    let dirSymbols = @["^", ">", "v", "<"]  # Symbols for directions
    var currentDir = 0  # Start facing up

    # Locate the guard's starting position
    var guardPos: (int, int)
    for y, line in inputLines:
        if "^" in line:
            guardPos = (y, line.find('^'))
            break

    # Convert input lines to a mutable grid
    var grid = inputLines.mapIt(it.toSeq())

    # Track visited positions
    var visited : seq[(int, int)]
    visited.addUnique(guardPos)

    # Previous guard position for dynamic updates
    var prevGuardPos = guardPos

    # Helper to check if a position is within bounds
    proc inBounds(pos: (int, int)): bool =
        pos[0] >= 0 and pos[0] < rows and pos[1] >= 0 and pos[1] < cols

    while inBounds(guardPos):
        updateGrid(grid, guardPos, prevGuardPos, visited, currentDir, dirSymbols)

        for line in grid:
            echo line.join("")
        echo ""

        # Determine the next position based on the current direction
        let nextPos = (guardPos[0] + directions[currentDir][0], guardPos[1] + directions[currentDir][1])

        if inBounds(nextPos):
            if inputLines[nextPos[0]][nextPos[1]] == '.' or dirSymbols.mapIt(it[0]).contains(inputLines[nextPos[0]][nextPos[1]]):
                # Move forward
                prevGuardPos = guardPos  # Save the previous position
                guardPos = nextPos
                visited.addUnique(guardPos)
            else:
                # Turn right
                currentDir = (currentDir + 1) mod 4
        else:
            break

    echo visited.len
    return visited.len

when isMainModule:
    if paramCount() == 1:
        echo GuardGallivant(paramStr(1))