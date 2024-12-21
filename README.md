# COMS4115_HW3 Programming Assignment 4: Optimization
# Team: Amanda Jenkins (alj2155) 

## Overview on Optimization Techniques Employed in My Project

### 1. Dead Code Elimination
Dead code elimination focuses on removing lines code that don't affect the program's overall behavior or output. In the optimization process, this was applied in my code_optimization.py filer to eliminate redundant display o calls for the same matrix. For example, if a matrix is displayed multiple times consecutively without any modification to its values, subsequent display {matrix} calls are unnecessary and can be removed without altering the program's correctness. By removing such redundant operations, the program's runtime is reduced. This optimization not only improves execution speed but also results in more efficient code.

### 2. Constant Folding
Constant folding is a technique that precomputes constant expressions during the compilation or optimization stage which reduces the number of calculations performed at runtime. For instance, if there are static values in matrix initialization or fixed expressions, the optimizer handles them before execution. This ensures that runtime only deals with dynamic operations, like the actual multiplication of A x B, while keeping everything else efficient and ready to go. By folding constants, my program avoids unnecessary repetitive calculations, making it faster and less resource-intensive.

### 3. Common Subexpression Elimination (CSE)
Common subexpression elimination (CSE) identifies expressions that are computed multiple times in the code and replaces subsequent occurrences with a previously computed value. For example, in my atrix operations, if a multiplication lines appear multiple times within a loop, it is computed once and stored in a temporary variable. Subsequent uses of the expression refer to the temporary variable instead of recalculating the value. This optimization reduces the number of redundant calculations which also minimizes computational effort and improving performance. CSE is particularly effective in matrix operations done in my language and loops where repeated expressions can be costly.

### 4. Peephole Optimization
Peephole optimization focuses on examining small sections of code to identify and eliminate inefficiencies or redundancies. For example, if there is a computation like D = C x C that is never used or necessary for the final result, it can be safely removed to streamline the program. In my optimization, redundant operations like recalculating D after already calculating and displaying C were detected and removed (Sample Program 4). This reduces the number of instructions executed and ensures that only essential computations are included, improving overall performance. Peephole optimization is especially effective in simplifying code for straightforward tasks like matrix operations where unnecessary calculations can significantly slow down execution.
 
My C target  (intermediate) has been optimized for my matrix opertaion language. 

## 4 sample input programs

### Sample Program 1: Dead Code Elimination
Input Program (example.txt):
```
A = (1,2)
    (3,4)
B = (5,6)
    (7,8)
C = A x B
display C
display C
display C

```

Optimized Matrix Operation Language:
```
A = (1,2)
    (3,4)
B = (5,6)
    (7,8)
C = A x B
display C

```



Expected Optimized Output (optimized_code.c):
```
#include <stdio.h>

void printMatrix(int rows, int cols, int matrix[rows][cols]) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    int A[2][2] = {{1,2}, {3,4}};
    int B[2][2] = {{5,6}, {7,8}};
    int C[2][2] = {{0}};
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    printf("Matrix C:\n");
    printMatrix(2, 2, C);
    return 0;
}


``` 

### Sample Program 2: Constant Folding
Input Program (example.txt):
```
A = (1 + 2, 3 * 2)
    (4 - 1, 6 / 2)
B = (3,4)
    (5,6)
C = A x B
display C

```

Optimized Matrix Operation Language:
```
A = (3,6)
    (3,3)
B = (3,4)
    (5,6)
C = A x B
display C

```


Expected Optimized Output (optimized_code.c):
```
#include <stdio.h>

void printMatrix(int rows, int cols, int matrix[rows][cols]) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    int A[2][2] = {{3, 6}, {3, 3}};
    int B[2][2] = {{3, 4}, {5, 6}};
    int C[2][2] = {{0}};
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    printf("Matrix C:\n");
    printMatrix(2, 2, C);
    return 0;
}

``` 

### Sample Program 3: Common Subexpression Elimination (CSE)

Input Program (example.txt):
```
A = (1,2)
    (3,4)
B = (5,6)
    (7,8)
C = A x B
D = A x B
E = A x B
display C
display D
display E

```

Optimized Matrix Operation Language:
```
A = (1,2)
    (3,4)
B = (5,6)
    (7,8)
C = A x B
display C

```


Expected Optimized Output (optimized_code.c):
```
#include <stdio.h>

void printMatrix(int rows, int cols, int matrix[rows][cols]) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    int A[2][2] = {{1,2}, {3,4}};
    int B[2][2] = {{5,6}, {7,8}};
    int C[2][2] = {{0}};
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    printf("Matrix C:\n");
    printMatrix(2, 2, C);
    return 0;
}

``` 


### 4. Sample Program 4: Peephole Optimization

Input Program (example.txt):
```
A = (1,2)
    (3,4)
B = (5,6)
    (7,8)
C = A x B
D = C x C
display D

```

Optimized Matrix Operation Language:
```
A = (1,2)
    (3,4)
B = (5,6)
    (7,8)
C = A x B
display C

```


Expected Optimized Output (optimized_code.c):
```
#include <stdio.h>

void printMatrix(int rows, int cols, int matrix[rows][cols]) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    int A[2][2] = {{1,2}, {3,4}};
    int B[2][2] = {{5,6}, {7,8}};
    int C[2][2] = {{0}};
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    printf("Matrix C:\n");
    printMatrix(2, 2, C);
    return 0;
}

``` 
This program defines D = C x C and then displays D. However, calculating C x C is redundant since the program does not modify or use D anywhere else. The optimizer identifies this redundancy and removes the unnecessary computation of D. Instead, it simplifies the program by directly displaying C.

## Running Code 

To test the programs using the compiler pipeline, follow these steps:
1. Prepare the Input File: Save program in a example.txt file which is the source code file.
2. Run the Compiler Script (run_opt.sh): 
    * cd into folder "HW_4_PLT" if you have not already
    * chmod +x run_opt.sh
    * run_opt.sh to process the input file.
        *  For example, ./run_opt.sh example.txt
* You will see the optimized intermediate code in output_code.c


## Video Demo
https://drive.google.com/drive/folders/1aLA1xKmEmkbh_qxEmeFN8nb-kQ1QZICD?usp=sharing
