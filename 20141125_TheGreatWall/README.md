# The Great Wall

出題元URL：https://code.google.com/codejam/contest/2437488/dashboard#s=p2

## Problem

You are studying the history of the Great Wall of China, which was built by the Chinese to protect against military incursions from the North. For the purposes of this problem, the Great Wall stretches from infinity in the East to minus infinity in the West. As this is a lot of distance to cover, the Great Wall was not built at once. Instead, for this problem we assume that the builder used a reactive strategy: whenever a part of the border was attacked successfully, the 
Wall on this part of the border would be raised to the height sufficient to stop an identical attack in the future.

あなたは万里の長城の歴史について調査しています。万里の長城は、北方からの侵攻に対抗するために、中国人が建てたものです。
さて、この問題の中では、万里の長城は東西には無限に存在するものとします。無限の長さの長城を作るのは超大変で、長城は一夜にしては建ちません。
長城を建てる人達は反応戦略を使います。反応戦略とは、もし侵攻が成功してしまったら、その侵攻された部分の高さだけを、侵攻されない高さにまで築城し、未来の侵攻を防ぐ、という戦略です。

The north border of China was frequently attacked by nomadic tribes. For the purposes of this problem, we assume that each tribe attacks the border on some interval with some strength S. In order to repel the attack, the Wall must have height S all along the defended interval. If even a short stretch of the Wall is lower than needed, the attack will breach the Wall at this point and succeed. Note that even a successful attack does not damage the Wall. After the attack, every attacked fragment of the Wall that was lower than S is raised to height S — in other words, the Wall is increased in the minimal way that would have stopped the attack. Note that if two or more attacks happened on the exact same day, the Wall was raised only after they all resolved, and is raised in the minimum way that would stop all of them.

中国の北の国境は、遊牧民の部族によって何度も襲撃されています。この問題の中では、各部族の国境への襲撃はある間隔で強さSで行なわれるものとします。襲撃を防ぐためには、襲撃された部分の壁の高さがS以上でなければいけません。例え、襲撃されたうちの一部分でも壁の高さがS未満であれば、襲撃は成功します。なお、襲撃が成功しても、壁そのものはダメージを受けないものとします。襲撃が終了すると、全ての襲撃を受けた壁について、壁の高さがS未満の部分があればSにまで引き上げられます。言い換えると、同じ襲撃を受けた場合に、襲撃を防げる最小限の高さまで壁の高さが引き上げられるということです。なお、もし同じ日に2回以上の襲撃があった場合、全ての襲撃が終わった後に壁の高さが引き上げられます。この場合、その日に受けた全ての襲撃を防げる最小限の高さまで壁の高さが引き上げられます。

Since nomadic tribes are nomadic, they did not necessarily restrict themselves to a single attack. Instead, they tended to move (either to the East or to the West), and periodically attack the Wall. To simplify the problem, we assume they moved with constant speed and attacked the Wall at constant intervals; moreover we assume that the strength with which a given tribe attacked the Wall changed by a constant amount after each attack (either decreased from attrition, or grew from experience).
遊牧民の部族は遊牧民であるので、1回しか襲撃しないとは限りません。彼らは西または東に移動しながら、定期的に襲撃してきます。問題を簡単にするために、彼らの移動速度と襲撃の間隔は一定であるものとします。また、彼らの襲撃の強さは襲撃毎に一定量ずつ変化するものとします(戦闘の消耗によって下がっていく、または戦闘の経験を得て上がっていくということです)。

Assuming that initially (in 250 BC) the Wall was nonexistent (i.e., of height zero everywhere), and given the full description of all the nomadic tribes that attacked the Wall, determine how many of the attacks were successful.
まず、初期時点(紀元前250年)には壁は無いものとします(つまり全ての壁の高さが0であるとも言えます)。そして、全ての遊牧民の部族の襲撃の詳細が与えられます。何回の襲撃が成功するか算出して下さい。

## Input

The first line of the input gives the number of test cases, T. T test cases follow. Each test case begins with a line containing a single integer N: the number of the tribes attacking the Wall. N lines follow, each describing one tribe. The ith line contains eight integers di, ni, wi, ei, si, delta_di, delta_pi and delta_si separated by spaces, describing a single nomadic tribe:
最初の行は問題の数Tが書いてあります。以下T個の問題が続きます。各問題は1つの整数Nが書いてある行で始まります。Nは襲撃してくる部族の数です。各部族を表わすN行が続きます。i番目の行には1つの遊牧民の部族を表わす8つの整数、di、ni、wi、ei、si、delta_di、delta_pi、delta_siがスペース区切りで書いてあります。

di – the day of the tribe's first attack (where 1st January, 250BC, is considered day 0)
ni – the number of attacks from this tribe
wi, ei – the westmost and eastmost points respectively of the Wall attacked on the first attack
si – the strength of the first attack
delta_di – the number of days between subsequent attacks by this tribe
delta_pi – the distance this tribe travels to the east between subsequent attacks (if this is negative, the tribe travels to the west)
delta_si – the change in strength between subsequent attacks

di - 部族が襲撃してくる最初の日(紀元前250年1月1日が0)
ni - 部族が襲撃してくる回数
wi, ei - 最初の襲撃で襲撃する壁の西端と東端
si - 最初の襲撃の強さ
delta_di - 襲撃してくる間隔(日)
delta_pi - 襲撃毎に東に移動する距離(マイナスの場合は西に移動します)
delta_si - 襲撃毎に変化する強さの量

## Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1) and y is the number of attacks that succeed.
各問題について、1行で "Case #x: y" と出力してください。 xは1から始まる問題番号、 yは襲撃が成功する回数です。

## Limits

1 ≤ T ≤ 20.
0 ≤ di.
1 ≤ delta_di ≤ 676060.
di + (ni - 1) * delta_di ≤ 676060.
1 ≤ si ≤ 106.
-105 ≤ delta_si ≤ 105.
si + (ni - 1) * delta_si ≥ 1.

## Small dataset

1 ≤ N ≤ 10.
1 ≤ ni ≤ 10.
-100 ≤ wi < ei ≤ 100.
-10 ≤ delta_pi ≤ 10.

## Large dataset

1 ≤ N ≤ 1000.
1 ≤ ni ≤ 1000.
-106 ≤ wi < ei ≤ 106.
-105 ≤ delta_pi ≤ 105.

## Sample

```
Input 

2
2
0 3 0 2 10 2 3 -2
10 3 2 3 8 7 2 0
3
1 2 0 5 10 2 8 0
0 3 0 1 7 1 2 2
3 3 0 5 1 1 4 0

Output

Case #1: 5
Case #2: 6
```

In the first case, the first tribe attacks three times: on day 0 it hits the interval [0,2] at height 10, on day 2 it hits [3,5] at height 8 and on day 4 it hits [6,8] at height 6; all three attacks succeed. Then the second tribe attacks three times, each time at height 8 - on day 10 it hits [2,3] (this succeeds, for example at position 2.5, where the Wall has still height 0), on day 17 it hits [4,5] (this fails, the Wall is already of height 8 in the interval [3, 5], which covers [4, 5]), and on day 24 it hits [6,7] (this succeeds, as the Wall there was of height 6).
最初の問題では、最初の部族は3回襲撃してきます。0日目に[0,2]の壁を高さ(強さ)10で、2日目に[3,5]の壁を高さ8で、そして4日目に[6,8]の壁を高さ6で襲撃し、全ての襲撃が成功します。次に2番目の部族が3回襲撃してきます。この部族は毎回高さ8で襲撃してきます。10日目に[2,3]の壁を襲撃します(この襲撃は成功します。なぜなら少なくとも壁の2.5の部分は高さが0だからです)。17日目に[4,5]の壁を襲撃します(この襲撃は失敗します。壁の[3,5]は既に高さ8になっていて、これは[4,5]を含むからです)。そして24日目に[6,7]の壁を襲撃します(この襲撃は成功します。[6,7]には高さ6の壁しかありません)。

In the second case there are three tribes, and their attacks intermingle. The sequence is as follows:
2つ目の問題では3つの部族が出てきます。今回は各部族の襲撃が次々に起こります。流れは以下のようになります。

On day 0, Tribe 2 attacks [0,1] at height 7 and succeeds.
On day 1, Tribe 1 attacks [0,5] at height 10, and Tribe 2 attacks [2,3] at height 9. Both attacks succeed (as they were simultaneous, the Wall built after the attack of the first tribe isn't there in time to stop the second tribe).
On day 2, Tribe 2 attacks [4,5] at height 11 and succeeds (the Wall there was at height 10).
On day 3, Tribe 1 attacks [8,13] at height 10 and succeeds. Simultaneously, Tribe 3 attacks [0,5] at height 1 and fails (there's a Wall of heights 10 and 11 there).
On day 4 Tribe 3 attacks [4,9] at height 1 and succeeds (there was no Wall between 5 and 8).
Finally, on day 5 Tribe 3 attacks [8,13] at height 1 and fails (since a Wall of height 10 is there).

0日目、部族2が壁[0,1]を高さ7で襲撃し、成功します。
1日目、部族1が壁[0,5]を高さ10で襲撃し、部族2が壁[2,3]を高さ9で襲撃します。両方の襲撃は成功します。(2部族の襲撃は同時に起きるため、部族1の襲撃によって出来る壁は部族2の襲撃を止めることはできません)
2日目、部族2が壁[4,5]を高さ11で襲撃し、成功します(壁の高さは10しかありません)。
3日目、部族1が壁[8,13]を高さ10で襲撃し、成功します。同時に部族3が壁[0,5]を高さ1で襲撃し、失敗します([0,5]の壁の高さは10か11になっています)。
4日目、部族3が壁[4,9]を高さ1で襲撃し、成功します(5から8の間は壁がありません)
最終日である5日目、部族3が壁[8,13]を高さ1で襲撃し、失敗します(該当する箇所の壁の高さは10あります)。
