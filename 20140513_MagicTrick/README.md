# Magic Trick

出題元URL: https://code.google.com/codejam/contest/2974486/dashboard#s=p0

## Probrem

Recently you went to a magic show. You were very impressed by one of the tricks, so you decided to try to figure out the secret behind it!

The magician starts by arranging 16 cards in a square grid: 4 rows of cards, with 4 cards in each row. Each card has a different number from 1 to 16 written on the side that is showing. Next, the magician asks a volunteer to choose a card, and to tell him which row that card is in.

Finally, the magician arranges the 16 cards in a square grid again, possibly in a different order. Once again, he asks the volunteer which row her card is in. With only the answers to these two questions, the magician then correctly determines which card the volunteer chose. Amazing, right?

最近行ったマジックショーで、あなたは1つのマジックにとても感銘を受けました。そこで、そのマジックの種を解明しようと思いました。
マジックは次のように行なわれました。まず、マジシャンは1～16の数字が書かれた16枚のカードを、数字が書かれた面を表にして、4x4の正方形に配置します。
次に観客に、1枚のカードを選んで、そのカードがどの行にあるかを宣言してもらいます。
最後に、マジシャンは16枚のカードを再度4x4の正方形に配置し、さっき選んだカードがどの行にあるのか宣言してもらいます。
このように、たった2回、どの行にあるかを宣言してもらっただけで、マジシャンは観客の選んだカードを当ててしまうのです！どうです、すごいでしょう？

You decide to write a program to help you understand the magician's technique. The program will be given the two arrangements of the cards, and the volunteer's answers to the two questions: the row number of the selected card in the first arrangement, and the row number of the selected card in the second arrangement. The rows are numbered 1 to 4 from top to bottom.

Your program should determine which card the volunteer chose; or if there is more than one card the volunteer might have chosen (the magician did a bad job); or if there's no card consistent with the volunteer's answers (the volunteer cheated).

さて、あなたはこのマジックの種を解明するためにプログラムを書くことにしました。
プログラムは2回分のカードの配置と、観客の宣言(1回目の配置で選んだカードがどの行にあるかと、2回目の配置で選んだカードがどの行にあるか)が与えられます。
なお、行は上から1～4で表わされます。
あなたのプログラムはどのカードが観客が選んだカードかを特定します。
ただし、観客が選んだ可能性があるカードが1枚にならない場合(マジシャンが失敗した)や、観客が選んだ可能性のあるカードが無い(観客が嘘をついた)場合など、特定できない場合もあります。

## Input

The first line of the input gives the number of test cases, **T**. **T** test cases follow. Each test case starts with a line containing an integer: the answer to the first question. The next 4 lines represent the first arrangement of the cards: each contains 4 integers, separated by a single space. The next line contains the answer to the second question, and the following four lines contain the second arrangement in the same format.

最初の1行は問題の数 **T** を表わします。次に **T** 個の問題が続きます。
各問題は次のようなフォーマットになります。
1行目は1つの数字があり、これは観客の1回目の宣言を表わします。
2行目から5行目は、1回目のカードの配置を表わします。この部分の各行は単一のスペースで区切られた4つの数字からなります。
6行目は1つの数字があり、これは観客の2回目の宣言を表わします。
7行目から10行目は、2回目のカードの配置を表わします。この部分の各行は単一のスペースで区切られた4つの数字からなります。

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1).

If there is a single card the volunteer could have chosen, y should be the number on the card. If there are multiple cards the volunteer could have chosen, y should be "Bad magician!", without the quotes. If there are no cards consistent with the volunteer's answers, y should be "Volunteer cheated!", without the quotes. The text needs to be exactly right, so consider copying/pasting it from here.

各問題の回答出力は1行で、"Case #x: y"として下さい。xは問題番号(1から始まります)です。
観客が選んだ可能性があるカードが1枚に特定できれば、yはそのカードに書かれた数字として下さい。
もし、観客が選んだ可能性があるカードが1枚にならない場合、yは「Bad magician!」として下さい。
さらに、観客が選んだ可能性があるカードが1枚も無い場合、yは「Volunteer cheated!」として下さい。

## Limits

1 ≤ **T** ≤ 100.
1 ≤ both answers ≤ 4.
Each number from 1 to 16 will appear exactly once in each arrangement.

1～16の各数字は、それぞれの配置において、重複や欠落無く1回ずつ配置されます。

## Sample

```
Input  
     
3
2
1 2 3 4
5 6 7 8
9 10 11 12
13 14 15 16
3
1 2 5 4
3 11 6 15
9 10 7 12
13 14 8 16
2
1 2 3 4
5 6 7 8
9 10 11 12
13 14 15 16
2
1 2 3 4
5 6 7 8
9 10 11 12
13 14 15 16
2
1 2 3 4
5 6 7 8
9 10 11 12
13 14 15 16
3
1 2 3 4
5 6 7 8
9 10 11 12
13 14 15 16

Output

Case #1: 7
Case #2: Bad magician!
Case #3: Volunteer cheated!
```
