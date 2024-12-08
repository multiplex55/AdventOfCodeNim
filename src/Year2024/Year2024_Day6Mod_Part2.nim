import strutils, strformat, streams, os, times, sequtils, algorithm, sets
import std/[asyncdispatch, threadpool]

# Update grid dynamically, only modifying affected cells
proc updateGrid(grid: var seq[seq[char]], guardPos: (int, int), prevGuardPos: (int, int), visited: seq[(int, int)], currentDir: int, dirSymbols: seq[string]) =
    # Update the previous guard position to 'X' if it was visited
    if prevGuardPos in visited:
        grid[prevGuardPos[0]][prevGuardPos[1]] = '.' # x
    
    # Update the current guard position with its direction symbol
    grid[guardPos[0]][guardPos[1]] = dirSymbols[currentDir][0]

# Reads input from a file and returns as a sequence of strings
proc getInputFromFile(fileName: string): seq[string] =
    var inputSeq: seq[string]
    for line in lines(fileName):
        inputSeq.add(line.strip())
    inputSeq

proc simulateGuardPath(inputLines: seq[string], obstaclePos: (int, int)): int {.thread.} =
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
    
    # Place the obstacle
    if obstaclePos != guardPos:
        grid[obstaclePos[0]][obstaclePos[1]] = '@'

    # Track visited positions and path states
    var visited : seq[(int, int)]
    var pathStates : seq[(int, int, int)]  # (y, x, direction)
    
    visited.addUnique(guardPos)
    pathStates.addUnique((guardPos[0], guardPos[1], currentDir))

    # Previous guard position for dynamic updates
    var prevGuardPos = guardPos    

    # Helper to check if a position is within bounds
    proc inBounds(pos: (int, int)): bool =
        pos[0] >= 0 and pos[0] < rows and pos[1] >= 0 and pos[1] < cols

    var stepCount = 0
    const MAX_STEPS = 100000  # Prevent infinite loops

    while stepCount < MAX_STEPS:
        # This was messing it up, commenting out
        # updateGrid(grid, guardPos, prevGuardPos, visited, currentDir, dirSymbols)
        # for line in grid:
        #     echo line.join("")
        # echo ""

        # Determine the next position based on the current direction
        let nextPos = (guardPos[0] + directions[currentDir][0], guardPos[1] + directions[currentDir][1])
        # Check for loop condition
        if pathStates.contains((nextPos[0], nextPos[1], currentDir)):
            echo &"FOUND IT"
            return 1  # Guard is stuck in a loop

        if inBounds(nextPos):
            if grid[nextPos[0]][nextPos[1]] == '.' or 
                dirSymbols.mapIt(it[0]).contains(grid[nextPos[0]][nextPos[1]]):
                # Move forward
                prevGuardPos = guardPos  # Save the previous position
                guardPos = nextPos
                visited.addUnique(guardPos)
            else:
                # Turn right
                currentDir = (currentDir + 1) mod 4
        else:
            break  # Guard leaves the mapped area

        pathStates.addUnique((guardPos[0], guardPos[1], currentDir))
        inc(stepCount)

    return 0  # Guard not stuck in a loop

proc simulateGuardPathGetVisited(inputLines: seq[string], obstaclePos: (int, int)): seq[(int,int)] =
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
    
    # Place the obstacle
    if obstaclePos != guardPos:
        grid[obstaclePos[0]][obstaclePos[1]] = '#'

    # Track visited positions and path states
    var visited : seq[(int, int)]
    var pathStates : seq[(int, int, int)]  # (y, x, direction)
    
    visited.addUnique(guardPos)

    # Helper to check if a position is within bounds
    proc inBounds(pos: (int, int)): bool =
        pos[0] >= 0 and pos[0] < rows and pos[1] >= 0 and pos[1] < cols

    var stepCount = 0
    const MAX_STEPS = 10000  # Prevent infinite loops

    while stepCount < MAX_STEPS:
        # Determine the next position based on the current direction
        let nextPos = (guardPos[0] + directions[currentDir][0], guardPos[1] + directions[currentDir][1])

        if inBounds(nextPos):
            if inputLines[nextPos[0]][nextPos[1]] == '.' or 
                dirSymbols.mapIt(it[0]).contains(inputLines[nextPos[0]][nextPos[1]]):
                # Move forward
                guardPos = nextPos
                visited.addUnique(guardPos)
            else:
                # Turn right
                currentDir = (currentDir + 1) mod 4
        else:
            break  # Guard leaves the mapped area

        pathStates.addUnique((guardPos[0], guardPos[1], currentDir))
        inc(stepCount)

    visited

proc GuardGallivant*(fileName: string): int =
    # Parse input
    let inputLines = getInputFromFile(fileName)
    let rows = inputLines.len
    let cols = inputLines[0].len

    # Locate the guard's starting position
    var guardStartPos: (int, int)
    for y, line in inputLines:
        if "^" in line:
            guardStartPos = (y, line.find('^'))
            break

    var futures: seq[FlowVar[int]]
    # Find all possible obstruction positions
    var loopPositions = 0
    let visited = simulateGuardPathGetVisited(inputLines, guardStartPos)
    for v in visited:
        let 
            y = v[0]
            x = v[1]

        echo &"{y=} {x=}"
        # Skip the guard's starting positioy=n
        if (y, x) == guardStartPos:
            continue
        # threads go brrrrrr
        futures.add(spawn simulateGuardPath(inputLines, (y, x)))
        # Check if this position would create a loop when blocked
        # if simulateGuardPath(inputLines, (y, x)) == 1:
        #     inc(loopPositions)

    # # Thread collect
    for future in futures:
        loopPositions += ^future  
    echo "Number of positions that would trap the guard: ", loopPositions
    return loopPositions