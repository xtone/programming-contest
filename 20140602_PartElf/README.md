# Part Elf

出題元URL: https://code.google.com/codejam/contest/3004486/dashboard#s=p0

## Problem

Vida says she's part Elf: that at least one of her ancestors was an Elf. But she doesn't know if it was a parent (1 generation ago), a grandparent (2 generations ago), or someone from even more generations ago. Help her out!

ヴィダは自分がエルフの血族だと主張しています。つまり、彼女の祖先のうち少なくとも1人はエルフだということです。しかし、彼女は何世代前の祖先がエルフだったのか知りません。さぁ、彼女の何世代前の祖先がエルフだったのか調べてあげましょう！

Being part Elf works the way you probably expect. People who are Elves, Humans and part-Elves are all created in the same way: two parents get together and have a baby. If one parent is A/B Elf, and the other parent is C/D Elf, then their baby will be (A/B + C/D) / 2 Elf. For example, if someone who is 0/1 Elf and someone who is 1/2 Elf have a baby, that baby will be 1/4 Elf.

エルフの血族であることの条件は、だいたいあなたの想像通りです。エルフ、人間、そしてエルフの血族は全て同じ方法で生まれます。そうです、2人の親から1人の赤ちゃんが生まれるのです。
もし、片方の親がA/Bエルフで、もう片方の親がC/Dエルフだとします。すると赤ちゃんは(A/B + C/D) / 2エルフになります。
例えば、0/1エルフ(=人間)と、1/2エルフから生まれる赤ちゃんは1/4エルフになります。

Vida is certain about one thing: 40 generations ago, she had 2 ^ 40 different ancestors, and each one of them was 1/1 Elf or 0/1 Elf.

ヴィダは、40世代前に2 ^ 40の異なる祖先がいて、それぞれが1/1エルフ(=エルフ)か0/1エルフであったことを知っています。

Vida says she's **P** / **Q** Elf. Tell her what is the minimum number of generations ago that there could have been a 1/1 Elf in her family. If it is not possible for her to be **P** / **Q** Elf, tell her that she must be wrong!

またヴィダは、彼女が **P** / **Q** エルフであると言っています。彼女に、1/1エルフがいた可能性のあるもっとも近い祖先は何世代前か教えてあげて下さい。
もし、彼女が **P** / **Q** エルフである可能性が無いならば、彼女が間違っていることを教えてあげて下さい！

## Input

The first line of the input gives the number of test cases, **T**. **T** lines follow. Each contains a fraction of the form **P** / **Q**, where **P** and **Q** are integers.

最初の行はテストケースの数 **T** が書いてあります。以下 **T** 行が続きます。各行には、スラッシュで区切られた分数の形式で、 **P** / **Q** が与えられます。 **P** 及び **Q** は整数です。

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the minimum number of generations ago a 1/1 Elf in her family could have been if she is **P** / **Q** Elf. If it's impossible that Vida could be **P** / **Q** Elf, y should be the string "impossible" (without the quotes).

各テストケースについて、1行で "Case #x: y" と出力してください。x は1から始まるテストケース番号、yは1/1エルフが居た可能性のある最も近い祖先が何世代前かの値です。もし彼女が **P** / **Q** エルフである可能性が無いならば、impossibleとして下さい。

## Limits

1 ≤ **T** ≤ 100.

## Small dataset

1 ≤ **P** < **Q** ≤ 1000.
**P** and **Q** have no common factors. That means **P** / **Q** is a fraction in lowest terms.

**P** と **Q** の公約数は存在しません。つまり **P** / **Q** は約分されている分数です。

## Large dataset

1 ≤ **P** < **Q** ≤ 10^12 .
**P** and **Q** may have common factors. **P** / **Q** is not guaranteed to be a fraction in lowest terms.

**P** と **Q** は公約数が存在する可能性があります。 **P** / **Q** が約分された分数であることは保証されていません。

## Smaple

```
Input 

5
1/2
3/4
1/4
2/23
123/31488

Output

Case #1: 1
Case #2: 1
Case #3: 2
Case #4: impossible
Case #5: 8
```

Note that the fifth sample case does not meet the limits for the Small input. Even if you don't solve it correctly, you might still have solved the Small input correctly.

注意:5つめのサンプルはSmall inputの制限の範囲を越えています。ですので、5つ目のサンプルが解けなかったとしても、Smallを解けている可能性があります。

## Explanation of sample cases

In the first sample case, Vida could have a 1/1 Elf parent and a 0/1 Elf parent. That means she could have had a 1/1 Elf one generation ago, so the answer is 1.

最初のサンプルでは、ヴィダには1/1エルフと0/1エルフの親がいる可能性があります。ということは、1世代前に1/1エルフが居る可能性がありますので、答えは1になります。

In the second sample case, Vida could have had a 1/1 Elf parent and a 1/2 Elf parent. That means she could have had a 1/1 Elf one generation ago, so the answer is 1.

2つ目のサンプルでは、ヴィダには1/1エルフと1/2エルフの親がいる可能性があります。ということは、1世代前に1/1エルフが居る可能性がありますので、答えは1になります。

In the third sample case, Vida could have had a 0/1 Elf parent and a 1/2 Elf parent. The 1/2 Elf parent could have had a 1/1 Elf parent and a 0/1 Elf parent. That means she could have had a 1/1 Elf two generations ago, so the answer is 2.

3つ目のサンプルでは、ヴィダには0/1エルフと1/2エルフの親がいる可能性があります。そして1/2エルフの方の親は、1/1エルフと0/1エルフの親がいる可能性があります。ということは、2世代前に1/1エルフが居る可能性がありますので、答えは2になります。

In the fourth sample case, it's impossible to be exactly 2/23 Elf if your ancestors 40 generations ago were all 0/1 Elf or 1/1 Elf.

4つ目のサンプルでは、40世代前の祖先に0/1エルフまたは1/1エルフしか居ない場合、ヴィダが2/23エルフである可能性はありません。

## Note

Yes, Vida has a lot of ancestors. If that is the part of the problem that seems the most unrealistic to you, please re-read the part about Elves.

ご想像の通り、ヴィダには沢山の祖先がいます。もし、非現実的であることが気になっているのであれば、エルフについての部分をもう一度読んで下さい。
