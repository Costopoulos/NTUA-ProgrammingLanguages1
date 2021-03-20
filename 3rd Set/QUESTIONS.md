Return to Home, again

The problem with Sotiris returning home is known from the previous series of exercises this year. The purpose of this exercise is to write its solution in Java. Your program should behave in the same way as the Python programs you delivered for the second set of exercises. For examples of second-line pronunciation, the output of your program should be as follows (note that this means that your main class — the one with the main method — should be called "StayHome", pay attention to uppercase and lowercase letters ):

$ java StayHome s1.txt

15

DDRRRRRRRDRRRDR

$ java StayHome s2.txt

12

UUURRRRDRDDR

$ java StayHome s3.txt

IMPOSSIBLE


Find the vaccine

After Sotiris made it back home, he asks us for one last time this year to help him. He has been able to isolate coronavirus RNA, which as we may remember from biology is a chain of nitrogenous bases: "A", "C", "G" and "U". So we have a string of characters in this alphabet that describes the RNA of the virus.
Sotiris wants to make a vaccine that will kill the virus. To do this, the virus RNA must be transformed so that all the same bases appear contiguously in the chain. In other words, all "A" must be together, all "C" must be together, and so on. The order in which the groups of the bases will appear does not matter.
RNA is transformed through a complex process that Sotiris explained to us and we understood it as follows. We place the characters that describe the chain of the bases in a stack. There is a second, initially empty stack, in which at the end will be found the result of the transformation. We have three moves at our disposal:
- push (“p”): removes the base on top of the first stack and places it on top of the second stack.
- complement (“c”): replaces each base of the first stack with its “complementary” - the complementary base pairs are “A-U” and “C-G”.
- reverse (“r”): inverts the contents of the second stack so that its top is at the bottom and vice versa.
Each sequence of movements (ie characters "p", "c" and "r") gives us a possible vaccine. For the vaccine to be useful, when we apply the movements in order, from left to right, the first stack must be completely empty and the second one must contain the bases in the desired shape (ie all the "A's" together, all the "C" together, etc.).
For example, if the RNA of the virus that we will first place in the first stack is "GUACA" and we apply the sequence of movements "pprpcprp", the result will be "CCAAA" and this has the desired form (all "A" are together as and all “C”). 
For each RNA, more vaccines can be made with the desired effect. But Sotiris prefers small vaccines, that is, with a small number of movements. The above vaccine is not minimal because the "pprppp" vaccine also has this desired effect.
The input data will be read from a file in a format similar to that shown in the examples below. The first line of the file will contain an integer N (1 ≤ N ≤ 10), the number of questions that will follow. Each of the next N lines will contain a string consisting of one or more characters of the "ACGU" alphabet.
Your program should print a total of N lines on the standard output, each of which will contain a minimum vaccine for the corresponding query virus. (It can be shown that there is a vaccine for every RNA virus.) Between vaccines of equal length, your program must print the lexicographically smaller one.
Limitations: The length of the strings will not exceed 100 and the control cases will be such that a relatively simple BFS solver (like the one we saw in the Java lab) can solve them within the limits of time and memory.
