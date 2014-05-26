# Cookie Clicker Alpha

出題元URL: https://code.google.com/codejam/contest/2974486/dashboard#s=p1

## Introduction

*Cookie Clicker* is a Javascript game by Orteil, where players click on a picture of a giant cookie. Clicking on the giant cookie gives them cookies. They can spend those cookies to buy buildings. Those buildings help them get even more cookies. Like this problem, the game is very cookie-focused. This problem has a similar idea, but it does not assume you have played *Cookie Clicker*. Please don't go play it now: it might be a long time before you come back.

*Cookie Clicker* はOrteilが作成した、大きなクッキーの絵をクリックするという、Javascrip製のゲームです。大きなクッキーをクリックすると、プレイヤーはクッキー(得点)を得ることができます。また得たクッキーを使って、建物を建てることができます。建物はさらにクッキーを得るための様々な効果をもっています。この問題と同様に、オリジナルのゲームもクッキーに大注目しているのです。さて、この問題は似たようなアイデアで作られていますが、*Cookie Clicker* をプレイする必要はありません。また、今 *Cookie Clicke* をプレイしないで下さい。さもないとこの問題に戻ってこれなくなります。

## Problem

In this problem, you start with 0 cookies. You gain cookies at a rate of 2 cookies per second, by clicking on a giant cookie. Any time you have at least **C** cookies, you can buy a cookie farm. Every time you buy a cookie farm, it costs you **C** cookies and gives you an extra **F** cookies per second.

この問題では、あなたは0枚のクッキーを持っている状態でスタートします。あなたは大きなクッキーの絵をクリックすることで、1秒間に2枚のクッキーを得ることができます。また、 **C** 枚のクッキーを持っていれば、クッキーファームを買うことができます。クッキーファームを買うと、**C** 枚のクッキーを支払うことになりますが、毎秒追加で **F** 枚のクッキーを得ることができるようになります。

Once you have **X** cookies that you haven't spent on farms, you win! Figure out how long it will take you to win if you use the best possible strategy.

**X** 枚のクッキーを手に入れればあなたの勝ちです。もちろん、クッキーファームを買うために使ったクッキーは数えません。さて、あなたが最高の戦略で挑んだ場合、何秒でゲームに勝つことができるでしょうか？

## Example

Suppose **C**=500.0, **F**=4.0 and **X**=2000.0. Here's how the best possible strategy plays out:

例では、**C**=500.0, **F**=4.0 and **X**=2000.0 であるとします。この場合の最高の戦略は以下の通りです。

1. You start with 0 cookies, but producing 2 cookies per second.
2. After **250** seconds, you will have **C**=500 cookies and can buy a farm that produces **F**=4 cookies per second.
3. After buying the farm, you have 0 cookies, and your total cookie production is 6 cookies per second.
4. The next farm will cost 500 cookies, which you can buy after about **83.3333333** seconds.
5. After buying your second farm, you have 0 cookies, and your total cookie production is 10 cookies per second.
6. Another farm will cost 500 cookies, which you can buy after **50** seconds.
7. After buying your third farm, you have 0 cookies, and your total cookie production is 14 cookies per second.
8. Another farm would cost 500 cookies, but it actually makes sense not to buy it: instead you can just wait until you have **X**=2000 cookies, which takes about **142.8571429** seconds.

　

1. まず0枚のクッキーからスタートします。この時点で秒間2枚のクッキーを得られます。
2. **250** 秒後に、500枚のクッキーを得て、**C**=500 となります。そこでクッキーファームを購入し。追加で秒間 **F**=4 枚のクッキーを得るようになります。
3. クッキーファームを購入した時点で、あなたは0枚のクッキーを持っていて、秒間6枚のクッキーを得るようになっています。
4. 次のクッキーファームを購入するには500枚のクッキーが必要なので、さらに **83.3333333** 秒待つ必要があります。
5. 2つ目のクッキーファームを購入すると、あなたは0枚のクッキーを持っていて、秒間10枚のクッキーを得るようになっています。
6. さらに次のクッキーファームを購入するには、**50** 秒待つ必要があります。
7. 3つ目のクッキーファームを購入すると、あなたは0枚のクッキーを持っていて、秒間14枚のクッキーを得るようになっています。
8. さらに次のクッキーファームを買うこともできますが、最高の戦略ではないのでもう購入しません。代わりに、**X**=2000 枚のクッキーができるまで **142.8571429** 秒待ちます。

Total time: 250 + 83.3333333 + 50 + 142.8571429 = 526.1904762 seconds.
Notice that you get cookies continuously: so 0.1 seconds after the game starts you'll have 0.2 cookies, and π seconds after the game starts you'll have 2π cookies.

合計時間: 250 + 83.3333333 + 50 + 142.8571429 = 526.1904762 秒
※あなたはクッキーを継続的に得ることができます。すなわち、ゲームがスタートして0.1秒後には、あなたは0.2枚のクッキーを持っていますし、π秒後には2π枚のクッキーを持っています。

## Input

The first line of the input gives the number of test cases, **T**. **T** lines follow. Each line contains three space-separated real-valued numbers: **C**, **F** and **X**, whose meanings are described earlier in the problem statement.

最初の行はテストケースの数 **T** が書いてあります。以下 **T** が続きます。各行には、3つの実数がスペース区切りで書かれています。**C** と **F** と **X** で、意味は前述の通りです。

**C**, **F** and **X** will each consist of at least 1 digit followed by 1 decimal point followed by from 1 to 5 digits. There will be no leading zeroes.

**C** と **F** と **X** は1桁以上の整数部と、1～5桁小数部からなります。0パディングはありません。

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the minimum number of seconds it takes before you can have **X** delicious cookies.

各テストケースについて、1行で "Case #x: y" と出力してください。x は1から始まるテストケース番号、yはあなたが美味しい **X** 枚のクッキーを得るまでに要する最短の時間(秒)です。

We recommend outputting y to 7 decimal places, but it is not required. y will be considered correct if it is close enough to the correct number: within an absolute or relative error of 10<sup>-6</sup>. See the FAQ for an explanation of what that means, and what formats of real numbers we accept.

yは有効数値7桁で表記することを推奨しますが、必須ではありません。絶対的または相対的な誤差が10の-6乗の範囲に収まっていれば正解と見做します。

## Limits

1 ≤ **T** ≤ 100.

## Small dataset

1 ≤ **C** ≤ 500.
1 ≤ **F** ≤ 4.
1 ≤ **X** ≤ 2000.

## Large dataset

1 ≤ **C** ≤ 10000.
1 ≤ **F** ≤ 100.
1 ≤ **X** ≤ 100000.

## Sample

```
Input 

4
30.0 1.0 2.0
30.0 2.0 100.0
30.50000 3.14159 1999.19990
500.0 4.0 2000.0

Output

Case #1: 1.0000000
Case #2: 39.1666667
Case #3: 63.9680013
Case #4: 526.1904762
```

## Note

*Cookie Clicker* was created by Orteil. Orteil does not endorse and has no involvement with Google Code Jam.

*Cookie Clicker* はOrteilによって作られました。OrteilはGoogle Code Jamとは何の関係もありません。
