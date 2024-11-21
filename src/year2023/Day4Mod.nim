# https://adventofcode.com/2023/day/4
import strutils, strformat, streams, os, times, tables, algorithm, sequtils

type ScratchCard = object
    cardId: int
    cardNumbers: seq[int]
    winningNumbers: seq[int]

proc ScratchCards*(fileName: string): int =
    var
        sum = 0
        fileStrm = openfilestream(fileName, fmRead)
        scratchcardSeq: seq[ScratchCard]

    defer: fileStrm.close()

    for line in fileStrm.lines:
        echo line
        # Get ID
        var cardId = line.split(':')[0].split(' ')[^1].strip()

        # Get winningNumbers
        var winningNumbers = line.split(':')[1].split('|')[0].split(
                " ").filterIt(it != "").map(parseInt)
        echo winningNumbers

        # Get cardNumbers
        var cardNumbers = line.split(':')[1].split('|')[1].split(" ").filterIt(
                it != "").map(parseInt)
        echo cardNumbers

        var currentScratchCard = ScratchCard(cardId: parseInt(cardId),
                cardNumbers: cardNumbers, winningNumbers: winningNumbers)
        scratchcardSeq.add(currentScratchCard)

    for sc in scratchcardSeq:
        var
            winningNumbersFound: seq[int]
            currentCardValue: int

        for wn in sc.winningNumbers:
            if wn in sc.cardNumbers:
                winningNumbersFound.add(wn)
        for wnf in winningNumbersFound:
            if currentCardValue == 0:
                currentCardValue = 1
            else:
                currentCardValue *= 2
        echo &"currentCardValue {currentCardValue}"
        sum += currentCardValue

        echo "---------"

    return sum

