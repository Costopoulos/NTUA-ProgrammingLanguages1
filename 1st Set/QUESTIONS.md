Powers of two (2n)

As we know, the powers of two are the positive integers 1, 2, 4, 8, 16, ...
We can write every positive integer as a sum of powers of two. For example, number 42 can be written as 2 + 8 + 32. But be aware that there are other ways to write 42 as the sum of the forces of two, e.g. as 2 + 2 + 2 + 4 + 16 + 16, as 2 + 8 + 8 + 8 + 8 + 8, or even adding 42 times the integer 1.
What we want to do is find if an integer N (1 ≤ N ≤ 1,000,000,000) can be written as the sum of exactly K (1 ≤ K ≤ 200,000) powers of two or not and, in case it can be written, find the lexicographically smaller way it can be done. For example, lexically the smallest way that integer 9 can be written as the sum of 5 powers of two is 1 + 1 + 1 + 2 + 4 and the lexically smaller way that 42 can be written with 6 powers of two is 1 + 1 + 2 + 2 + 4 + 32. To avoid too much output in cases with many repetitions, the above two ways can be collapsed as [3,1,1] (ie three times 1, one 2, one 4) and [2,2,1,0,0,1], respectively. But, of course, there is no way to write integer 9 with 10 powers of two and no way to write 42 with 2 powers of two, so in these cases your program should print a blank list []. The exercise asks you to write two programs (one in C / C ++ and one in ML) which read T pairs of integers N and K and, for each pair in turn, print the lexically smaller way that N can be written as the sum of exactly K forces of the two in the form described above, or [] if it cannot. 
The input data will be read from a file as shown in the example that follows. The first line of the file contains an integer T (1 ≤ T ≤ 10): the number of the following pairs. Then follow T lines, each of which contains two integers N and K, separated by a space. 

Below is an example in C / C ++ and ML. 
In C/C++, MLton, or in OCaml
$ ./powers2 f.txt
[1,2,1]
[3,1,1]
[]
[2,2,1,0,0,1] 
 
In SML/NJ
- powers2 "f.txt";
[1,2,1]
[3,1,1]
[]
[2,2,1,0,0,1]
val it = () : unit

where the input data file is as follows (the cat command is a Unix command):
$ cat f.txt
4
9 4
9 5
42 2
42 6
Corona-graphs
Your friend Sotiris is an infectious disease specialist and has undertaken a very important job: to study the structure of the coronavirus. But this virus, in addition to being dangerous to our health, is also quite complex in its structure, so your friend needs your help. 
According to your friend, 1 the genetic material of the coronavirus consists of N corononucleotides (as Sotiris put it, let's call them "nodes") which are connected to each other by M coronaviruses (let's call them "edges"). 
So if we imagine it as an undirected graph, the genetic material of the coronavirus has the following form: It consists of a set of trees, the roots of which are connected in a circle. In the adjacent figure, these trees have their roots at nodes 1, 4 and 5. Note that these trees are not necessarily binary and that a tree can consist of only its root.
Sotiris wants, given a graph, to be able to find out if it really has this form. If so, he also wants to know how many trees make up the number of nodes in each tree.
The exercise asks you to write two programs (one in C / C ++ and one in ML) which read several graphs and for each in turn answer the above.
The input data will be read from a file as shown in the following example. The first line of the file contains an integer T (1 ≤ T ≤ 10): the number of graphs that follow. The following are T graph descriptions, each of which has the following format. Its first line contains two integers separated by a space: the number of nodes N (1 ≤ N ≤ 1,000,000) and the number of edges M (1 ≤ M ≤ 1,000,000). Each of the following M lines describes an edge of the graph and contains two integers, separated by a space. These numbers are the numbers of the nodes at the ends of that edge. Assume that the nodes are numbered from 1 to N, that the edges of the edge are always different from each other, and that the same edge will not be given twice.
Your program should check each graph in the order given. If the graph is in the form of a coronavirus, your program should print two lines. The first will contain the word "CORONA", a space and an integer: the number C of the trees that appear in the circle in the center of the graph. (Of course it will be C ≥ 3 to have a circle). The second line will contain exactly C integers divided by two with a space: the numbers of nodes in each of the C trees. These numbers should appear in ascending order. Conversely, if the graph is not in the form of a corona, your program should print a line containing the message "NO CORONA" (and of course we do not mean beer).
Below is an example in C / C ++ and ML.

C/C++, MLton, ή σε OCaml

$ ./coronograph graphs.txt

CORONA 3

2 3 4

NO CORONA



SML/NJ

- coronograph "graphs.txt";

CORONA 3

2 3 4

NO CORONA

val it = () : unit
where the input data file is as follows:

$ cat graphs.txt

2

9 9

6 3

7 1

8 9

6 4

5 1

1 9

2 5

1 4

5 4

9 9

4 6

8 1

3 4

2 8

6 7

9 3

4 7

1 5

4 9

