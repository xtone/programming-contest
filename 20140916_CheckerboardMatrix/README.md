# Checkerboard Matrix

出題元URL：https://code.google.com/codejam/contest/7214486/dashboard#s=p0

## Problem

When she is bored, Mija sometimes likes to play a game with matrices. She tries to transform one matrix into another with the fewest moves. For Mija, one move is swapping any two rows of the matrix or any two columns of the matrix.

ミージャは暇なときに、マトリックスを使ってゲームをします。そのゲームとは、マトリックスを別のマトリックスに最小の手数で変換するというものです。このゲームにおいて1手でできるのは、マトリックスのある列と別の列を入れ替えることか、ある行と別の行を入れ替えることです。

Today, Mija has a very special matrix **M**. **M** is a 2 **N** by 2 **N** matrix where every entry is either a 0 or a 1. Mija decides to try and transform **M** into a checkerboard matrix where the entries alternate between 0 and 1 along each row and column. Can you help Mija find the minimum number of moves to transform **M** into a checkerboard matrix?

今日、ミージャは特別なマトリックス **M** を使うことにしました。 **M** は 2 **N** x 2 **N** のマトリクッスで、全ての値が0か1になっています。ミージャはこの **M** をチェッカーボード模様のマトリックスに変換することにしました。チェッカボード模様のマトリックスは0と1が行と列の両方で交互に出現するマトリクッスです。ミージャが **M** をチェッカボード模様のマトリックスに変換する最小の手数を探す手伝いをして下さい！

## Input

The first line of the input gives the number of test cases, **T**.  Each test case starts with a line containing a single integer: **N**. The next 2 **N** lines each contain 2 **N** characters which are the rows of **M**; each character is a 0 or 1.

最初の行は問題の数 **T** が書いてあります。以下 **T** 個の問題が続きます。各問題の最初の行には1つの整数 **N** が書いてあります。次に 2 **N** 行が続き、それぞれの行には 2 **N** 個の0または1が書いてあります。これが **M** の各行となります。

## Output

For each test case, output one line containing "Case #x: **y**", where **x** is the test case number (starting from 1) and **y** is the minimum number of row swaps and column swaps required to turn **M** into a checkerboard matrix. If it is impossible to turn **M** into a checkerboard matrix, **y** should be "IMPOSSIBLE".

各問題について、1行で "Case #x: **y**" と出力してください。 **x** は1から始まる問題番号、 **y** は **M** をチェッカーボード模様のマトリックスに変換するために必要な最小の手数です。ただし、 **M** をチェッカーボード模様のマトリックスに変換することができない場合は、 **y** は "IMPOSSIBLE" として下さい。

## Limits

1 ≤ **T** ≤ 100.

## Small dataset

1 ≤ **N** ≤ 10.

## Large dataset

1 ≤ **N** ≤ 1000.

## Sample

```
Input 

3
1
01
10
2
1001
0110
0110
1001
1
00
00

Output 

Case #1: 0
Case #2: 2
Case #3: IMPOSSIBLE
```

## Note

In the first sample case, **M** is already a checkerboard matrix.
最初の例では、 **M**は既にチェッカーボード模様のマトリックスです。

In the second sample case, Mija can turn **M** into a checkerboard matrix by swapping columns 1 and 2 and then swapping rows 1 and 2.
2つ目の例では、ミージャは **M** をチェッカボード模様のマトリックスにするために、1列目と2列目を入れ替え、次に1行目と2行目を入れ替える必要があります。

In the third sample case, Mija can never turn **M** into a checkerboard matrix; it doesn't have enough 1s.
3つ目の例では、ミージャは **M** をチェッカーボード模様のマトリクッスにすることができません。十分な数の1が無いからです。
