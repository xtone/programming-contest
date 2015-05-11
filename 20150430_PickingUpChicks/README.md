# Picking Up Chicks

出題元URL：https://code.google.com/codejam/contest/635101/dashboard#s=p1

## Problem

A flock of chickens are running east along a straight, narrow road. Each one is running with its own constant speed. Whenever a chick catches up to the one in front of it, it has to slow down and follow at the speed of the other chick. You are in a mobile crane behind the flock, chasing the chicks towards the barn at the end of the road. The arm of the crane allows you to pick up any chick momentarily, let the chick behind it pass underneath and place the picked up chick back down. This operation takes no time and can only be performed on a pair of chicks that are immediately next to each other, even if 3 or more chicks are in a row, one after the other.

鶏の群れが東に向かって狭い道を走っています。それぞれの鶏は一定のスピードで走っています。他の鶏に追い付いた鶏は、前の鶏と同じ速度で、その直後を走ります。あなたは、群の後ろにいるクレーン車の中にいて、道の終わりにある鶏小屋に向かって鶏を追い掛けています。あなたは、クレーンを使って鶏を少しの間だけ持ち上げ、後ろにいる鶏を先に行かせることができます。この行動に時間はかかりませんが、たとえ3羽が連なって走っていたとしても直後にいる鶏1羽しか先に行かせることはできません。

Given the initial locations (Xi) at time 0 and natural speeds (Vi) of the chicks, as well as the location of the barn (B), what is the minimum number of swaps you need to perform with your crane in order to have at least K of the N chicks arrive at the barn no later than time T?

開始時の各鶏の位置(Xi)と速度(Vi)及び、鶏小屋の位置(B)が与えられます。全部でN羽いる鶏のうち少なくともK羽を時刻Tまでに鶏小屋に追い込むためには、最小何回のクレーン車による鶏の位置交換を行わなければいけないでしょうか?

You may think of the chicks as points moving along a line. Even if 3 or more chicks are at the same location, next to each other, picking up one of them will only let one of the other two pass through. Any swap is instantaneous, which means that you may perform multiple swaps at the same time, but each one will count as a separate swap.

鶏は線上を移動する点と考えて構いません。繰り返しになりますが、例え3羽が同じ位置(つまり連続して並んでいる状態)になっていたとしても、最初の1羽を持ち上げることで先に行かせることが出来るのは、残りの2羽のうち1羽のみです。これらの位置交換は直ちに行なわれるので、ある瞬間に好きなだけ位置交換を行なうことができますが、位置交換の回数はカウントされます。

## Input

The first line of the input gives the number of test cases, C. C test cases follow. Each test case starts with 4 integers on a line -- N, K, B and T. The next line contains the N different integers Xi, in increasing order. The line after that contains the N integers Vi. All distances are in meters; all speeds are in meters per second; all times are in seconds.

最初の行は問題の数Cが書いてあります。以下C個の問題が続きます。各問題は4つの整数が書いてある行で始まります。この4つの整数は順番にN、K、BそしてTです。次の行にはN個の異なる整数Xiが昇順で書いてあります。その次の行にはN個のViが書いてあります。全ての距離の単位はメートルで、速度の単位はメートル/秒、時間の単位は秒です。


## Output

For each test case, output one line containing "Case #x: S", where x is the case number (starting from 1) and S is the smallest number of required swaps, or the word "IMPOSSIBLE".
各問題について、1行で "Case #x: S" と出力してください。 xは1から始まる問題番号、 Sは最小の位置交換の回数、または"IMPOSSIBLE"です。

## Limits

1 ≤ C ≤ 100;
1 ≤ B ≤ 1,000,000,000;
1 ≤ T ≤ 1,000;
0 ≤ Xi < B;
1 ≤ Vi ≤ 100;
All the Xi's will be distinct and in increasing order.
全てのXiはユニークで昇順に並んでいます。

## Small dataset

1 ≤ N ≤ 10;
0 ≤ K ≤ min(3, N);

## Large dataset

1 ≤ N ≤ 50;
0 ≤ K ≤ N;

## Sample

```
Input 
 	
3
5 3 10 5
0 2 5 6 7
1 1 1 1 4
5 3 10 5
0 2 3 5 7
2 1 1 1 4
5 3 10 5
0 2 3 4 7
2 1 1 1 4

Output 

Case #1: 0
Case #2: 2
Case #3: IMPOSSIBLE
```
