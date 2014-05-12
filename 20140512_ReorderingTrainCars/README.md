# Reordering Train Cars

出題元URL https://code.google.com/codejam/contest/3004486/dashboard#s=p1

## Problem

Yahya is a brilliant kid, so his mind raises a lot of interesting questions when he plays with his toys. Today's problem came about when his father brought him a set of train cars, where each car has a lowercase letter written on one side of the car.

When he first saw the gift, he was happy and started playing with them, connecting cars together without any particular goal. But after a while he got bored (as usual) from playing without having any goal. So, he decided to define a new interesting problem.

The problem is that he currently has **N** sets of connected cars. He can represent each set of connected cars as a string of lowercase letters. He wants to count the number of ways he can connect all **N** sets of cars to form one valid train. A train is valid if all occurrences of the same character are adjacent to each other.

ヤヒャは賢い子供で、玩具で遊ぶときはいつも何か面白いことができないか考えています。
今日は、父親が片面にアルファベットが書かれた列車のセットをくれたので、それで遊ぼうと思っています。
初めは、列車をただ繋ぐだけで面白かったのですが、すぐに飽きてしまいました。
そこでN個の列車を繋ぐルールを決めて、何パターンの繋ぐパターンがあるか考える遊びをすることにしました。
ルールは、書かれたアルファベットを繋げた時に、同じ文字は必ず繋がっている、というものです。

![image](/xtone/programmingcontest/raw/master/20140512_ReorderingTrainCars/reordering_train_carts.png)

The previous figure is one way Yahya could connect the cars "ab", "bc" and "cd" to make a valid train: "ab bc cd". If he had connected them in the order "cd ab bc", that would have been invalid: the "c" characters would not have been adjacent to each other.

You've surely noticed that this is not an easy problem for Yahya to solve, so he needs your help (and he is sure that you will give it!). That's it; go and help Yahya!

**Note:** letters are written only on one side of the cars, so you can not reverse them. For example, if a car has "ab" written on it, it could not be changed to read "ba".

例えば、"ab"、"bc"、"cd"と書かれた列車があるとすると、"ab bc cd"はルール通りの繋ぎ方になります。
もし、"cd ab bc"と繋ぐと、cが繋がっていないので、ルールに反した繋ぎ方になります。
お気付きの通り、これはヤヒャにとって簡単な問題ではありません。
ヤヒャにはあなたの助けが必要です。そしてヤヒャは貴方が助けてくれると信じています！
さぁ、ヤヒャを助けてあげて下さい！

**注:** アルファベットは列車の片側にのみ書かれています。ですので、列車のアルファベットを反転することはできません。
例えば、列車に"ab"と書かれていればそれは"ab"であり、"ba"にはなりません。

## Input

The first line of the input gives the number of test cases, **T**. **T** test cases follow. The first line of each test case contains a single integer **N**, the number of sets of connected cars. The following line contains **N** strings separated by a single space. Every given string represents a set of connected cars and is composed of lowercase English letters only.

最初の1行は問題の数 **T** を表わします。次に **T** 個の問題が続きます。
各問題の1行目は1つの数値 **N** があり、これは列車の数を表わします。
各問題の2行目は1つのスペースで区切られた文字列になります。
これは、各列車のアルファベットを表わします。
※アルファベットは小文字の英字です

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the number of different ways of obtaining a valid train. As this number may be very big, output the number of ways *modulo 1,000,000,007*.

各問題の回答出力は1行で、"Case #x: y"として下さい。xは問題番号(1から始まります)で、yは繋ぎ方のパターン数です。ただしyは非常に大きくなる可能性があるので、実際にはパターン数を1,000,000,007で割った余りとして下さい。

## Limits

1 ≤ **T** ≤ 100.
1 ≤ Set of connected **Cars'** lengths ≤ 100.

1 <= **T** <= 100.
1 <= 1つの列車のアルファベットの長さ <= 100.

## Small dataset

1 ≤ **N** ≤ 10.

## Large dataset

1 ≤ **N** ≤ 100.

## Sample

```
Input 

3
3
ab bbbc cd
4
aa aa bc c
2
abc bcd

Output

Case #1: 1
Case #2: 4
Case #3: 0
```

## Sample Explanation

In the first case, there is only one way to form a valid train by joining string " *ab* " to " *bbbc* " to " *cd* " in this order.

While in the second case, there are 4 possible ways to form a valid train. Notice that there are two different sets of connected cars represented by the string " *aa* ", so there are two different ways to order these two strings and to group them to be one set of connected cars " *aaaa* ". Also there is only one way to order set of cars " *bc* " with " *c* " in only one way to be " *bcc* ". After that you can order " *aaaa* " and " *bcc* " in two different ways. So totally there are 2\*2 = 4 ways to form a valid train.

In the third sample case, there is no possible way to form a valid train, as if joined in any of the two ways " *abc* "+" *bcd* " or " *bcd* "+" *abc* ", there will be two letters of " *b* " and " *c* " not consecutive.

最初の問題では、"ab bbbc cd"という繋ぎ方しかルール通りになりません。
2番目の問題では4通りのルール通りの繋ぎ方があります。まず、"aa aa"の繋ぎ方が2通りあります点に注意して下さい(同じ文字列ですが、違う列車です)。そして"bc c"の繋ぎ方は1通りです。"aaaa"と"bcc"の繋ぎ方が2通りあるので、2\*2=4通りとなります。
3番目の問題では、ルール通りに繋ぐ方法はありません。"abc bcd"も"bcd abc"もbとcが全て繋がった状態になりません。
