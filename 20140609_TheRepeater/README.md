# The Repeater

出題元URL: https://code.google.com/codejam/contest/2994486/dashboard#s=p0

## Problem

Fegla and Omar like to play games every day. But now they are bored of all games, and they would like to play a new game. So they decided to invent their own game called "The Repeater".

They invented a 2 player game. Fegla writes down **N** strings. Omar's task is to make all the strings identical, if possible, using the minimum number of actions (possibly 0 actions) of the following two types:

* Select any character in any of the strings and repeat it (add another instance of this character exactly after it). For example, in a single move Omar can change "abc" to "abbc" (by repeating the character 'b').
* Select any two adjacent and identical characters in any of the strings, and delete one of them. For example, in a single move Omar can change "abbc" to "abc" (delete one of the 'b' characters), but can't convert it to "bbc".

The 2 actions are independent; it's not necessary that an action of the first type should be followed by an action of the second type (or vice versa).

Help Omar to win this game by writing a program to find if it is possible to make the given strings identical, and to find the minimum number of moves if it is possible.

## Input

The first line of the input gives the number of test cases, **T**. **T** test cases follow. Each test case starts with a line containing an integer **N** which is the number of strings. Followed by **N** lines, each line contains a non-empty string (each string will consist of lower case English characters only, from 'a' to 'z').

## Output

For each test case, output one line containing "Case #x: y", where x is the test case number (starting from 1) and y is the minimum number of moves to make the strings identical. If there is no possible way to make all strings identical, print "Fegla Won" (quotes for clarity).

## Limits

1 ≤ **T** ≤ 100.
1 ≤ length of each string ≤ 100.

## Small dataset

**N** = 2.

## Large dataset

2 ≤ **N** ≤ 100.

## Sample

```
Input 

5
2
mmaw
maw
2
gcj
cj
3
aaabbb
ab
aabb
2
abc
abc
3
aabc
abbc
abcc

Output

Case #1: 1
Case #2: Fegla Won
Case #3: 4
Case #4: 0
Case #5: 3
```
