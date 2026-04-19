# Lab 1: Getting Started with Breeze - Vectors, Matrices and RNGs

## Learning Objectives

By the end of this lab, you will be able to:
- Create and manipulate vectors using Breeze
- Create and manipulate matrices using Breeze
- Generate random numbers with Breeze's RNG
- Perform basic linear algebra operations
- Understand Breeze's numerical computing capabilities

## Prerequisites

- JDK 1.7 or higher installed
- Scala 2.10.4 or higher installed
- SBT 0.13.8 or higher installed
- Basic understanding of Scala programming
- Familiarity with linear algebra concepts (helpful but not required)

## Estimated Time

45-60 minutes

## Conceptual Background

Breeze is a Scala library for numerical computing. It provides:

- **Vectors**: Dense and sparse vector implementations
- **Matrices**: Dense and sparse matrix implementations
- **Random Number Generation**: Various probability distributions
- **Linear Algebra**: Matrix operations, decompositions, and solvers
- **Optimization**: Optimization algorithms and utilities

Breeze is designed to be similar to NumPy/SciPy in Python and MATLAB in terms of functionality and ease of use.

## Lab Steps

### Step 1: Set Up the Project

1. Navigate to the `chapter1-breeze-gettingready` directory:
```bash
cd chapter1-breeze-gettingready
```

2. Examine the `build.sbt` file to understand the Breeze dependencies:
```scala
libraryDependencies += "org.scalanlp" %% "breeze" % "0.13"
```

3. Compile the project:
```bash
sbt compile
```

### Step 2: Create and Manipulate Vectors

1. Create a dense vector:
```scala
import breeze.linalg._
val v = DenseVector(1.0, 2.0, 3.0, 4.0)
println(v)
```

2. Create a sparse vector:
```scala
val sv = SparseVector(1.0, 0.0, 3.0, 0.0)
println(sv)
```

3. Perform vector operations:
```scala
val v1 = DenseVector(1.0, 2.0, 3.0)
val v2 = DenseVector(4.0, 5.0, 6.0)

// Addition
val sum = v1 + v2
println(s"Sum: $sum")

// Subtraction
val diff = v1 - v2
println(s"Difference: $diff")

// Element-wise multiplication
val elementMul = v1 :* v2
println(s"Element-wise multiplication: $elementMul")

// Dot product
val dotProd = v1 dot v2
println(s"Dot product: $dotProd")
```

### Exercise 2.1
Create two vectors of length 5 with random values and compute:
- Element-wise sum
- Element-wise product
- Dot product
- Euclidean distance between the vectors

### Step 3: Create and Manipulate Matrices

1. Create a dense matrix:
```scala
val m = DenseMatrix((1.0, 2.0, 3.0),
                   (4.0, 5.0, 6.0),
                   (7.0, 8.0, 9.0))
println(m)
```

2. Create a sparse matrix:
```scala
val sm = CSCMatrix((1.0, 0.0, 3.0),
                  (0.0, 5.0, 0.0),
                  (7.0, 0.0, 9.0))
println(sm)
```

3. Perform matrix operations:
```scala
val m1 = DenseMatrix((1.0, 2.0), (3.0, 4.0))
val m2 = DenseMatrix((5.0, 6.0), (7.0, 8.0))

// Matrix addition
val mSum = m1 + m2
println(s"Matrix sum: $mSum")

// Matrix multiplication
val mMul = m1 * m2
println(s"Matrix multiplication: $mMul")

// Transpose
val mTrans = m1.t
println(s"Transpose: $mTrans")
```

### Exercise 3.1
Create two 3x3 matrices and compute:
- Matrix sum
- Matrix product
- Transpose of each matrix
- Element-wise product

### Step 4: Random Number Generation

1. Generate random numbers from different distributions:
```scala
import breeze.stats.distributions._

// Uniform distribution
val uniform = Uniform(0.0, 1.0)
val uniformSamples = uniform.sample(10)
println(s"Uniform samples: $uniformSamples")

// Gaussian distribution
val gaussian = Gaussian(0.0, 1.0)
val gaussianSamples = gaussian.sample(10)
println(s"Gaussian samples: $gaussianSamples")

// Poisson distribution
val poisson = Poisson(5.0)
val poissonSamples = poisson.sample(10)
println(s"Poisson samples: $poissonSamples")
```

2. Set random seed for reproducibility:
```scala
breeze.linalg.seed(42)
val reproducible = uniform.sample(5)
println(s"Reproducible samples: $reproducible")
```

### Exercise 4.1
Generate 100 random samples from:
- Uniform distribution (0, 10)
- Gaussian distribution (mean=5, std=2)
- Calculate mean and standard deviation of each sample set

### Step 5: Linear Algebra Operations

1. Solve linear equations:
```scala
val A = DenseMatrix((2.0, 1.0), (1.0, 3.0))
val b = DenseVector(5.0, 6.0)

// Solve Ax = b
val x = A \ b
println(s"Solution: $x")
```

2. Compute eigenvalues and eigenvectors:
```scala
val eigen = eig(A)
println(s"Eigenvalues: ${eigen.eigenvalues}")
println(s"Eigenvectors: ${eigen.eigenvectors}")
```

3. Compute matrix inverse:
```scala
val Ainv = inv(A)
println(s"Inverse: $Ainv")
```

### Exercise 5.1
Create a 4x4 matrix and compute:
- Its determinant
- Its inverse
- Its eigenvalues and eigenvectors
- Solve a linear system using this matrix

## Expected Results

After completing this lab, you should:
- Be comfortable creating and manipulating vectors and matrices in Breeze
- Understand how to generate random numbers from various distributions
- Be able to perform basic linear algebra operations
- Have a foundation for more advanced numerical computing tasks

## Troubleshooting

### Issue: Breeze dependency not found
**Solution**: Ensure you have the correct Breeze version in your `build.sbt` file and run `sbt reload`

### Issue: Compilation errors
**Solution**: Make sure you have imported the necessary Breeze packages:
```scala
import breeze.linalg._
import breeze.stats.distributions._
```

### Issue: Random numbers not reproducible
**Solution**: Always set the seed before generating random numbers:
```scala
breeze.linalg.seed(your_seed_value)
```

## Next Steps

After completing this lab, you can proceed to:
- Lab 2: Getting Started with Spark - DataFrames, Vectors and Matrices
- Explore more advanced Breeze operations in the documentation
- Apply Breeze to real-world numerical computing problems

## Additional Resources

- [Breeze Documentation](https://github.com/scalanlp/breeze)
- [Breeze Linear Algebra Guide](https://github.com/scalanlp/breeze/wiki/Linear-Algebra-Cheat-Sheet)
- [Scala Numerical Computing](https://scalanlp.github.io/)