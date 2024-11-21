# https://adventofcode.com/2023/day/4
import strutils, strformat, streams, os, times, tables, algorithm, sequtils

#Answer is supposed to be 6284877
type ScratchCard = object
    cardId: int
    cardNumbers: seq[int]
    winningNumbers: seq[int]
    winningNumberCount: int
    winningCardSequences: seq[int]
    hasBeenProcessed: bool

proc CreateCardDupes(cardSequence: seq[ScratchCard], idxToCheck: int): seq[ScratchCard] =
    var secondScratchcardSeq = cardSequence
    echo &"idx - {idxToCheck}"
    secondScratchcardSeq[idxToCheck].hasBeenProcessed = true
    for wcsi, wcs in cardsequence[idxToCheck].winningCardSequences:
        secondScratchcardSeq.add(cardSequence[wcs-1])
    return secondScratchcardSeq

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
        # echo winningNumbers

        # Get cardNumbers
        var cardNumbers = line.split(':')[1].split('|')[1].split(" ").filterIt(
                it != "").map(parseInt)
        # echo cardNumbers

        var currentScratchCard = ScratchCard(cardId: parseInt(cardId),
                cardNumbers: cardNumbers, winningNumbers: winningNumbers,
                winningNumberCount: 0)
        scratchcardSeq.add(currentScratchCard)

    var cardDupes: seq[seq[int]]
    for sc in scratchcardSeq:
        echo &"cardID {sc.cardId}"
        var
            winningNumbersFound: seq[int]
            currentCardValue: int

        for wn in sc.winningNumbers:
            if wn in sc.cardNumbers:
                winningNumbersFound.add(wn)
                scratchcardSeq[sc.cardId-1].winningNumberCount += 1

        var currentCardDupes: seq[int]
        for i, wnf in winningNumbersFound:
            echo &"i {i+1} wnf {wnf}"
            currentCardDupes.add(sc.cardId+(i+1))


        scratchcardSeq[sc.cardId-1].winningCardSequences = currentCardDupes
        for ccd in currentCardDupes:
            echo &"ccd {ccd}"
        cardDupes.add(currentCardDupes)

        # echo "---------"

    var
        dupedSequence = scratchcardSeq
        dupeIndexCounter: int
        ogSequenceLength = dupedSequence.len()
    echo &"ogSequenceLength {ogSequenceLength}"

    while dupedSequence.any(proc(card: ScratchCard): bool = not card.hasBeenProcessed):
        dupedSequence = CreateCardDupes(dupedSequence, dupeIndexCounter)
        dupeIndexCounter += 1
        for i, ds in dupedSequence:
            echo &"i: {i+1} ds: {ds}"

    for ds in dupedSequence:
        echo ds

    return dupedSequence.len() + ogSequenceLength

