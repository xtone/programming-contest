# Enclosure

出題元URL: https://code.google.com/codejam/contest/3004486/dashboard#s=p2

## Problem

Your task in this problem is to find out the minimum number of stones needed to place on an N-by-M rectangular grid (N horizontal line segments and M vertical line segments) to enclose at least K intersection points. An intersection point is enclosed if either of the following conditions is true:

1. A stone is placed at the point.
2. Starting from the point, we cannot trace a path along grid lines to reach an empty point on the grid border through empty intersection points only.

For example, to enclose 8 points on a 4x5 grid, we need at least 6 stones. One of many valid stone layouts is shown below. Enclosed points are marked with an "x".

この問題では、N x M の長方形(Nは水平方向、Mは垂直方向)のグリッド上で、K個の交点を囲うように石を配置する最小の個数を求めてください。
交点は以下の条件のどちらかを満たしたとき、囲われている状態とします。

1. 石がその点の上にある。
2. その点からグリッドに沿って、石が置いてない点のみを通ってグリッドの端まで辿り着く方法がない。

例えば、4x5のグリッド上で8つの点を囲うには、少なくとも6個の石が必要です。多くの正しい石配置のうちのひとつを示します。
囲われた点は x で表されています。

![image](/xtone/programmingcontest/raw/master/20140520_Enclosure/enclosure.png)

## Input

The first line of the input gives the number of test cases, **T**. **T** lines follow. Each test case is a line of three integers: **N** **M** **K**.

最初の行はテストケースの数 **T** が書いてあります。
以下 **T** 行には、3つの数字が書いてあります。順に、 **N M K** です。

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the minimum number of stones needed.

各テストケースについて、1行で "Case #x: y" と出力してください。
x は1から始まるテストケース番号、y はそのケースで必要な最小の石の個数を表します。

## Limits

1 ≤ **T** ≤ 100.
1 ≤ **N**.
1 ≤ **M**.
1 ≤ **K** ≤ **N** × **M**.

## Small dataset

**N** × **M** ≤ 20.

## Large dataset

**N** × **M** ≤ 1000.

## Sample

```
Input 

2
4 5 8
3 5 11
      
Output 
 

Case #1: 6
Case #2: 8
```
