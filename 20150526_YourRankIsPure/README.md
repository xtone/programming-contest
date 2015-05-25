# Your Rank is Pure

出題元URL：https://code.google.com/codejam/contest/635101/dashboard#s=p2

## Problem

Pontius: You know, I like this number 127, I don't know why.
Woland: Well, that is an object so pure. You know the prime numbers.
Pontius: Surely I do. Those are the objects possessed by our ancient masters hundreds of years ago. Oh, yes, why then? 127 is indeed a prime number as I was told.
Woland: Not... only... that. 127 is the 31st prime number; then, 31 is itself a prime, it is the 11th; and 11 is the 5th; 5 is the 3rd; 3, you know, is the second; and finally 2 is the 1st.
Pontius: Heh, that is indeed... purely prime.

ポンティウス: 知ってると思うけど、僕127って数字が好きなんだよね、なぜかは分からないんだけど。
ウォランド： あー、それはすごく純粋なモノだね。素数は知ってるよね?
ポンティウス： もちろん知ってるよ。数百年前に我々の祖先たるマイスター達が所有していたものだよね。お、そうだね、127は確かに素数だ。
ウォランド： それだけ…では…ない。127は31番目の素数だ。そして31も素数で、11番目だ。11は5番目の素数で、5は3番目の素数、そして3、これは2番目の素数で、2は最初の素数だ。
ポンティウス： ははーん、確かに。純粋な素数だ。

The game can be played on any subset S of positive integers. A number in S is considered pure with respect to S if, starting from it, you can continue taking its rank in S, and get a number that is also in S, until in finite steps you hit the number 1, which is not in S.
これは、どんな正の整数のサブセットSをつかっても出来ることです。Sの中の1つのある数が純粋である時、その数字がSの中で何番目かという値がSの中にあり、さらにその値がSの中で何番目にあるか…、ということを繰返していった時、最終的にSの中にない1にまで辿れます。

When n is given, in how many ways you can pick S, a subset of {2, 3, ..., n}, so that n is pure, with respect to S? The answer might be a big number, you need to output it modulo 100003.
nが与えられたとき、nが純粋となるような、いくつのサブセットS({2, 3, ..., n})を作ることができるでしょうか? 答えは非常に大きな数になるかもしれないので、出力はその数を100003で割った余りとして下さい。

## Input

The first line of the input gives the number of test cases, T. T lines follow. Each contains a single integer n.
最初の行は問題の数Tが書いてあります。以下T個の問題が続きます。各問題には1つの整数nが書いてあります。

## Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1) and y is the answer as described above.
各問題について、1行で "Case #x: y" と出力してください。 xは1から始まる問題番号、 yは上で説明した答えです。

## Limits

T ≤ 100.

## Small dataset

2 ≤ n ≤ 25.

## Large dataset

2 ≤ n ≤ 500.

## Sample

```
Input 

2
5
6

Output 

Case #1: 5
Case #2: 8
```
