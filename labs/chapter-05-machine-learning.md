# Lab 5: Learning from Data - Spark MLlib (Linear Regression, Classification, Clustering and PCA)

## Overview

Machine learning is where data analysis meets prediction and automation. This lab introduces Spark MLlib, Apache Spark's scalable machine learning library. You'll learn to build, train, and evaluate machine learning models including linear regression, classification, clustering, and dimensionality reduction. These skills enable you to extract predictive insights from data and automate decision-making processes.

**What makes this lab important**: Machine learning has become essential across industries for predictive analytics, recommendation systems, fraud detection, and countless other applications. Understanding MLlib's approach to machine learning in a distributed context prepares you for real-world ML engineering challenges where data volume and complexity require scalable solutions.

**Real-world applications**: Predictive maintenance in manufacturing, fraud detection in finance, recommendation systems in e-commerce, customer churn prediction, spam filtering, image classification, and any scenario where historical data can be used to predict future outcomes or automate decision-making.

## Learning Objectives

By the end of this lab, you will be able to:
- Understand MLlib's data structures (Vectors, LabeledPoints)
- Build and evaluate linear regression models
- Implement classification algorithms
- Perform clustering with K-Means
- Apply dimensionality reduction with PCA

## Prerequisites

- Completed Lab 4: Data Visualization
- Apache Spark 1.6.0 with MLlib
- Understanding of basic machine learning concepts

## Estimated Time

90-120 minutes

## Conceptual Background

Spark MLlib is Spark's scalable machine learning library. It provides:

- **Linear Algebra**: Vectors, matrices, and distributed linear algebra
- **Statistics**: Summary statistics, correlations, sampling
- **Regression**: Linear regression, generalized linear models
- **Classification**: Logistic regression, decision trees, naive Bayes
- **Clustering**: K-Means, Gaussian mixture
- **Dimensionality Reduction**: PCA, SVD

## Lab Steps

### Step 1: MLlib Data Structures

1. Create MLlib vectors:
```scala
import org.apache.spark.mllib.linalg.{Vector, Vectors}
import org.apache.spark.mllib.regression.LabeledPoint

// Dense vector
val denseVec = Vectors.dense(1.0, 2.0, 3.0, 4.0)

// Sparse vector
val sparseVec = Vectors.sparse(4, Array(0, 2), Array(1.0, 3.0))

// Labeled point for supervised learning
val labeledPoint = LabeledPoint(1.0, Vectors.dense(2.0, 3.0, 4.0))
```

2. Load data as LabeledPoints:
```scala
val data = sc.textFile("data/student-mat.csv")
  .map(line => line.split(","))
  .map(parts => LabeledPoint(
    parts(0).toDouble, // label
    Vectors.dense(parts.slice(1, parts.length).map(_.toDouble)) // features
  ))
```

### Exercise 5.1
Convert the iris dataset to MLlib format:
- Use species as the label (convert to numeric)
- Use sepal and petal measurements as features
- Create both dense and sparse representations

### Step 2: Linear Regression

1. Prepare data:
```scala
import org.apache.spark.mllib.regression.LinearRegressionWithSGD
import org.apache.spark.mllib.evaluation.RegressionMetrics

// Load and parse data
val data = sc.textFile("data/regression_data.txt")
  .map(line => line.split(","))
  .map(parts => LabeledPoint(
    parts(0).toDouble,
    Vectors.dense(parts.slice(1, parts.length).map(_.toDouble))
  ))

// Split data into training and test
val splits = data.randomSplit(Array(0.7, 0.3))
val training = splits(0)
val test = splits(1)
```

2. Train linear regression model:
```scala
val numIterations = 100
val stepSize = 0.01
val model = LinearRegressionWithSGD.train(training, numIterations, stepSize)
```

3. Evaluate the model:
```scala
val predictionsAndLabels = test.map { point =>
  val prediction = model.predict(point.features)
  (prediction, point.label)
}

val metrics = new RegressionMetrics(predictionsAndLabels)
println(s"RMSE = ${metrics.rootMeanSquaredError}")
println(s"R-squared = ${metrics.r2}")
```

### Exercise 5.2
Using the StudentData dataset:
- Predict student scores based on age and study time
- Train a linear regression model
- Evaluate using RMSE and R-squared
- Analyze feature importance

### Step 3: Classification with Logistic Regression

1. Prepare classification data:
```scala
import org.apache.spark.mllib.classification.{LogisticRegressionWithSGD, LogisticRegressionModel}
import org.apache.spark.mllib.evaluation.MulticlassMetrics

// Load binary classification data
val data = sc.textFile("data/classification_data.txt")
  .map(line => line.split(","))
  .map(parts => LabeledPoint(
    parts(0).toDouble,
    Vectors.dense(parts.slice(1, parts.length).map(_.toDouble))
  ))

val splits = data.randomSplit(Array(0.7, 0.3))
val training = splits(0)
val test = splits(1)
```

2. Train logistic regression:
```scala
val model = LogisticRegressionWithSGD.train(training, numIterations = 100)
```

3. Evaluate classification:
```scala
val predictionAndLabels = test.map { point =>
  val prediction = model.predict(point.features)
  (prediction, point.label)
}

val metrics = new MulticlassMetrics(predictionAndLabels)
println(s"Accuracy = ${metrics.accuracy}")
println(s"Precision = ${metrics.precision}")
println(s"Recall = ${metrics.recall}")
println(s"Confusion Matrix:\n${metrics.confusionMatrix}")
```

### Exercise 5.3
Using the iris dataset:
- Train a logistic regression model to classify species
- Use binary classification (setosa vs non-setosa)
- Evaluate accuracy, precision, and recall
- Analyze the confusion matrix

### Step 4: Clustering with K-Means

1. Prepare clustering data:
```scala
import org.apache.spark.mllib.clustering.{KMeans, KMeansModel}
import org.apache.spark.mllib.linalg.Vectors

// Load data
val data = sc.textFile("data/clustering_data.txt")
  .map(line => Vectors.dense(line.split(",").map(_.toDouble)))

// Cache data for performance
data.cache()
```

2. Train K-Means model:
```scala
val numClusters = 3
val numIterations = 20
val model = KMeans.train(data, numClusters, numIterations)
```

3. Evaluate clustering:
```scala
val wsse = model.computeCost(data)
println(s"Within Set Sum of Squares = $wsse")

// Show cluster centers
println("Cluster centers:")
model.clusterCenters.foreach(println)
```

4. Assign clusters to data points:
```scala
val clusteredData = data.map { point =>
  val cluster = model.predict(point)
  (cluster, point)
}

clusteredData.take(10).foreach(println)
```

### Exercise 5.4
Using the iris dataset:
- Perform K-Means clustering (k=3)
- Compare clusters to actual species
- Calculate clustering accuracy
- Visualize the clusters

### Step 5: Dimensionality Reduction with PCA

1. Prepare data for PCA:
```scala
import org.apache.spark.mllib.feature.PCA
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.regression.LabeledPoint

// Load data
val data = sc.textFile("data/iris.data")
  .map(line => line.split(","))
  .map(parts => Vectors.dense(parts.slice(0, 4).map(_.toDouble)))

data.cache()
```

2. Apply PCA:
```scala
val pca = new PCA(2) // Reduce to 2 dimensions
val pcaModel = pca.fit(data)

val transformedData = data.map(pcaModel.transform)
transformedData.take(5).foreach(println)
```

3. Evaluate variance explained:
```scala
val explainedVariance = pcaModel.explainedVariance
println(s"Explained variance: ${explainedVariance.toArray.mkString(", ")}")
```

### Exercise 5.5
Using the iris dataset:
- Apply PCA to reduce from 4 to 2 dimensions
- Calculate explained variance
- Visualize the transformed data
- Compare classification performance with and without PCA

## Expected Results

After completing this lab, you should:
- Understand MLlib's core data structures
- Be able to build and evaluate regression models
- Know how to implement classification algorithms
- Understand clustering with K-Means
- Be able to apply dimensionality reduction techniques

## Troubleshooting

### Issue: Model convergence issues
**Solution**: Adjust hyperparameters:
- Increase number of iterations
- Adjust step size (learning rate)
- Normalize features before training

### Issue: Poor model performance
**Solution**: 
- Feature engineering and selection
- Try different algorithms
- Increase training data size
- Cross-validation for hyperparameter tuning

### Issue: Out of memory errors
**Solution**: 
- Reduce data size or use sampling
- Increase executor memory
- Use appropriate caching strategies

## Next Steps

After completing this lab, you can proceed to:
- Lab 6: Scaling Up - Deploying Spark on clusters
- Explore advanced MLlib algorithms
- Learn about model persistence and deployment

## Additional Resources

- [Spark MLlib Guide](https://spark.apache.org/docs/latest/mllib-guide.html)
- [Machine Learning with Spark](https://github.com/databricks/spark-mllib-book)
- [MLlib API Documentation](https://spark.apache.org/docs/latest/api/scala/index.html#org.apache.spark.mllib.package)