This is the repository for the paper about the order of ZNumbers.

All the functions are written in the R language.

The discrete fuzzy numbers are introduced as follows:
for example dfn= c(0,0.1,0.2,0.5,1,1,0.9,0.8) is the discrete fuzzy number associated with the chain {0,1,2,3,4,5,6,7} whose values are the following:
dfn(0)=0,
dfn(1)=0.1,
dfn(2)=0.2,
dfn(3)=0.5,
dfn(4)=1,
dfn(5)=1,
dfn(6)=0.9
dfn(7)=0.8

There are the following functions:

- alpha.cut(dfn,alpha) is a function that returns the alpha cut of the dfn for alpha, that is,
the set [ax,bx] where for all y in [ax,bx] dfn(y)>=alpha. For example:
alpha.cut(dfn,0.65)
returns
5 8
So, the alpha.cut of the dfn for alpha=0.65 is the discrete interval {4,5,6,7}.

- core(dfn) is a function that returns the core of the dfn, that is,
the set [ax,bx] where for all y in [ax,bx] dfn(y)=1. For example:
core(dfn)
returns
5 6
So, the core of the dfn is the discrete interval {4,5}.

- increasing.generation(values,length.dfn) is a function that generates all increasing dfns that 
take values in parameter values whose length of the Ln is length.dfn. For example
increasing.generation(c(0.1,0.3,1),2)
returns
     [,1] [,2]
[1,]  0.1  0.1
[2,]  0.1  0.3
[3,]  0.1  1.0
[4,]  0.3  0.3
[5,]  0.3  1.0
[6,]  1.0  1.0
that is, the 6 increasing dfns associated with the chain {0,1} whose values are in the set {0.1,0.3,1}

- decreasing.generation(values,length.dfn) is a function that generates all decreasing dfns that 
take values in parameter values whose length of the Ln is length.dfn. For example
decreasing.generation(c(0.1,0.3,1),2)
returns
     [,1] [,2]
[1,]  0.1  0.1
[2,]  0.3  0.1
[3,]  1.0  0.1
[4,]  0.3  0.3
[5,]  1.0  0.3
[6,]  1.0  1.0
that is, the 6 decreasing dfns associated with the chain {0,1} whose values are in the set {0.1,0.3,1}

all.dfns(y,n) is a function that generates all dfns that take values in the vector (y,1) whose length of the chain Ln is n or the chain Ln is {0,1,...,n-1}. So, the value 1 is excluded in the vector y. For example
all.dfns(c(0,0.3),4)
returns
      [,1] [,2] [,3] [,4]
 [1,]  0.0  1.0  0.0  0.0
 [2,]  0.0  1.0  0.3  0.0
 [3,]  0.0  1.0  0.3  0.3
 [4,]  0.3  1.0  0.0  0.0
 [5,]  0.3  1.0  0.3  0.0
 [6,]  0.3  1.0  0.3  0.3
 [7,]  0.0  1.0  1.0  0.0
 [8,]  0.0  1.0  1.0  0.3
 [9,]  0.3  1.0  1.0  0.0
[10,]  0.3  1.0  1.0  0.3
[11,]  0.0  0.0  1.0  0.0
[12,]  0.0  0.0  1.0  0.3
[13,]  0.0  0.3  1.0  0.0
[14,]  0.0  0.3  1.0  0.3
[15,]  0.3  0.3  1.0  0.0
[16,]  0.3  0.3  1.0  0.3
[17,]  1.0  0.0  0.0  0.0
[18,]  1.0  0.3  0.0  0.0
[19,]  1.0  0.3  0.3  0.0
[20,]  1.0  0.3  0.3  0.3
[21,]  1.0  1.0  0.0  0.0
[22,]  1.0  1.0  0.3  0.0
[23,]  1.0  1.0  0.3  0.3
[24,]  1.0  1.0  1.0  0.0
[25,]  1.0  1.0  1.0  0.3
[26,]  0.0  1.0  1.0  1.0
[27,]  0.3  1.0  1.0  1.0
[28,]  0.0  0.0  1.0  1.0
[29,]  0.0  0.3  1.0  1.0
[30,]  0.3  0.3  1.0  1.0
[31,]  0.0  0.0  0.0  1.0
[32,]  0.0  0.0  0.3  1.0
[33,]  0.0  0.3  0.3  1.0
[34,]  0.3  0.3  0.3  1.0
[35,]  1.0  1.0  1.0  1.0
that is, all the dfns associated with the chain {0,1,2,3} whose values are in the set {0,0.3,1}.

- sort.dfns(dfn1,dfn2,y). Given two dfns dfn1 and dfn2 associated with the chain {0,1,...,n-1} that take values in the vector (y,1) (the value 1 is excluded in the vector y) sort.dfns is a function that returns TRUE if the dfns dfn1 is greater than dfn2 and it returns FALSE otherwise. Therefore, in this function the order of the dfns must be defined.
For example, for the lexicographic order, if 
dfn1=c(0,0.1,0.3,1)
dfn2=c(0,0.3,1,0.5)
and
y=c(0,0.1,0.3,0.5)
sort.dfns(dfn1,dfn2,y)
returns
FALSE


- mmerge(a,b,y) is a function that sorts the given dfns by rows a and b using the order defined in the sort.dfns function. The dfns take values in the vector (y,1).
For example:
dfns.all = all.dfns(c(0,0.3),4)  # We store all dfns associated to the chain {0,1,2,3} that take values in the set {0,0.3,1} in the object dfns.all. 
The function
mmerge(dfns.all[1:10,],dfns.all[20:30,],c(0,0.3))
returns
      [,1] [,2] [,3] [,4]
 [1,]  0.0  1.0  0.0  0.0
 [2,]  0.0  1.0  0.3  0.0
 [3,]  0.0  1.0  0.3  0.3
 [4,]  0.3  1.0  0.0  0.0
 [5,]  0.3  1.0  0.3  0.0
 [6,]  0.3  1.0  0.3  0.3
 [7,]  0.0  1.0  1.0  0.0
 [8,]  0.0  1.0  1.0  0.3
 [9,]  0.3  1.0  1.0  0.0
[10,]  0.3  1.0  1.0  0.3
[11,]  1.0  0.3  0.3  0.3
[12,]  1.0  1.0  0.0  0.0
[13,]  1.0  1.0  0.3  0.0
[14,]  1.0  1.0  0.3  0.3
[15,]  1.0  1.0  1.0  0.0
[16,]  1.0  1.0  1.0  0.3
[17,]  0.0  1.0  1.0  1.0
[18,]  0.3  1.0  1.0  1.0
[19,]  0.0  0.0  1.0  1.0
[20,]  0.0  0.3  1.0  1.0
[21,]  0.3  0.3  1.0  1.0


- mmergesort(A,y) is a function that sorts the given dfns by rows of matrix A using the merge sort algorithm. The dfns take values in the vector (y,1).
For example:
dfns.all = all.dfns(c(0,0.3),4)  # We store all dfns associated to the chain {0,1,2,3} that take values in the set {0,0.3,1} in the object dfns.all. 
mmergesort(dfns.all,c(0,0.1,0.3))
returns
       [,1] [,2] [,3] [,4]
 [1,]  0.0  1.0  0.0  0.0
 [2,]  0.0  1.0  0.3  0.0
 [3,]  0.0  1.0  0.3  0.3
 [4,]  0.3  1.0  0.0  0.0
 [5,]  0.3  1.0  0.3  0.0
 [6,]  0.3  1.0  0.3  0.3
 [7,]  0.0  1.0  1.0  0.0
 [8,]  0.0  1.0  1.0  0.3
 [9,]  0.3  1.0  1.0  0.0
[10,]  0.3  1.0  1.0  0.3
[11,]  0.0  0.0  1.0  0.0
[12,]  0.0  0.0  1.0  0.3
[13,]  0.0  0.3  1.0  0.0
[14,]  0.0  0.3  1.0  0.3
[15,]  0.3  0.3  1.0  0.0
[16,]  0.3  0.3  1.0  0.3
[17,]  1.0  0.0  0.0  0.0
[18,]  1.0  0.3  0.0  0.0
[19,]  1.0  0.3  0.3  0.0
[20,]  1.0  0.3  0.3  0.3
[21,]  1.0  1.0  0.0  0.0
[22,]  1.0  1.0  0.3  0.0
[23,]  1.0  1.0  0.3  0.3
[24,]  1.0  1.0  1.0  0.0
[25,]  1.0  1.0  1.0  0.3
[26,]  0.0  1.0  1.0  1.0
[27,]  0.3  1.0  1.0  1.0
[28,]  0.0  0.0  1.0  1.0
[29,]  0.0  0.3  1.0  1.0
[30,]  0.3  0.3  1.0  1.0
[31,]  0.0  0.0  0.0  1.0
[32,]  0.0  0.0  0.3  1.0
[33,]  0.0  0.3  0.3  1.0
[34,]  0.3  0.3  0.3  1.0
[35,]  1.0  1.0  1.0  1.0

- omega(dfn,sorted.dfns)  is a function that returns the value of w(dfn) using the sorted dfns 
stored in sorted.dfns.
For example:
dfns.all = all.dfns(c(0,0.3),4)  # We store all dfns associated to the chain {0,1,2,3} that take values in the set {0,0.3,1} in the object dfns.all. 
sorted.dfns = mmergesort(dfns.all,c(0,0.1,0.3)) # We store the sorted dfns in the object sorted.dfns.
dfn=c(0.3,0.3,1,1)
omega(dfn,sorted.dfns)
returns
0.2
Therefore, the value of w(dfn)=0.2.

- AB(A,w,f) is a function that returns the dfn A_B using the dfn A, the value of w (the value of omega of the dfn B) and 
the decreasing fuction f.
For example:
f = function(x){1-x} # We define the function f
A = c(0,0.2,0.6,1,1,0.6) # We define the dfn A
w = 119/126 # We set the value of omega(B)
AB(A,w,f)
returns
0.0000000 0.2444444 0.6222222 1.0000000 1.0000000 0.6222222
Therefore, the chain associated to the dfn A_B is the set {0,1,2,3,4,5} where said dfn takes the following values:
A_B(0)=0
A_B(1)=0.2444444
A_B(3)=0.6222222
A_B(4)=1
A_B(5)=1
A_B(6)=0.6222222