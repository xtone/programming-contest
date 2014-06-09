# The Repeater

出題元URL: https://code.google.com/codejam/contest/2994486/dashboard#s=p0

## Problem

Fegla and Omar like to play games every day. But now they are bored of all games, and they would like to play a new game. So they decided to invent their own game called "The Repeater".

フェグラとオーマーは毎日ゲームで遊んでいます。しかし、全てのゲームに飽きてしまったので、新しいゲームをプレイしたいと思っていました。
そこで、「繰り返すもの」という新しいゲームを開発することにしました。

They invented a 2 player game. Fegla writes down **N** strings. Omar's task is to make all the strings identical, if possible, using the minimum number of actions (possibly 0 actions) of the following two types:

開発したのは2人用のゲームです。まず、フェグラは **N** 個の文字列を書きます。対するオーマーの目的は、これらの文字列をできる限り少ないアクションで同じにすることです。アクションには次の2つがあります。

* Select any character in any of the strings and repeat it (add another instance of this character exactly after it). For example, in a single move Omar can change "abc" to "abbc" (by repeating the character 'b').
* Select any two adjacent and identical characters in any of the strings, and delete one of them. For example, in a single move Omar can change "abbc" to "abc" (delete one of the 'b' characters), but can't convert it to "bbc".

* いずれかの文字列のいずれかの文字を選び、繰り返します(選んだ文字の後に、選んだ文字を追加するということです)。例えば、オーマーは1回のアクションで、「abc」をbを選んで「abbc」とすることができます。
* いずれかの文字列のいずれかの2つの同じ文字が連続している部分を選んで、その文字を1文字削除します。例えば、オーマーは1回のアクションで、「abbc」をbを選んで「abc」とすることができます。しかし、「bbc」とすることはできません。

The 2 actions are independent; it's not necessary that an action of the first type should be followed by an action of the second type (or vice versa).

これらの2つのアクションは独立しています。1つ目のアクション(追加)の後に2つ目のアクション(削除)をする必要はありません。

Help Omar to win this game by writing a program to find if it is possible to make the given strings identical, and to find the minimum number of moves if it is possible.

どれくらい少ないアクションでゲームに勝つことが出来るか測定するプログラムを書いて、オーマーを助けてあげましょう。

## Input

The first line of the input gives the number of test cases, **T**. **T** test cases follow. Each test case starts with a line containing an integer **N** which is the number of strings. Followed by **N** lines, each line contains a non-empty string (each string will consist of lower case English characters only, from 'a' to 'z').

最初の行は問題の数 **T** が書いてあります。以下 **T** 個の問題が続きます。各問題の1行目には、文字列の個数を表わす **N** が書いてあります。以下 **N** 行が続き、各行には空ではない文字列が書いてあります(文字列は小文字の英字で「a」から「z」になります)。

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the minimum number of moves to make the strings identical. If there is no possible way to make all strings identical, print "Fegla Won" (quotes for clarity).

各問題について、1行で "Case #x: y" と出力してください。x は1から始まる問題番号、y は文字列を同じにする最小のアクションの回数です。もし、文字列を同じにすることができない場合は、「Fegla Won」と出力して下さい(カギカッコは除く)。

## Limits

1 ≤ **T** ≤ 100.
1 ≤ length of each string ≤ 100.
1 ≤ 各文字列の長さ ≤ 100.

## Small dataset

**N** = 2.

## Large dataset

2 ≤ **N** ≤ 100.

## Sample

```
Input 

5
2
mmaw
maw
2
gcj
cj
3
aaabbb
ab
aabb
2
abc
abc
3
aabc
abbc
abcc

Output

Case #1: 1
Case #2: Fegla Won
Case #3: 4
Case #4: 0
Case #5: 3
```
