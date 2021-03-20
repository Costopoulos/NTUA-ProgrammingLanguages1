Powers of two, again

The problem with the powers of the two is known from the first series of exercises this year. The purpose of this exercise is to write its solution in Prolog. Because Prolog systems do not run native code, the time limit for exercise will be significantly increased. Your program should contain a powers2/2 statement which will have the input file name as its first argument and will return the list of answers to its second argument. For examples of first-line pronunciation, your predicate should behave as shown below. 

?- powers2('f.txt', Answers), writeln(Answers), fail.

 [[1,2,1],[3,1,1],[],[2,2,1,0,0,1]]
 
 false. 
 
To read the input, see the model given in the second exercise.

Corona-graphs

The problem with locating coronographs is also known from the first series of exercises this year. The aim of this exercise is again to write its solution in Prolog. Your program should contain a coronograph / 2 predicate which will have the input filename as its first argument and return the answer list to its second argument. For examples of first-line pronunciation, your predicate should behave as shown below 
?- coronograph('graphs.txt', Answers), writeln(Answers), fail.

 [[3,[2,3,4]],'NO CORONA']
 
 false

Return to home
The lockdown found your friend Sotiris in his office at the University and you must help him return home safely. For Sotiris to be safe, he should avoid sites that are infected with the coronavirus. This is not easy because the infection is spreading between neighboring locations and because air travel has not stopped!
A two-dimensional map of the world is given, consisting of N x M squares (where 2 ≤ N, M ≤ 1000). Each square of the map contains one of the following symbols:
"S": The initial position of Sotiris, in his office.
"T": The desired final position of Sotiris, in his house.
"W": The square from which the infection begins, somewhere in the depths of Asia.
"A": There is an airport in this block.
“.”: (Dot) The square is empty.
"X": Neither Sotiris nor the infection can go to this square (obstacle, e.g. sea).
The coronavirus is constantly spreading in the adjacent squares (left, right, up and down), if these are not obstacles, with the result that larger and larger areas of the map become infected. The infection moves at a rate of one square per two units of time. If it arrives at an airport, then after 5 units of time we should consider that it has arrived at all the airports in the world! Fortunately for him, Sotiris is faster: he can move in the neighboring squares, at a rate of one square per unit time, but he has no appetite to get on planes.
What you need to find is which route to take to get home safely and in the shortest possible time (if of course this can happen). The answer to this question is a string that describes the sequence of movements that Sotiris will make. Strong moves are represented by the symbols: 
"R": Move one square to the right on the map.
“L”: Move one square to the left on the map.
“U”: Move one square up on the map.
“D”: Move one square down on the map.
The exercise asks you to write two programs (one in ML and one in Python) which will answer the above questions. Because Python implementations do not run native code, the time limit for your Python program will be longer than in ML.
The input of your program is read from a file consisting of N lines, each of which contains M symbols. This file represents the map.
The output of your program should be as follows. The first line must be printed the minimum time in which the Savior can be safely at home or, if this can not happen, the word "IMPOSSIBLE". In case it is possible for Sotiris to reach his house, a second line should be printed containing a string: the sequence of movements that Sotiris must make. (Of course, the length of this string will be equal to the integer printed on the first line.) If there are many different solutions, then we choose the lexically shorter one.

In MLton or Ocaml

$ ./stayhome s1.txt

15

DDRRRRRRRDRRRDR

$ ./stayhome s2.txt

12

UUURRRRDRDDR

$ ./stayhome s3.txt

IMPOSSIBLE


In SML / NJ

- stayhome "s1.txt";

15

DDRRRRRRRDRRRDR

val it = (): unit

- stayhome "s2.txt";

12

UUURRRRDRDDR

val it = (): unit

- stayhome "s3.txt";

IMPOSSIBLE

val it = (): unit

In Python

$ python3 stayhome.py s1.txt

15

DDRRRRRRRDRRRDR

$ python3 stayhome.py s2.txt

12

UUURRRRDRDDR

$ python3 stayhome.py s3.txt

IMPOSSIBLE

In the first example the coronavirus reaches the airport near the house but Sotiris is faster. It can reach his home in 15 moves, while the virus will get there in 17 - almost! In order to achieve the lexically minimal sequence of movements he should go first down and then to the right, but this is not done because he has to avoid the infected squares. Study his maneuver, he did just fine ...
In the second example, if the virus did not exist, Sotiris could go home in 12 movements, either from the top or the bottom, and lexically it is smaller than the bottom. However, with the spread of the virus, of the two routes only the upper one is possible, due to the airport located on the upper right.
In the third example it is not possible for Sotiris to reach his house because he will pass through an infected square at time t = 4.
