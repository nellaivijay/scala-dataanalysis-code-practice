# Lab 2: Getting Started with Spark - DataFrames, Vectors and Matrices

## Overview

This lab introduces Apache Spark, the unified analytics engine for large-scale data processing. Spark has become the de facto standard for big data processing due to its speed, ease of use, and comprehensive ecosystem. You'll learn to set up Spark environments, work with DataFrames (Spark's structured data abstraction), and understand distributed computing concepts that power modern data engineering.

**What makes this lab important**: Spark is the foundation of modern big data processing. Understanding DataFrames, Spark's core abstraction, is essential for any data engineering or data science work. This lab bridges the gap between single-machine data analysis (from Lab 1) and distributed computing, preparing you for real-world big data challenges.

**Real-world applications**: ETL pipelines at scale, real-time analytics, log processing, data warehousing, machine learning model training on large datasets, and any scenario where data volume exceeds single-machine memory limits. Companies like Netflix, Uber, and Airbnb use Spark for their core data processing infrastructure.

## Learning Objectives

By the end of this lab, you will be able to:
- Set up a Spark environment for Scala
- Create and manipulate Spark DataFrames
- Work with Spark Vectors and Matrices
- Perform basic data transformations
- Understand Spark's distributed computing model

## Prerequisites

- Completed Lab 1: Breeze Basics (recommended)
- Apache Spark 1.6.0 or higher installed
- JDK 1.7 or higher installed
- Scala 2.10.4 or higher installed
- SBT 0.13.8 or higher installed
- Basic understanding of distributed computing concepts

## Estimated Time

60-90 minutes

## Conceptual Background

Apache Spark is a unified analytics engine for large-scale data processing. It provides:

- **DataFrames**: Distributed collections of data organized into named columns
- **RDDs (Resilient Distributed Datasets)**: Fundamental distributed data structures
- **Spark SQL**: SQL and DataFrame operations
- **MLlib**: Machine learning library with vectors and matrices
- **Spark Streaming**: Real-time data processing

Spark's main advantage is its ability to process data in memory across a cluster, making it much faster than traditional Hadoop MapReduce.

## Lab Steps

### Step 1: Set Up Spark Environment

1. Navigate to the `chapter1-spark-csv` directory:
```bash
cd chapter1-spark-csv
```

2. Examine the `build.sbt` file for Spark dependencies:
```scala
libraryDependencies += "org.apache.spark" %% "spark-core" % "1.6.0"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "1.6.0"
libraryDependencies += "org.apache.spark" %% "spark-mllib" % "1.6.0"
```

3. Compile the project:
```bash
sbt compile
```

### Step 2: Create a Spark Session

1. Initialize Spark context:
```scala
import org.apache.spark.{SparkContext, SparkConf}
import org.apache.spark.sql.SQLContext

val conf = new SparkConf()
  .setAppName("SparkDataFrameExample")
  .setMaster("local[*]") // Use local mode for development

val sc = new SparkContext(conf)
val sqlContext = new SQLContext(sc)
```

2. Check Spark context:
```scala
println(s"Spark version: ${sc.version}")
println(s"Spark master: ${sc.master}")
```

### Step 3: Create DataFrames

1. Create a DataFrame from a collection:
```scala
import sqlContext.implicits._

val data = Seq(
  (1, "Alice", 25),
  (2, "Bob", 30),
  (3, "Charlie", 35)
)

val df = data.toDF("id", "name", "age")
df.show()
```

2. Create a DataFrame from CSV:
```scala
val csvDF = sqlContext.read
  .format("csv")
  .option("header", "true")
  .option("inferSchema", "true")
  .load("path/to/your/csv/file.csv")

csvDF.show()
```

### Exercise 3.1
Create a DataFrame from the StudentData.csv file in the project directory and:
- Display the schema
- Show the first 10 rows
- Count the total number of rows

### Step 4: DataFrame Operations

1. Select specific columns:
```scala
val selectedDF = df.select("name", "age")
selectedDF.show()
```

2. Filter data:
```scala
val filteredDF = df.filter($"age" > 30)
filteredDF.show()
```

3. Group and aggregate:
```scala
val groupedDF = df.groupBy($"age").count()
groupedDF.show()
```

4. Sort data:
```scala
val sortedDF = df.orderBy($"age".desc)
sortedDF.show()
```

### Exercise 4.1
Using the StudentData DataFrame:
- Find students older than 20
- Count students by age group
- Find the average age
- Sort students by age in descending order

### Step 5: Spark Vectors and Matrices

1. Create Spark vectors:
```scala
import org.apache.spark.mllib.linalg.{Vector, Vectors}

val denseVector = Vectors.dense(1.0, 2.0, 3.0, 4.0)
val sparseVector = Vectors.sparse(4, Array(0, 2), Array(1.0, 3.0))

println(s"Dense vector: $denseVector")
println(s"Sparse vector: $sparseVector")
```

2. Create Spark matrices:
```scala
import org.apache.spark.mllib.linalg.{Matrix, Matrices}

val denseMatrix = Matrices.dense(2, 2, Array(1.0, 2.0, 3.0, 4.0))
val sparseMatrix = Matrices.sparse(2, 2, Array(0, 2), Array(0, 1), Array(1.0, 3.0))

println(s"Dense matrix: $denseMatrix")
println(s"Sparse matrix: $sparseMatrix")
```

3. Perform vector operations:
```scala
val v1 = Vectors.dense(1.0, 2.0, 3.0)
val v2 = Vectors.dense(4.0, 5.0, 6.0)

// Dot product
val dotProduct = breeze.linalg.DenseVector(v1.toArray) dot breeze.linalg.DenseVector(v2.toArray)
println(s"Dot product: $dotProduct")

// Element-wise operations using Breeze
val breezeV1 = breeze.linalg.DenseVector(v1.toArray)
val breezeV2 = breeze.linalg.DenseVector(v2.toArray)
val elementSum = breezeV1 + breezeV2
println(s"Element-wise sum: $elementSum")
```

### Exercise 5.1
Create two Spark vectors of length 5 and compute:
- Their dot product
- Element-wise sum
- Euclidean distance between them
- Convert results back to Spark vectors

### Step 6: Advanced DataFrame Operations

1. Join DataFrames:
```scala
val df1 = Seq((1, "Alice"), (2, "Bob")).toDF("id", "name")
val df2 = Seq((1, 25), (2, 30)).toDF("id", "age")

val joinedDF = df1.join(df2, "id")
joinedDF.show()
```

2. Create new columns:
```scala
val withAgeCategory = df.withColumn("age_category", 
  when($"age" < 30, "young")
  .when($"age" < 40, "middle-aged")
  .otherwise("senior"))

withAgeCategory.show()
```

3. User-defined functions:
```scala
import org.apache.spark.sql.functions.udf

val ageMultiplier = udf((age: Int) => age * 2)
val transformedDF = df.withColumn("doubled_age", ageMultiplier($"age"))
transformedDF.show()
```

### Exercise 6.1
Using the StudentData DataFrame:
- Create a new column that categorizes students by grade (A, B, C, D, F)
- Calculate the average grade for each age group
- Find the top 3 students by grade

## Expected Results

After completing this lab, you should:
- Be comfortable creating and manipulating Spark DataFrames
- Understand how to work with Spark vectors and matrices
- Be able to perform common data transformations
- Have a foundation for more advanced Spark operations

## Troubleshooting

### Issue: Spark context already exists
**Solution**: Ensure you stop any existing Spark context before creating a new one:
```scala
sc.stop()
```

### Issue: Out of memory errors
**Solution**: Increase Spark memory allocation:
```scala
conf.set("spark.driver.memory", "2g")
conf.set("spark.executor.memory", "4g")
```

### Issue: CSV file not found
**Solution**: Use absolute paths or ensure the CSV file is in the correct relative path

## Next Steps

After completing this lab, you can proceed to:
- Lab 3: Data Loading and Preparation
- Explore Spark SQL for more advanced queries
- Learn about Spark MLlib for machine learning

## Additional Resources

- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Spark DataFrame Guide](https://spark.apache.org/docs/latest/sql-programming-guide.html)
- [Spark MLlib Guide](https://spark.apache.org/docs/latest/mllib-guide.html)