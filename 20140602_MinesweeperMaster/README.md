# Minesweeper Master

出題元URL: https://code.google.com/codejam/contest/2974486/dashboard#s=p2

## Problem

*Minesweeper* is a computer game that became popular in the 1980s, and is still included in some versions of the *Microsoft Windows* operating system. This problem has a similar idea, but it does not assume you have played *Minesweeper*.

*Minesweeper* は1980年代に有名になったコンピュータゲームで、 *Microsoft Windows* についてくる場合もあります。
この問題は *Minesweeper* のアイデアを使っていますが、プレイ経験を前提にはしていません。

In this problem, you are playing a game on a grid of identical cells. The content of each cell is initially hidden. There are **M** mines hidden in **M** different cells of the grid. No other cells contain mines. You may click on any cell to reveal it. If the revealed cell contains a mine, then the game is over, and you lose. Otherwise, the revealed cell will contain a digit between 0 and 8, inclusive, which corresponds to the number of neighboring cells that contain mines. Two cells are neighbors if they share a corner or an edge. Additionally, if the revealed cell contains a 0, then all of the neighbors of the revealed cell are automatically revealed as well, recursively. When all the cells that don't contain mines have been revealed, the game ends, and you win.

この問題では、あなたはマス目のある盤面でゲームをします。最初、各マス目の内容は隠されています。盤面上には **M** 個の地雷が **M** 個の異なるマスに隠されています。その他のマスには地雷はありません。あなたは、好きなマス目を選んで開くことができます。もし、開いたマス目に地雷があれば、あなたの負けです。もし、開いたマス目に地雷がなければ、0～8の数字が表示されます。この数字は隣接するマス目に含まれている地雷の数を表しています(隣接には斜めも含みます)。また、もし開かれたマス目が0の場合、隣接するマス目も再帰的に開かれます。全ての地雷の無いマス目が開かれれば、あなたの勝ちとなります。

For example, an initial configuration of the board may look like this ('\*' denotes a mine, and 'c' is the first clicked cell):

例えば、盤面の初期配置が以下のような場合を考えましょう('\*' は地雷を表し、'c'が最初に選ぶマス目です)。

```
*..*...**.
....*.....
..c..*....
........*.
..........
```

There are no mines adjacent to the clicked cell, so when it is revealed, it becomes a 0, and its 8 adjacent cells are revealed as well. This process continues, resulting in the following board:

最初に選んだマス目に地雷はないので、開かれて0となります。0ですので、さらに隣接したマス目が開かれます。これを繰り返すと、以下のような状態の盤面となります。

```
*..*...**.
1112*.....
00012*....
00001111*.
00000001..
```

At this point, there are still un-revealed cells that do not contain mines (denoted by '.' characters), so the player has to click again in order to continue the game.
You want to win the game as quickly as possible. There is nothing quicker than winning in one click. Given the size of the board ( **R** x **C** ) and the number of hidden mines **M**, is it possible (however unlikely) to win in one click? You may choose where you click. If it is possible, then print any valid mine configuration and the coordinates of your click, following the specifications in the Output section. Otherwise, print "Impossible".

この時点で、地雷ではないまだ開かれていないマス目があります('.' で表わされます)。ですので、あなたは次のマス目を選ぶことになります。
さて、あなたはこのゲームに可能な限り早く勝ちたいと思っています。このゲームに勝つのに、1手より早い手はありません。盤面のサイズ( **R** x **C** )と隠された地雷の数 **M** が与えられたとき、1回の選択で勝つことができるでしょうか？あなたは、どのマス目を開くか好きに選ぶことができます。
もし1回の選択で勝てる可能性があれば、その可能性がある盤面と最初に選ぶマス目を、後に示すフォーマットで表示してください。
もし1回の選択で勝てる可能性がなければ、Impossibleと表示して下さい。

## Input

The first line of the input gives the number of test cases, **T**. **T** lines follow. Each line contains three space-separated integers: **R**, **C**, and **M**.

最初の行はテストケースの数 **T** が書いてあります。以下 **T** 行が続きます。各行には3つの整数がスペース区切りで書かれています。 **R** と **C** と **M** です。

## Output

For each test case, output a line containing "Case #x:", where x is the test case number (starting from 1). On the following **R** lines, output the board configuration with **C** characters per line, using '.' to represent an empty cell, '\*' to represent a cell that contains a mine, and 'c' to represent the clicked cell.

各テストケースについて、1行で "Case #x: y" と出力してください。x は1から始まるテストケース番号です。その後 **R** 行使って盤面の状態を表示して下さい。各行は **C** 文字で構成されます。地雷の無いマス目は'.'、地雷のあるマス目は'\*'、最初に開くマス目は'c'で表現して下さい。

If there is no possible configuration, then instead of the grid, output a line with "Impossible" instead. If there are multiple possible configurations, output any one of them.

もし、1回の選択で勝てる可能性のある盤面が無ければ、Impossibleという行を出力して下さい。もし、複数の1回の選択で勝てる可能性のある盤面がある場合は、そのうちいずれかの1つを出力して下さい。

## Limits

0 ≤ **M** < **R** * **C**.

## Small dataset

1 ≤ **T** ≤ 230.
1 ≤ **R**, **C** ≤ 5.

## Large dataset

1 ≤ **T** ≤ 140.
1 ≤ **R**, **C** ≤ 50.

## Sample

```
Input

5
5 5 23
3 1 1
2 2 1
4 7 3
10 10 82

Output

Case #1:
Impossible
Case #2:
c
.
*
Case #3:
Impossible
Case #4:
......*
.c....*
.......
..*....
Case #5:
**********
**********
**********
****....**
***.....**
***.c...**
***....***
**********
**********
**********
```
