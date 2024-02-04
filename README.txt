
-A MIPS assembly program coded using Mars simulator to solve a unique first order ordinary differential equation numerically using Euler's method.
-To solve these equations, the initial value of y (i.e. Y(0) ) is usually given.
-Euler method finds the value of y at any value of x by the following iterative algorithm:
Y(X𝑛+1) = Y(X𝑛) + h*F(Xn,Y( X𝑛))
Xn+1= Xn+h
Where :
● h is the discrete step size in x-axis. 
●X𝑛 and Y(X𝑛) are values of x and y at the step n.
●X𝑛+1, Y(X𝑛+1) are the values of x and y at the next step.
- Algorithm starts by setting Xn= 0 and Y(X𝑛) = Y(0), then iteratively reaching y at any given x.
-The written assembly function is called “euler_fn” 
-The function will takes as input :
* Y(0) 
* h 
* the required number of steps
- The function returns y after this number of steps as output.
-The program should expect Y(0), h, and the required number of steps, to be passed to the program using pa option in CLI.
-The returned value is kept in $v0 and written in memory address [0x10010000] (first data address in mars)
-Multiplication function was made using 'sll' shifting left 
-No pseudo instructions are used in this program
-Preservation rules has been followed for saved, temporary and return address registers ( $S $t $ra ) on the memory stack.
-MIPS calling convention has been followed.
-An approximation has been done by considering all parameters and results to be integers.
-Sample equation in the code : y′=57x^2 −14x−462y^3+38y^2+65y−73
