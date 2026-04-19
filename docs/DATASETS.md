# Scala Data Analysis Code Practice - Dataset Documentation

## Overview

This document provides comprehensive information about the sample datasets available in this repository for hands-on learning. Datasets are essential for practicing data analysis techniques, and this guide explains their structure, usage, and the types of analyses they support.

**Why these datasets matter**: Real-world datasets help bridge the gap between theoretical knowledge and practical application. Each dataset has been selected to demonstrate specific data analysis techniques, from basic data manipulation to advanced machine learning. Understanding dataset structure and characteristics is fundamental to effective data analysis.

**Dataset variety**: The repository includes datasets from different domains (education, finance, biology, automotive) to provide diverse learning experiences. This variety helps you apply techniques to different types of data and understand how to adapt your approach based on data characteristics.

## Available Datasets

### Student Data (`StudentData.csv`)

**Description**: Educational performance data for students

**Schema**:
- `id`: Student identifier (integer)
- `name`: Student name (string)
- `age`: Student age (integer)
- `grade_level`: Grade level (9-12) (integer)
- `gpa`: Grade point average (float, 2.0-4.0)
- `study_hours`: Weekly study hours (float, 1.0-10.0)
- `attendance`: Attendance rate (float, 0.5-1.0)
- `score`: Exam score (float, 50-100)

**Usage Examples**:
- Regression analysis (predicting scores)
- Classification (pass/fail prediction)
- Data visualization
- Statistical analysis

**Sample Size**: 1000 records

### Iris Dataset (`iris.data`)

**Description**: Classic machine learning dataset with iris flower measurements

**Schema**:
- `sepal_length`: Sepal length in cm (float)
- `sepal_width`: Sepal width in cm (float)
- `petal_length`: Petal length in cm (float)
- `petal_width`: Petal width in cm (float)
- `species`: Iris species (string: setosa, versicolor, virginica)

**Usage Examples**:
- Classification (species prediction)
- Clustering
- Dimensionality reduction (PCA)
- Data visualization

**Sample Size**: 150 records (50 per species)

### Dow Jones Index (`dow_jones_index.data`)

**Description**: Financial time series data for Dow Jones Index

**Schema**:
- Date information
- Stock prices
- Trading volume
- Various financial indicators

**Usage Examples**:
- Time series analysis
- Financial data processing
- Trend analysis
- Predictive modeling

### MT Cars (`mtcars.csv`)

**Description**: Automobile performance data

**Schema**:
- Car attributes (mpg, cyl, disp, hp, etc.)
- Performance metrics
- Technical specifications

**Usage Examples**:
- Regression analysis
- Feature engineering
- Data visualization
- Statistical analysis

## Generating Additional Sample Data

You can generate additional sample datasets using the provided script:

```bash
python3 scripts/generate_sample_data.py
```

This will create:
- `data/sample/students.csv` - Student performance data
- `data/sample/iris.csv` - Iris flower measurements
- `data/sample/regression.csv` - Regression dataset

## Data Loading Examples

### Loading CSV in Spark
```scala
val df = sqlContext.read
  .format("csv")
  .option("header", "true")
  .option("inferSchema", "true")
  .load("data/StudentData.csv")
```

### Loading CSV in Breeze/Scala
```scala
import scala.io.Source

val data = Source.fromFile("data/iris.data").getLines().map { line =>
  val parts = line.split(",")
  // Process data
}.toArray
```

## Data Quality Notes

- All datasets are for educational purposes only
- Some datasets may contain synthetic or modified data
- Always validate data quality before analysis
- Check for missing values and outliers
- Understand data provenance before use

## Additional Resources

- [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/) - Source of many datasets
- [Kaggle Datasets](https://www.kaggle.com/datasets) - Additional datasets for practice
- [Data.gov](https://www.data.gov/) - Government open data