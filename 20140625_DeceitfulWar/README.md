# Deceitful War

出題元URL: https://code.google.com/codejam/contest/2974486/dashboard#s=p3

## Problem

Naomi and Ken sometimes play games together. Before they play, each of them gets **N** identical-looking blocks of wood with masses between 0.0kg and 1.0kg (exclusive). All of the blocks have different weights. There are lots of games they could play with those blocks, but they usually play something they call War. Here is how War works:

ナオミとケンはゲーム仲間です。彼らのプレイする「戦争」と呼ばれるゲームは次のようなものです。まず、ゲーム前に、 それぞれ **N** 個の同じ見た目の、0.0kgから1.0kg(両端(0.0と1.0)を含まない)の木のブロックを用意します。全てのブロックは異なる重さです。「戦争」の内容は次の通りです。

1. Each player weighs each of his or her own blocks, so each player knows the weights of all of his or her own blocks, but not the weights of the other player's blocks.
2. They repeat the following process **N** times:
  1. Naomi chooses one of her own blocks, with mass Chosen~Naomi~.
  2. Naomi tells Ken the mass of the block she chose.
  3. Ken chooses one of his own blocks, with mass Chosen~Ken~.
  4. They each put their block on one side of a [balance scale](https://www.google.com/search?q=balance+scale&tbm=isch), and the person whose block is heavier gets one point.
  5. Both blocks are destroyed in a fire.
　
1. 各プレイヤーはそれぞれのブロックの重さを量ります。これで、自分の持ちブロックの重さを知ることができます。相手の持ちブロックの重さはわかりません。
2. 次のことを **N** 回繰り返します。
 1. ナオミは重さが Choosen~Naomi~ のブロックを1つ選びます。
 2. ナオミはケンに、選んだブロックの重さを伝えます。
 3. ケンは重さが Choosen~Ken~ のブロックを1つ選びます。
 4. 選んだブロックを天秤の左右に置きます。そして、重いブロックを選んでいたプレイヤーが1点を得ます。
 5. 選んだブロックを燃やします。

Naomi has realized three things about War. First, she has realized that she loses a lot. Second, she has realized that there is a unique strategy that Ken can follow to maximize his points without assuming anything about Naomi's strategy, and that Ken always uses it. Third, she has realized that she hates to lose. Naomi has decided that instead of playing War, she will play a game she calls Deceitful War. The great thing about Deceitful War is that Ken will think they're playing War!

ナオミは「戦争」に関して3つの事に気付きましたう。まずは、ぜんぜん勝てないということです。そして、ケンがナオミの戦術と関連の無い、ある戦術に従って最大の点を得ていて、常にその戦術を使っていることです。最後に、負けるのがいやだということです。
ナオミは「戦争」をするかわりに、「ペテン戦争」をすることに決めました。「ペテン戦争」のすばらしいところは、ケンは「戦争」をプレイしていると思い込んでいるところです！

Here is how Deceitful War works, with differences between Deceitful War and War in bold:

「ペテン戦争」の内容は次の通りです(「戦争」との違いは太字になっています)
　
1. Each player weighs each of his or her own blocks. **Naomi also weighs Ken's blocks while he isn't looking, so Naomi knows the weights of all blocks** and Ken only knows the weights of his own blocks.
2. They repeat the following process **N** times:
  1. Naomi chooses one of her own blocks, with mass Chosen~Naomi~.
  2. Naomi tells Ken **a number, Told~Naomi~, between 0.0kg and 1.0kg exclusive.** Ken, who thinks they're playing War, thinks the number Naomi just told him is Chosen~Naomi~.
  3. Ken chooses one of his own blocks, with mass Chosen~Ken~.
  4. They each put their block on one side of a [balance scale](https://www.google.com/search?q=balance+scale&tbm=isch), and the person whose block is heavier gets one point.
  5. Both  blocks are destroyed in a fire.
　
1. 各プレイヤーはそれぞれのブロックの重さを量ります。**ナオミはケンが見ていない隙にケンのブロックの重さも量ります。ですので、ナオミはケンのブロックの重さも知っています。** ケンはケンのブロックの重さのみを知っています。
2. 次のことを **N** 回繰り返します。
 1. ナオミは重さが Choosen~Naomi~ のブロックを1つ選びます。
 2. ナオミはケンに、**0.0kgから1.0kg(両端(0.0と1.0)を含まない)の重さ Told~Naomi~ を伝えます。ケンは「戦争」をプレイしていると思い込んでいるので、ナオミが Coosen~Naomi~ の重さを伝えたと思っています。
 3. ケンは重さが Choosen~Ken~ のブロックを1つ選びます。
 4. 選んだブロックを天秤の左右に置きます。そして、重いブロックを選んでいたプレイヤーが1点を得ます。
 5. 選んだブロックを燃やします。

Naomi doesn't want Ken to know that she isn't playing War; so when she is choosing which block to play, and what mass to tell Ken, she must make sure that the balance scale won't reveal that Chosen~Naomi~ ≠ Told~Naomi~. In other words, she must make decisions so that:

ナオミはケンに「ペテン戦争」をプレイしていることを知られたくありません。そこで、ブロックを選んで重さを伝えるときには、Chosen~Naomi~ ≠ Told~Naomi~ であることが天秤によってバレないようにしなければいけません。そのために、以下のようにします。

* Chosen~Naomi~ > Chosen~Ken~ if, and only if, Told~Naomi~ > Chosen~Ken~, and
* Told~Naomi~ is not equal to the mass of any of Ken's blocks, because he knows that isn't possible.

* Told~Naomi~ > Chosen~Ken~ の時だけ、Chosen~Naomi~ > Chosen~Ken~ となるようにします。
* Told~Naomi~ はケンのブロックの重さと同じにならないようにします。

It might seem like Naomi won't win any extra points by being deceitful, because Ken might discover that she wasn't playing War; but Naomi knows Ken thinks both players are playing War, and she knows what he knows, and she knows Ken will always follow his unique optimal strategy for War, so she can always predict what he will play.

ケンが、ナオミが「ペテン戦争」をプレイしている事に気付いてしまわないようにプレイすると、「ペテン戦争」によってナオミが有利になるようには見えません。しかし、ナオミは、ケンはあくまで二人が「戦争」をプレイしていると思っている、つまり「戦争」と同じ戦術を使うことを知っています。よってナオミは常にケンがどのようにプレイするかを予測することができます。

You'll be given the masses of the blocks Naomi and Ken started with. Naomi will play Deceitful War optimally to gain the maximum number of points. Ken will play War optimally to gain the maximum number of points assuming that both players are playing War. What will Naomi's score be? What would it have been if she had played War optimally instead?

あなたには、ゲーム開始時のナオミとケンが持っているそれぞれのブロックの重さが与えられます。ナオミは「ペテン戦争」で最大の得点となるようにプレイします。ケンは二人が「戦争」をプレイしているという前提で最大の得点となるようにプレイします。ナオミの得点は何点になるでしょうか？また、もしナオミが「戦争」をプレイした場合の得点は何点になるでしょうか？

## Examples

If each player has a single block left, where Naomi has 0.5kg and Ken has 0.6kg, then Ken is guaranteed to score the point. Naomi can't say her number is ≥ 0.6kg, or Ken will know she isn't playing War when the balance scale shows his block was heavier.

もし、ナオミが0.5kg、ケンが0.6kgのブロックのみを持っているとすると、ケンは確実に勝ちます。ナオミは0.6kg以上とは宣言できません。なぜなら、そう宣言してしまうと、天秤によってナオミが「戦争」をプレイしていないことがバレてしまいます。

If each player has two blocks left, where Naomi has [0.7kg, 0.2kg] and Ken has [0.8kg, 0.3kg], then Naomi could choose her 0.2kg block, and deceive Ken by telling him that she chose a block that was 0.6kg. Ken assumes Naomi is telling the truth (as in how the War game works) and will play his 0.8kg block to score a point. Ken was just deceived, but he will never realize it because the balance scale shows that his 0.8kg block is, like he expected, heavier than the block Naomi played. Now Naomi can play her 0.7kg block, tell Ken it is 0.7kg, and score a point. If Naomi had played War instead of Deceitful War, then Ken would have scored two points and Naomi would have scored zero.

もし、ナオミが0.7kgと0.2kgのブロック、ケンが0.8kgと0.3kgのブロックを持っているとします。この時、ナオミは0.2kgのブロックを選び、ケンに0.6kgと宣言することができます。ケンはナオミが「戦争」をしていると思っていますから、0.8kgのブロックを選んで得点しようとします。ケンは今まさにダマされましたが、天秤はケンの想定通りになりますので、気付きません。次にナオミは0.7kgのブロックを0.7kgとしてプレイすれば得点でき、1対1になります。しかし、ナオミが「戦争」をプレイしていれば、ケンが2点を獲得してナオミは1点も取れないところです。

## Input

The first line of the input gives the number of test cases, **T**. **T** test cases follow. Each test case starts with a line containing a single integer **N**, the number of blocks each player has. Next follows a line containing **N** space-separated real numbers: the masses of Naomi's blocks, in kg. Finally there will be a line containing **N** space-separated real numbers: the masses of Ken's blocks, in kg.

最初の行は問題の数 **T** が書いてあります。以下 **T** 個の問題が続きます。各問題の1行目には各プレイヤーが持っているブロックの数を表わす1つの整数 **N** が書いてあります。2行目にはナオミのブロックの重さを表す、スペースで区切られた **N** 個の実数(単位はkg)が書いてあります。3行目にはケンのブロックの重さを表す、スペースで区切られた **N** 個の実数(単位はkg)が書いてあります。

Each of the masses given to Ken and Naomi will be represented as a 0, followed by a decimal point, followed by 1-5 digits. Even though all the numbers in the input have 1-5 digits after the decimal point, Ken and Naomi don't know that; so Naomi can still tell Ken that she played a block with mass 0.5000001kg, and Ken has no reason not to believe her.

各ブロックの重さは、整数部が0で、小数部が1～5桁で表現されます。なお、ブロックの重さの小数部は1～5桁ではありますが、ケンとナオミはそのことを知りません。つまり、ナオミは0.5000001kgと宣言することが出来ます。

## Output

For each test case, output one line containing "Case # **x**: **y** **z**", where x is the test case number (starting from 1), y is the number of points Naomi will score if she plays Deceitful War optimally, and **z** is the number of points Naomi will score if she plays War optimally.

各問題について、1行で "Case # **x**: **y** **z**" と出力してください。x は1から始まる問題番号、yはナオミが「ペテン戦争」をプレイした場合の最高のスコア、**z**はナオミが「戦争」をプレイした場合の最高のスコアです。

## Limits

1 ≤ **T** ≤ 50.
All the masses given to Ken and Naomi are distinct, and between 0.0 and 1.0 exclusive.

全てのブロックの重さはユニークで、0.0～1.0(0.0と1.0を含まない)です。

## Small dataset

1 ≤ **N** ≤ 10.

## Large dataset

1 ≤ **N** ≤ 1000.

## Sample

```
Input

4
1
0.5
0.6
2
0.7 0.2
0.8 0.3
3
0.5 0.1 0.9
0.6 0.4 0.3
9
0.186 0.389 0.907 0.832 0.959 0.557 0.300 0.992 0.899
0.916 0.728 0.271 0.520 0.700 0.521 0.215 0.341 0.458

Output

Case #1: 0 0
Case #2: 1 0
Case #3: 2 1
Case #4: 8 4
```
