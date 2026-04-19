# Lab 3: Data Loading and Preparation - Spark DataFrames

## Overview

Data scientists and data engineers spend 60-80% of their time on data loading, cleaning, and preparation. This lab focuses on the critical but often overlooked foundation of data analysis: getting data into Spark and preparing it for analysis. You'll learn to load data from various formats (CSV, JSON, Parquet), handle real-world data quality issues, and perform transformations that make data analysis-ready.

**What makes this lab important**: In real-world scenarios, data is rarely clean or ready for analysis. Understanding how to efficiently load, clean, and transform data is what separates successful data projects from failed ones. This lab teaches you practical skills that you'll use daily in any data engineering or data science role.

**Real-world applications**: Building ETL pipelines, data warehouse population, data quality monitoring, real-time data ingestion, and preparing datasets for machine learning. These skills are universally applicable across industries from finance to healthcare to e-commerce.

## Learning Objectives

By the end of this lab, you will be able to:
- Load data from various sources (CSV, JSON, Parquet)
- Clean and preprocess data
- Handle missing values
- Transform and reshape data
- Understand schema management

## Prerequisites

- Completed Lab 2: Spark Fundamentals
- Apache Spark 1.6.0 or higher
- Sample datasets provided in the project

## Estimated Time

60-90 minutes

## Conceptual Background

Data loading and preparation is a critical step in any data analysis pipeline. Spark provides:

- **Multiple Data Sources**: CSV, JSON, Parquet, Avro, ORC, JDBC
- **Schema Management**: Automatic schema inference and explicit schema definition
- **Data Cleaning**: Handling missing values, duplicates, and outliers
- **Data Transformation**: Filtering, grouping, aggregating, and reshaping

## Lab Steps

### Step 1: Load Data from Different Sources

1. Load CSV data:
```scala
val csvDF = sqlContext.read
  .format("csv")
  .option("header", "true")
  .option("inferSchema", "true")
  .load("data/StudentData.csv")

csvDF.printSchema()
csvDF.show()
```

2. Load JSON data:
```scala
val jsonDF = sqlContext.read
  .format("json")
  .load("data/profiles.json")

jsonDF.printSchema()
jsonDF.show()
```

3. Load Parquet data:
```scala
val parquetDF = sqlContext.read
  .format("parquet")
  .load("data/studentParquet")

parquetDF.printSchema()
parquetDF.show()
```

### Exercise 3.1
Load the iris dataset and:
- Display its schema
- Show the first 5 rows
- Count the total number of rows

### Step 2: Handle Missing Values

1. Check for missing values:
```scala
import org.apache.spark.sql.functions.{col, count, when, isnan}

// Count nulls in each column
val nullCounts = df.columns.map { c =>
  count(when(col(c).isNull, c)).alias(c)
}

df.select(nullCounts: _*).show()
```

2. Drop rows with missing values:
```scala
val cleanedDF = df.na.drop()
cleanedDF.show()
```

3. Fill missing values:
```scala
val filledDF = df.na.fill(0, Array("age", "score"))
filledDF.show()
```

### Exercise 3.2
Using the StudentData DataFrame:
- Identify columns with missing values
- Drop rows with missing critical fields
- Fill missing numeric values with mean
- Fill missing categorical values with mode

### Step 3: Data Transformation

1. Filter data:
```scala
val filteredDF = df.filter($"age" >= 18 && $"score" >= 60)
filteredDF.show()
```

2. Create derived columns:
```scala
val transformedDF = df.withColumn("age_squared", $"age" * $"age")
  .withColumn("score_category", 
    when($"score" >= 90, "A")
    .when($"score" >= 80, "B")
    .when($"score" >= 70, "C")
    .otherwise("D"))

transformedDF.show()
```

3. Rename columns:
```scala
val renamedDF = df.withColumnRenamed("age", "student_age")
  .withColumnRenamed("score", "exam_score")
renamedDF.show()
```

### Exercise 3.3
Transform the iris dataset:
- Create a column for sepal area (sepal length * sepal width)
- Create a column for petal area (petal length * petal width)
- Categorize iris species by numeric codes
- Filter to only include setosa and versicolor

### Step 4: Data Aggregation

1. Group by and aggregate:
```scala
val aggregatedDF = df.groupBy("category")
  .agg(
    avg("score").alias("average_score"),
    max("score").alias("max_score"),
    min("score").alias("min_score"),
    count("*").alias("count")
  )

aggregatedDF.show()
```

2. Window functions:
```scala
import org.apache.spark.sql.expressions.Window
import org.apache.spark.sql.functions.{row_number, rank}

val windowSpec = Window.partitionBy("category").orderBy($"score".desc)

val rankedDF = df.withColumn("rank", rank().over(windowSpec))
  .withColumn("row_num", row_number().over(windowSpec))

rankedDF.show()
```

### Exercise 3.4
Using the StudentData DataFrame:
- Calculate average score by age group
- Find the top 3 students in each category
- Calculate score percentiles
- Count students by grade category

### Step 5: Data Export

1. Save to CSV:
```scala
df.write
  .format("csv")
  .option("header", "true")
  .mode("overwrite")
  .save("output/cleaned_data.csv")
```

2. Save to Parquet:
```scala
df.write
  .format("parquet")
  .mode("overwrite")
  .save("output/cleaned_data.parquet")
```

3. Save to JSON:
```scala
df.write
  .format("json")
  .mode("overwrite")
  .save("output/cleaned_data.json")
```

### Exercise 3.5
Save your cleaned and transformed dataset:
- Save in CSV format with headers
- Save in Parquet format for optimized storage
- Save in JSON format for web compatibility

## Expected Results

After completing this lab, you should:
- Be comfortable loading data from various sources
- Know how to handle missing values
- Understand data transformation techniques
- Be able to aggregate and summarize data
- Know how to export processed data

## Troubleshooting

### Issue: Schema inference errors
**Solution**: Provide explicit schema when loading data:
```scala
import org.apache.spark.sql.types._

val schema = StructType(Array(
  StructField("id", IntegerType, true),
  StructField("name", StringType, true),
  StructField("age", IntegerType, true)
))

val df = sqlContext.read.schema(schema).format("csv").load("data.csv")
```

### Issue: Memory issues with large datasets
**Solution**: Use partitioning and caching:
```scala
df.repartition(100).cache()
```

## Next Steps

After completing this lab, you can proceed to:
- Lab 4: Data Visualization
- Learn about advanced data processing techniques
- Explore Spark SQL for complex queries

## Additional Resources

- [Spark Data Sources Guide](https://spark.apache.org/docs/latest/sql-data-sources.html)
- [Spark DataFrame API](https://spark.apache.org/docs/latest/api/scala/index.html#org.apache.spark.sql.DataFrame)