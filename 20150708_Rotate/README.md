## Rotate

出題元URL：https://code.google.com/codejam/contest/544101/dashboard#s=p0

## Problem

In the exciting game of Join-K, red and blue pieces are dropped into an N-by-N table. The table stands up vertically so that pieces drop down to the bottom-most empty slots in their column. For example, consider the following two configurations:

##### - Legal Position -

              .......
              .......
              .......
              ....R..
              ...RB..
              ..BRB..
              .RBBR..


##### - Illegal Position -

               .......
               .......
               .......
               .......
       Bad ->  ..BR...
               ...R...
               .RBBR..

In these pictures, each '.' represents an empty slot, each 'R' represents a slot filled with a red piece, and each 'B' represents a slot filled with a blue piece. The left configuration is legal, but the right one is not. This is because one of the pieces in the third column (marked with the arrow) has not fallen down to the empty slot below it.

A player wins if they can place at least K pieces of their color in a row, either horizontally, vertically, or diagonally. The four possible orientations are shown below:

##### - Four in a row -


     R   RRRR    R   R
     R          R     R
     R         R       R
     R        R         R

In the "Legal Position" diagram at the beginning of the problem statement, both players had lined up two pieces in a row, but not three.

As it turns out, you are right now playing a very exciting game of Join-K, and you have a tricky plan to ensure victory! When your opponent is not looking, you are going to rotate the board 90 degrees clockwise onto its side. Gravity will then cause the pieces to fall down into a new position as shown below:

#####  - Start -
     .......
     .......
     .......
     ...R...
     ...RB..
     ..BRB..
     .RBBR..

#####  - Rotate -
     .......
     R......
     BB.....
     BRRR...
     RBB....
     .......
     .......
#####  - Gravity -

     .......
     .......
     .......
     R......
     BB.....
     BRR....
     RBBR...

Unfortunately, you only have time to rotate once before your opponent will notice.
All that remains is picking the right time to make your move. Given a board position, you should determine which player (or players!) will have K pieces in a row after you rotate the board clockwise and gravity takes effect in the new direction.

## Note

You can rotate the board only once.
Assume that gravity only takes effect after the board has been rotated completely.
Only check for winners after gravity has finished taking effect.

## Input

The first line of the input gives the number of test cases, T. T test cases follow, each beginning with a line containing the integers N and K. The next N lines will each be exactly N characters long, showing the initial position of the board, using the same format as the diagrams above.

The initial position in each test case will be a legal position that can occur during a game of Join-K. In particular, neither player will have already formed K pieces in a row.

## Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1), and y is one of "Red", "Blue", "Neither", or "Both". Here, y indicates which player or players will have K pieces in a row after you rotate the board.

## Limits

1 ≤ T ≤ 100.
3 ≤ K ≤ N.

## Small dataset

3 ≤ N ≤ 7.

## Large dataset

3 ≤ N ≤ 50.

## Sample



    Input 

    4
    7 3
    .......
    .......
    .......
    ...R...
    ...BB..
    ..BRB..
    .RRBR..
    6 4
    ......
    ......
    .R...R
    .R..BB
    .R.RBR
    RB.BBB
    4 4
    R...
    BR..
    BR..
    BR..
    3 3
    B..
    RB.
    RB.

    Output 

    Case #1: Neither
    Case #2: Both
    Case #3: Red
    Case #4: Blue