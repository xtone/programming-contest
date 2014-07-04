# The Bored Traveling Salesman

出題元URL: https://code.google.com/codejam/contest/2994486/dashboard#s=p2

## Problem

Your boss is sending you out on an international sales trip. What joy!

K社長が急に海外出張して商品を売りまくって来いと言いました。なんということでしょう！

You have **N** cities (numbered from 1 to **N**) to visit and can get to them using a set of bidirectional flights that go between the cities.

あなたは **N** 個の都市 (1～Nの番号がついています) に行く必要があります。そのために、各都市の間で使える往復の航空券を使うことになります。

All of the cities must be visited at least once. To do this you can book any number of tickets, subject to the following conditions:

全ての都市を1度は訪ずれる必要があります。このために、次に示す条件に従っている限り、好きな数の航空券を予約することができます。

* Each ticket consists of 2 flights, one from a specific city **X** to another specific city **Y** (this is called the **outbound** flight), and the other one from city **Y** to city **X** (this is called the **return** flight).
* You must use the outbound flight before the corresponding return flight (you can use other flights in between).
* At most 1 outbound flight going to each city, although there is no limit on the return flights (multiple return flights can go to the same city).
* You must use all flights which belong to the tickets you booked.
* You can otherwise visit the cities in any order you like.
* You can start your trip from any city you choose. You may not take an outbound flight to your starting city.

* 各航空券は2つのフライトを含みます。1つはある都市 **X** から別の都市 **Y** へのフライトです(これは **往路** フライトと呼びます)。もう1つは都市 **Y** から都市 **X** へのフライトです(これは **復路** フライトと呼びます)。
* 復路フライトを使う前に、往路フライトを使わなければいけません。(往路フライトと復路フライトの間に他のフライトを使うことは可能です)
* 各都市には1つの往路フライトで行くことができます。復路フライトにこの制限はありません(複数の復路フライトの目的地が同じ都市になることがあります)。
* 予約した航空券は全て使わなければいけません。
* 都市はどのような順番でまわっても構いません。
* どの都市から出張を始めても構いません。(始めた都市への往路フライトは使えないでしょう)

Now you could try to minimize the total distance travelled, but you did that last time, so that would be boring. Instead you noticed that each city has a distinct 5 digit ZIP (postal) code. When you visit a city for the first time (this includes the city which you start from) you write down the zip code and concatenate these into one large number (concatenate them in the order which you visited each city for the first time). What is the smallest number you can achieve?

さて、最短経路で出張する方法を考えることもできるのですが、それは前回の出張の時にやってしまったので、おもしろくありません。
ここであなた、各都市にはユニークな5桁の郵便番号(ZIPコード)があることに気付きました。
ある都市に初めて到着したとき(出張を始める都市を含みます)に、郵便番号を書き留め、それらを繋げて1つの大きな数字することにしました(繋ぐ順序は到着した順になります)。さて、もっとも小さい数字を作るにはどうしたらよいでしょうか？

## Input

The first line of the input gives the number of test cases, **T**. **T** test cases follow.
最初の行は問題の数 **T** が書いてあります。以下 **T** 個の問題が続きます。

Each test case starts with a single line containing two integers: the number of cities **N** and the number of possible bidirectional flights **M**.

各問題の1行目には2つの整数が書いてあります。都市の数を表わす **N** と 存在するフライトの種類 **M** です。

**N** lines then follow, with the i-th line containing the 5-digit zip code of the i-th city. No ZIP code will have leading zeros and all ZIP codes in each test case will be distinct.

さらに、 **N** 行が続きます。この **N** 行のi番目はi番目の都市の郵便番号です。郵便番号は0から始まることはなく、各問題内でユニークです。

**M** lines then follow, each containing two integers i and j (1 ≤ **i** < **j** ≤ **N**) indicating that a bidirectional flight exists between the **i**-th city and the **j**-th city. All flights will be distinct within each test case.

さらに、 **M** 行が続きます。この **M** 行は2つの整数、iとj (1 ≤ **i** < **j** ≤ **N**) が書かれていて、これは **i** 番目の都市と **j** 番目の都市を結ぶフライトがあるということです。全てのフライトは各問題内でユニークです。

It is guaranteed that you can visit every city following the rules above.

また、全ての都市にルールに従って到着できることは保証されています。

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the smallest number you can achieve by concatenating the ZIP codes along your trip.

各問題について、1行で "Case #x: y" と出力してください。x は1から始まる問題番号、y は出張で回った都市の郵便番号を繋げてもっとも小さくなる数値です。

## Limits

1 ≤ **T** ≤ 100.
0 ≤ **M** ≤ **N** * ( **N** - 1 ) / 2.

### Small dataset

1 ≤ **N** ≤ 8.

### Large dataset

1 ≤ **N** ≤ 50.

## Sample

```
Input

4
3 2
10001
20000
10000
1 2
2 3
5 4
36642
28444
50012
29651
10953
1 4
2 3
2 5
4 5
5 5
36642
28444
50012
29651
10953
1 2
1 4
2 3
2 5
4 5
6 6
10001
10002
10003
10004
10005
10006
1 2
1 6
2 3
2 4
3 5
4 5

Output

Case #1: 100002000010001
Case #2: 1095328444500122965136642
Case #3: 1095328444366422965150012
Case #4: 100011000210003100041000510006
```

## Explanation
   
In the last sample test case, the following is the sequence of what you should do to achieve the smallest number:

最後の問題では、次の順番で都市を回ることで、最小の値を得られます。

1. Start from city 1, write 10001.
2. Outbound flight from 1 to 2, write 10002.
3. Outbound flight from 2 to 3, write 10003.
4. Return flight from 3 to 2.
5. Outbound flight from 2 to 4, write 10004.
6. Outbound flight from 4 to 5, write 10005.
7. Return flight from 5 to 4.
8. Return flight from 4 to 2.
9. Return flight from 2 to 1.
10. Outbound flight from 1 to 6, write 10006.
11. Return flight from 6 to 1.

　

1. 都市1からスタートします。10001が記録されます。
2. 往路フライトで都市1から都市2に飛びます。10002が記録されます。
3. 往路フライトで都市2から都市3に飛びます。10003が記録されます。
4. 復路フライトで都市3から都市2に飛びます。
5. 往路フライトで都市2から都市4に飛びます。10004が記録されます。
6. 往路フライトで都市4から都市5に飛びます。10005が記録されます。
7. 復路フライトで都市5から都市4に飛びます。
8. 復路フライトで都市4から都市2に飛びます。
9. 復路フライトで都市2から都市1に飛びます。
10. 往路フライトで都市1から都市6に飛びます。10006が記録されます。
11. 復路フライトで都市6から都市1に飛びます。
