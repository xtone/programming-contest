出題元URL：https://code.google.com/codejam/contest/2984486/dashboard#s=p2

Problem

A permutation of size N is a sequence of N numbers, each between 0 and N-1, where each number appears exactly once. They may appear in any order.
0からN-1までの数値を含む、サイズNの数列があります。各数値は1度づつ、任意の順番で出現します。

There are many (N factorial, to be precise, but it doesn't matter in this problem) permutations of size N. Sometimes we just want to pick one at random, and of course we want to pick one at random uniformly: each permutation of size N should have the same probability of being chosen.
たくさんの数列のパターン(正確にはNの階乗個ですが、この問題には関係ありません)があります。ときに、ランダムな数列が欲しいことがあります。その場合、一様(各数列のパターンが同じ確からしさで表われる)にランダムであることが望ましいですね。

Here's the pseudocode for one of the possible algorithms to achieve that goal (we'll call it the good algorithm below):
さてここに、ランダムな数列を作り出す擬似コードがあります(以降、良いアルゴリズムと呼びます)。

 for k in 0 .. N-1:
  a[k] = k
for k in 0 .. N-1:
  p = randint(k .. N-1)
  swap(a[k], a[p])
In the above code, randint(a .. b) returns a uniform random integer between a and b, inclusive.
上記コードにおいて、randint(a .. b)は一様なaからbまで(aとbを含む)の整数の乱数を1つ返します。

Here's the same algorithm in words. We start with the identity permutation: all numbers from 0 to N-1 written in increasing order. Then, for each k between 0 and N-1, inclusive, we pick an independent uniform random integer pk between k and N-1, inclusive, and swap the element at position k (0-based) in our permutation with the element at position pk.
上記コードを言葉で表してみます。まず、最初に数列は0からN-1まで順番に並んでいます。そして、0からN-1までの各kについて、一様な乱数によりkからN-1まで(kとN-1を含む)の1つ値pkを取得し、kとpk(0起点)の要素を入れ替えます。

Here's an example for N=4. We start with the identity permutation:
N=4の場合のサンプルです。まず、順番になっている数列からスタートします。

0 1 2 3

Now k=0, and we pick a random p0 between 0 and 3, inclusive. Let's say we picked 2. We swap the 0th and 2nd elements, and our permutation becomes:
k=0のとき、乱数p0を0から3(0と3を含む)の間で取得します。2だったとしましょう。すると0番目と2番目の要素を入れ替えることになり、以下の数列を得ます。

2 1 0 3

Now k=1, and we pick a random p1 between 1 and 3, inclusive. Let's say we picked 2 again. We swap the 1st and 2nd elements, and our permutation becomes:
k=1のとき、乱数p1を1から3(1と3を含む)の間で取得します。また2だったとしましょう。すると1番目と2番目の要素を入れ替えることになり、以下の数列を得ます。

2 0 1 3

Now k=2, and we pick a random p2 between 2 and 3, inclusive. Let's say we picked 3. We swap the 2nd and 3rd elements, and our permutation becomes:
k=2のとき、乱数p2を2から3(2と3を含む)の間で取得します。今度は3だったとしましょう。すると2番目と3番目の要素を入れ替えることになり、以下の数列を得ます。

2 0 3 1

Now k=3, and we pick a random p3 between 3 and 3, inclusive. The only choice is 3. We swap the 3rd and 3rd elements, which means that the permutation doesn't change:
最後にk=3のとき、乱数p3を3から3(3を含む)の間取得します。乱数p3は必ず3になります。すると3番目と3番目を入れ替える、つまり何もしないことになり、以下の数列を得ます。

2 0 3 1

The process ends now, and this is our random permutation.
これで手順は終了し、ランダムな数列を得ることができました。


There are many other algorithms that produce a random permutation uniformly. However, there are also many algorithms to generate a random permutation that look very similar to this algorithm, but are not uniform — some permutations are more likely to be produced by those algorithms than others.
この他にもランダムな数列を取得するには色々な方法があります。しかし、ランダムではあるものの、一様ではない数列を作りだすアルゴリズムもたくさん存在します。つまり、特定の数列が他の数列よりもたくさん作りだされるアルゴリズムです。


Here's one bad algorithm of this type. Take the good algorithm above, but at each step, instead of picking pk randomly between k and N-1, inclusive, let's pick it randomly between 0 and N-1, inclusive. This is such a small change, but now some permutations are more likely to appear than others!
ここに、そのような一様でない数列を作りだす悪いアルゴリズムがあります。そのアルゴリズムは、上記の良いアルゴリズムとほとんど同じですが、pkをkからN-1(kとN-1を含む)から取得する代わりに、0からN-1(0とN-1を含む)から取得します。非常に小さな変更ですが、こうすることで特定の数列が他の数列よりできやすくなります！

Here's the pseudocode for this algorithm (we'll call it the bad algorithm below):
さてここに、上記のアルゴリズムの擬似コードがあります(以降、悪いアルゴリズムと呼びます)。

 for k in 0 .. N-1:
  a[k] = k
for k in 0 .. N-1:
  p = randint(0 .. N-1)
  swap(a[k], a[p])
In each test case, you will be given a permutation that was generated in the following way: first, we choose either the good or the bad algorithm described above, each with probability 50%. Then, we generate a permutation using the chosen algorithm. Can you guess which algorithm was chosen just by looking at the permutation?
各問題で、以下の条件を満たす数列を与えられます。まず、前述の良いアルゴリズムか悪いアルゴリズムのどちらかが等確率(50%)で選ばれます。そして選ばれたアルゴリズムで数列が作り出されます。どちらのアルゴリズムが使われたか、推測することができますか？

Solving this problem
問題を解くにあたって

This problem is a bit unusual for Code Jam. You will be given T = 120 permutations of N = 1000 numbers each, and should print an answer for each permutation – this part is as usual. However, you don't need to get all of the answers correct! Your solution will be considered correct if your answers for at least G = 109 cases are correct. However, you must follow the output format, even for cases in which your answer doesn't turn out to be correct. The only thing that can be wrong on any case, yet still allow you to be judged correct, is swapping GOOD for BAD or vice versa; but you should still print either GOOD or BAD for each case.
この問題は、通常のCode Jamの問題と少し異なります。問題は120問(T = 120)あたえられ、数列のサイズ1000(N = 1000)となります。そして、各数列について答えを出力して下さい。ここまではいつもと同じです。しかし、今回は全ての問題に正答する必要はありません。少なくとも109個の問題(G = 109)に正答すれば、正解とみなされます。ただし、出力のフォーマットをかえていはいけません。つまり、答えがわからなかったとしても、GOODかBADを出力する必要があります。

It is guaranteed that the permutations given to you were generated according to the method above, and that they were generated independently of each other.
数列が上記のアルゴリズムで生成されることと、それぞれ独立して生成されることが保証されています。

This problem involves randomness, and thus it might happen that even the best possible solution doesn't make 109 correct guesses for a certain input, as both the good and the bad algorithms can generate any permutation. Because of that, this problem doesn't have a Large input, and has just the Small input which you can try again if you think you got unlucky. Note that there is the usual 4-minute penalty for incorrect submissions if you later solve that input, even if the only reason you got it wrong was chance.
In our experience with this problem, that did happen (getting wrong answer just because of chance); so if you are confident that your solution should be working, but it failed, it might be a reasonable strategy to try again with the same solution which failed.
Good luck!
(訳者注:この段落はpracticeには関係ないため、翻訳を省略します)

Input

The first line of the input gives the number of test cases, T (which will always be 120). Each test case contains two lines: the first line contains the single integer N (which will always be 1000), and the next line contains N space-separated integers - the permutation that was generated using one of the two algorithms.
最初の行は問題の数 **T** が書いてあります(常に120です)。以下 **T** 個の問題が続きます。各問題は2行あり、最初の行に数列の要素の数N(常に1000)が書いてあります。次の行はN個のスペースで区切られた数値が書いてあります。これが前述のどちらかのアルゴリズムで生成された数列です。


Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is either "GOOD" or "BAD" (without the quotes). You should output "GOOD" if you guess that the permutation was generated by the first algorithm described in the problem statement, and "BAD" if you guess that the permutation was generated by the second algorithm described in the problem statement.
各問題について、1行で "Case #x: **y**" と出力してください。 **x** は1から始まる問題番号、 **y** は"GOOD"か"BAD" ("は除く)を出力して下さい。"GOOD"はもし数列が最初のアルゴリズムで生成されたと予想される場合、"BAD"は数列が2つ目のアルゴリズムで生成されたと予想される場合出力して下さい。

Limits

T = 120
G = 109
N = 1000
Each number in the permutation will be between 0 and N-1 (inclusive), and each number from 0 to N-1 will appear exactly once in the permutation.
数列内の各数値は0からN-1(0とN-1を含む)になります。0からN-1までの各数値は、それぞれ1回ずつ数列中に現れます。

Sample


Input 
 	
Output 
 
2
3
0 1 2
3
2 0 1

Case #1: BAD
Case #2: GOOD

Note

The sample input doesn't follow the limitations from the problem statement - the real input will be much bigger.
サンプルは問題の制限を満たしていません。実際の入力はもっと大きくなります。