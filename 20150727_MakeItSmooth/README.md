## Make it Smooth

出題元URL：https://code.google.com/codejam/contest/544101/dashboard#s=p1

## Problem

You have a one-dimensional array of N pixels. Each pixel has a value, represented by a number between 0 and 255, inclusive. The distance between two pixels is the absolute difference of their numbers.

あなたは1次元でNピクセルの配列を持っています。各ピクセルは0から255(0と255を含む)の数値で表わされる値を持っています。
2つのピクセルの距離とは、値の差の絶対値を意味します。

You can perform each of the following operations zero or more times:

あなたは以下に挙げる操作を0回以上、好きなだけ行なうことができます。

1. With cost D, delete any pixel, so its original neighbors become neighboring pixels.
2. With cost I, insert one pixel of any value into any position -- either between two existing pixels, or before the first pixel, or after the last pixel.
3. You can change the value of any pixel. The cost is the absolute difference of the old value of the pixel and the new value of the pixel.

1. コストDで、好きな1つのピクセルを削除できます。つまり、そのピクセルの隣にあったピクセル2つが、直接の隣り同士になるということです。
2. コストIで、好きな値のピクセルを1つ好きな場所に挿入できます。挿入箇所は、既に存在するピクセルの間でも、最初のピクセルの前でも、最後のピクセルの後でも構いません。
3. 好きなピクセル1つの値を変更することができます。コストは変更前後の値の差の値です。

The array is smooth if any neighboring pixels have distance at most M. Find the minimum possible cost of a sequence of operations that makes the array smooth.

もし、どの隣り合うピクセルの差を取ってもM以下であれば、配列はスムースとなります。もっとも少ないコストで与えられた配列をスムースにする方法を見付けて下さい。

## Note

The empty array -- the array containing no pixels -- is considered to be smooth.

空配列 -- 1つもピクセルがない配列 -- はスムースであると見做します。

## Input

The first line of the input gives the number of test cases, T. T test cases follow, each with two lines. The first line is in the form "D I M N", the next line contains N numbers ai: the values of the pixels from left to the right.

最初の行は問題の数Tが書いてあります。以下T個の問題が続きます。各問題は2行あり、最初の行には"D I M N"が書いてあります。
次の行はN個の数字が書いてあり、これはピクセルの初期値です。

## Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1), and y is the minimum cost to make the input array smooth.

各問題について、1行で "Case #x: y" と出力してください。 xは1から始まる問題番号、 yは配列をスムースにするために必要なもっとも少ないコストです。

## Limits

All the numbers in the input are integers.

全ての数値は整数です。

1 ≤ T ≤ 100
0 ≤ D, I, M, ai ≤ 255

## Small dataset

1 ≤ N ≤ 3.

## Large dataset

1 ≤ N ≤ 100.

## Sample

```
Input 

2
6 6 2 3
1 7 5
100 1 5 3
1 50 7

Output

Case #1: 4
Case #2: 17
```