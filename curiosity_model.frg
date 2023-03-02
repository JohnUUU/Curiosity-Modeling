#lang forge/bsl "cm" "whbjcaydktq4qa5f@gmail.com"
sig Dot {
    row: one Int,
    col: one Int,
    next: lone Dot
}


/* 
Enforces that all slopes used must be distinct 
WARNING: Prone to exploding in bitwidth with increasing board sizes. 
*/ 
pred allDiffSlopes {
    all disj d1, d2: Dot | (some d1.next and some d2.next) implies {
        multiply[subtract[d1.next.col, d1.col], subtract[d2.next.row,d2.row]] != multiply[subtract[d1.next.row,d1.row], subtract[d2.next.col,d2.col]]
        // (d1.next.row - d1.row) / (d1.next.col - d1.col) != () / (d2.next.col - d2.col)
    } 
}

/*
Enforces that at least n dots must be used
*/ 
pred useDots[n: Int] {
    n >= 0
    #{d : Dot | some d.next} >= subtract[n, 1]
}

/* 
Conditions: 
    - All Dots must be on the board of size [n x n]
    - There are no loops with next
*/ 
pred wellFormed[n : Int] {
    n > 0
    all d:Dot | {
        d.row < n and d.row >=0 and d.col >=0 and d.col < n 
        !reachable[d, d, next]
    }
    all disj d1, d2: Dot | {
        d1.row = d2.row => d1.col != d2.col
    }
}

/*
There are 4 rules for Android Lock Patterns 
    1. We cannot use one dot more than once 
    2. A Pattern must use at least 4 dots 
    3. The order of the Pattern matters and counts as distinct patterns
    4. No Skipping Dots, If connecting a dot to another dot goes through a third dot. The third dot must already 
    have been used. 
*/
pred androidLockPattern {

}

/*
Predicate that combines all of the above conditions to find the "Max Complexity Locks"
*/
pred maxComplexityPattern[n : Int] {
    n >= 4
    wellFormed[n]
    useDots[multiply[n, n]]
    // androidLockPattern
    allDiffSlopes
}

run {
    maxComplexityPattern[3]
} for exactly 9 Dot, 3 Int  for { next is linear }