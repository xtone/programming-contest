# File Fix-it

出題元URL：https://code.google.com/codejam/contest/635101/dashboard#s=p0

## Problem

On Unix computers, data is stored in directories. There is one root directory, and this might have several directories contained inside of it, each with different names. These directories might have even more directories contained inside of them, and so on.

Unixコンピュータでは、データはディレクトリ内にファイルとして保存されます。ルートディレクトリが1つだけあり、その中にいくつかの名前の違うディレクトリがあります。これらのディレクトリはさらにその中にディレクトリを持つこともあり、それが繰り返されます。

A directory is uniquely identified by its name and its parent directory (the directory it is directly contained in). This is usually encoded in a path, which consists of several parts each preceded by a forward slash ('/'). The final part is the name of the directory, and everything else gives the path of its parent directory. For example, consider the path:

ディレクトリはその名前と親ディレクトリ(そのディレクトリを直接含むディレクトリ)によって一意に識別されます。これは通常パスとして表わされます。パスはスラッシュ('/')で始まるいくつかのパートで構成されます。最後のパートはディレクトリの名前で、他の部分はそれぞれの親ディレクトリです。例えば以下のパスを考えてみましょう。

```
/home/gcj/finals
```

This refers to the directory with name "finals" in the directory described by "/home/gcj", which in turn refers to the directory with name "gcj" in the directory described by the path "/home". In this path, there is only one part, which means it refers to the directory with the name "home" in the root directory.

この例では、「finals」ディレクトリの親ディレクトリは「/home/gcj」であり、その名前は「gcj」でその親ディレクトリは「/home」である、ということになります。この「/home」は「home」ディレクトリの親ディレクトリがルートディレクトリにあるということを表わしています。

To create a directory, you can use the mkdir command. You specify a path, and then mkdir will create the directory described by that path, but only if the parent directory already exists. For example, if you wanted to create the "/home/gcj/finals" and "/home/gcj/quals" directories from scratch, you would need four commands:

ディレクトリを作るには、mkdirコマンドを使います。mkdirコマンドにパスを指定すると、そのパスのディレクトリを作ります。ただし、親ディレクトリが存在する場合しか作りません。例えば、「/home/gcj/finals」というディレクトリと「/home/gcj/quals」というディレクトリを作りたければ、以下のように4回mkdirコマンドを使う必要があります。

```
mkdir /home
mkdir /home/gcj
mkdir /home/gcj/finals
mkdir /home/gcj/quals
```

Given the full set of directories already existing on your computer, and a set of new directories you want to create if they do not already exist, how many mkdir commands do you need to use?
既に存在する全てのディレクトリと、存在しないならば新しく作りたいディレクトリが与えられるので、mkdirコマンドを何回使えば存在しない新しく作りたいディレクトリを全て作れるかを回答して下さい。

## Input

The first line of the input gives the number of test cases, T. T test cases follow. Each case begins with a line containing two integers N and M, separated by a space.

最初の行は問題の数Tが書いてあります。以下T個の問題が続きます。各問題は2つの整数N、Mが空白で区切られて書いてある行で始まります。

The next N lines each give the path of one directory that already exists on your computer. This list will include every directory already on your computer other than the root directory. (The root directory is on every computer, so there is no need to list it explicitly.)

続くN行は既に存在するディレクトリのパスを表します。このリストはルートディレクトリを除く全ての既に存在するディレクトリを含みます。(ルートディレクトリは全てのコンピュータに存在するので、ここでリストに含める必要はないということです)

The next M lines each give the path of one directory that you want to create.

続くM行は新しく作りたいディレクトリのパスを表わします。

Each of the paths in the input is formatted as in the problem statement above. Specifically, a path consists of one or more lower-case alpha-numeric strings (i.e., strings containing only the symbols 'a'-'z' and '0'-'9'), each preceded by a single forward slash. These alpha-numeric strings are never empty.

それぞれのパスは前述した説明のフォーマットに従います。さらに、パスの各部分は1つ以上の小文字の英字または数字で構成され、スラッシュが先頭につきます。これらの英数字で構成される部分は空にはなりません。

## Output

For each test case, output one line containing "Case #x: y", where x is the case number (starting from 1) and y is the number of mkdir you need.
各問題について、1行で "Case #x: y" と出力してください。 xは1から始まる問題番号、 yは必要なmkdirの回数です。

## Limits

1 ≤ T ≤ 100.

No path will have more than 100 characters in it.

100文字以上のパスはありません。

No path will appear twice in the list of directories already on your computer, or in the list of directories you wish to create. A path may appear once in both lists however. (See example case #2 below).

全く同一のパスが既に存在するディレクトリのパスのリストに2回以上出現することはありません。
新しく作りたいディレクトリのパスのリストについても同様です。
ただし、それぞれのリストに同一のパスが出現することはありえます。(Exampleの#2を参照して下さい)

If a directory is listed as being on your computer, then its parent directory will also be listed, unless the parent is the root directory.

あるディレクトリのパスが、既に存在するディレクトリのパスのリストにあれば、その親のディレクトリも既に存在するパスのリストに存在します。(ルートディレクトリは除きます)

The input file will be no longer than 100,000 bytes in total.

入力ファイルは100,000バイト以下です。


## Small dataset

0 ≤ N ≤ 10.
1 ≤ M ≤ 10.

## Large dataset

0 ≤ N ≤ 100.
1 ≤ M ≤ 100.

## Sample

```
Input 
 	
3
0 2
/home/gcj/finals
/home/gcj/quals
2 1
/chicken
/chicken/egg
/chicken
1 3
/a
/a/b
/a/c
/b/b

Output

Case #1: 4
Case #2: 0
Case #3: 4
```
