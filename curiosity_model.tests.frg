#lang forge/bsl "cm.tests" "whbjcaydktq4qa5f@gmail.com"
open "curiosity_model.frg"

test expect {
    {wellFormed[-2]} is unsat 
    {wellFormed[0]} is unsat
    {useDots[-1]} is unsat
    {maxComplexityPattern} is sat
}

test suite for wellFormed {

    example wellFormedOne is {wellFormed[3]} for {
        Dot = `D1
        row = `D1 -> 0
        col = `D1 -> 2
        no next 
    }

    example wellFormedMulti is {wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 0
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 1
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example wellFormedMultiMore is {wellFormed[4]} for {
        Dot = `D1 + `D2 + `D3 + `D4
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 0 + `D4 -> 3
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 1 + `D4 -> 3
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example vacuouslyTrue is {wellFormed[6]} for { }

    example notOnBoardRight is {not wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 3
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 1
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example notOnBoardDown is {not wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 1
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 3
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example notOnBoardLeft is {not wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> -1
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 1
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example notOnBoardUp is {not wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 1
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> -1
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example selfLoop is {not wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 1
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> -1
        next = `D1 -> `D1
    }

    example biggerSelfLoop is {not wellFormed[3]} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 1
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> -1
        next = `D1 -> `D2 + `D2 -> `D1
    }
}

test suite for allDiffSlopes {
    example vacuouslyTrueADS is {allDiffSlopes} for { }
    example onlyOneSlope is {allDiffSlopes} for { 
        Dot = `D1 + `D2
        row = `D1 -> 0 + `D2 -> 1
        col = `D1 -> 2 + `D2 -> 1
        next = `D1 -> `D2
    }
    example multiSlope is {allDiffSlopes} for { 
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 0
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 0
        next = `D1 -> `D2 + `D2 -> `D3
    }
    example allDiffSlope is {allDiffSlopes} for { 
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 + `D5 -> 0 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 1
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1 + `D5 -> 1 + `D6 -> 2 + `D7 -> 0 + `D8 -> 2 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example repeatMultiSlope is {not allDiffSlopes} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 2
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 0
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example repeatMultiSlopeNotObvious is {not allDiffSlopes} for {
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 2
        col = `D1 -> 2 + `D2 -> 1 + `D3 -> 0
        next = `D1 -> `D3 + `D3 -> `D2
    }

    example repeatwoutOrder is {not allDiffSlopes} for {
        Dot = `D1 + `D2 + `D3 + `D4
        row = `D1 -> 0 + `D2 -> 0 + `D3 -> 2 + `D4 -> 2
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4
    }
}

test suite for useDots {
    example fullExample is {useDots[9]} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 + `D5 -> 0 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 1
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1 + `D5 -> 1 + `D6 -> 2 + `D7 -> 0 + `D8 -> 2 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example partialExample is {useDots[4]} for { 
        Dot = `D1 + `D2 + `D3 + `D4
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 
    }

    
    example fullExamplePart is {useDots[4]} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 + `D5 -> 0 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 1
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1 + `D5 -> 1 + `D6 -> 2 + `D7 -> 0 + `D8 -> 2 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example vacuous is {not useDots[2]} for { }

    example notEnoughNext is {not useDots[5]} for {
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 + `D5 -> 0 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 1
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1 + `D5 -> 1 + `D6 -> 2 + `D7 -> 0 + `D8 -> 2 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }
}

test suite for androidLockPattern {
    example LLock is {androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 2 + `D5 -> 2 
        col = `D1 -> 0 + `D2 -> 0 + `D3 -> 0 + `D4 -> 1 + `D5 -> 2 
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 
    }
    example SLock is {androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 0 + `D3 -> 0 + `D4 -> 1 + `D5 -> 1 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 2
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 2 + `D5 -> 1 + `D6 -> 0 + `D7 -> 0 + `D8 -> 1 + `D9 -> 2
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }
    example SkipLock is {androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5
        row = `D1 -> 1 + `D2 -> 0 + `D3 -> 1 + `D4 -> 0 + `D5 -> 0
        col = `D1 -> 1 + `D2 -> 1 + `D3 -> 0 + `D4 -> 0 + `D5 -> 2 
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5
    }

    example badVac is {not androidLockPattern} for { }
    
    example LineLock is {not androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2
        next = `D1 -> `D2 + `D2 -> `D3
    }

    example selfLooping is {not androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 2 + `D5 -> 2 
        col = `D1 -> 0 + `D2 -> 0 + `D3 -> 0 + `D4 -> 1 + `D5 -> 2 
        next = `D1 -> `D1 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 
    }

    example badLooping is {not androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5
        row = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 2 + `D5 -> 2 
        col = `D1 -> 0 + `D2 -> 0 + `D3 -> 0 + `D4 -> 1 + `D5 -> 2 
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D1
    }

    example badSkipLock is {not androidLockPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5
        row = `D1 -> 1 + `D2 -> 2 + `D3 -> 2 + `D4 -> 2 + `D5 -> 1
        col = `D1 -> 1 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 + `D5 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5
    }

}

test suite for maxComplexityPattern {
    example maxComplex is {maxComplexityPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 0 + `D4 -> 1 + `D5 -> 0 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 1
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 1 + `D5 -> 1 + `D6 -> 2 + `D7 -> 0 + `D8 -> 2 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example cornerPattern is {maxComplexityPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 0 + `D3 -> 2 + `D4 -> 1 + `D5 -> 2 + `D6 -> 0 + `D7 -> 1 + `D8 -> 2 + `D9 -> 1
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 0 + `D5 -> 1 + `D6 -> 2 + `D7 -> 2 + `D8 -> 0 + `D9 -> 1
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example edgePattern is {maxComplexityPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 2 + `D3 -> 2 + `D4 -> 0 + `D5 -> 1 + `D6 -> 2 + `D7 -> 1 + `D8 -> 0 + `D9 -> 1
        col = `D1 -> 1 + `D2 -> 0 + `D3 -> 1 + `D4 -> 0 + `D5 -> 2 + `D6 -> 2 + `D7 -> 1 + `D8 -> 2 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example middlePattern is {maxComplexityPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 1 + `D2 -> 0 + `D3 -> 1 + `D4 -> 2 + `D5 -> 0 + `D6 -> 1 + `D7 -> 0 + `D8 -> 2 + `D9 -> 2
        col = `D1 -> 1 + `D2 -> 0 + `D3 -> 2 + `D4 -> 2 + `D5 -> 1 + `D6 -> 0 + `D7 -> 2 + `D8 -> 1 + `D9 -> 0
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }

    example SLockNotMaxComplex is {not maxComplexityPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5 + `D6 + `D7 + `D8 + `D9
        row = `D1 -> 0 + `D2 -> 0 + `D3 -> 0 + `D4 -> 1 + `D5 -> 1 + `D6 -> 1 + `D7 -> 2 + `D8 -> 2 + `D9 -> 2
        col = `D1 -> 0 + `D2 -> 1 + `D3 -> 2 + `D4 -> 2 + `D5 -> 1 + `D6 -> 0 + `D7 -> 0 + `D8 -> 1 + `D9 -> 2
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5 + `D5 -> `D6 + `D6 -> `D7 + `D7 -> `D8 + `D8 -> `D9
    }
    example SkipLockNotMaxComplex is {not maxComplexityPattern} for { 
        #Int = 5
        Dot = `D1 + `D2 + `D3 + `D4 + `D5
        row = `D1 -> 1 + `D2 -> 0 + `D3 -> 1 + `D4 -> 0 + `D5 -> 0
        col = `D1 -> 1 + `D2 -> 1 + `D3 -> 0 + `D4 -> 0 + `D5 -> 2 
        next = `D1 -> `D2 + `D2 -> `D3 + `D3 -> `D4 + `D4 -> `D5
    }

}