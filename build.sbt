organization := "com.scalaanalysis"

name := "scala-dataanalysis-code-practice"

description := "Comprehensive Scala data analysis learning environment with hands-on labs for Breeze numerical computing, Apache Spark data processing, MLlib machine learning, Spark Streaming real-time processing, and GraphX graph processing. Features 7 progressive chapters with 50+ exercises covering vectors, matrices, DataFrames, data visualization, clustering, classification, regression, dimensionality reduction, cluster deployment, and real-time analytics."

version := "1.0.0"

scalaVersion := "2.10.4"

libraryDependencies ++= Seq(
  // Breeze for numerical computing
  "org.scalanlp" %% "breeze" % "0.13",
  
  // Apache Spark core
  "org.apache.spark" %% "spark-core" % "1.6.0",
  
  // Spark SQL
  "org.apache.spark" %% "spark-sql" % "1.6.0",
  
  // Spark MLlib for machine learning
  "org.apache.spark" %% "spark-mllib" % "1.6.0",
  
  // Spark Streaming
  "org.apache.spark" %% "spark-streaming" % "1.6.0",
  
  // Spark Streaming Kafka integration
  "org.apache.spark" %% "spark-streaming-kafka" % "1.6.0",
  
  // Spark GraphX
  "org.apache.spark" %% "spark-graphx" % "1.6.0",
  
  // Twitter4J for Twitter streaming
  "org.twitter4j" % "twitter4j-core" % "4.0.2",
  
  // JSON processing
  "org.json4s" %% "json4s-jackson" % "3.2.11",
  
  // Logging
  "org.slf4j" % "slf4j-api" % "1.7.21",
  "ch.qos.logback" % "logback-classic" % "1.1.7"
)

// Resolvers
resolvers ++= Seq(
  "Apache Releases" at "https://repository.apache.org/content/repositories/releases/",
  "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases/",
  "Scala Tools Maven2 Repository" at "http://scala-tools.org/repo-releases"
)

// Compiler options
scalacOptions ++= Seq(
  "-deprecation",
  "-unchecked",
  "-feature",
  "-Xlint"
)

// Java options
javaOptions ++= Seq(
  "-Xmx2G",
  "-Xms512M"
)

// Fork to run tests in a separate JVM
fork in Test := true

// Parallel execution of tests
parallelExecution in Test := false

// Assembly settings for creating fat JARs
assemblyMergeStrategy in assembly := {
  case PathList("META-INF", xs @ _*) => MergeStrategy.discard
  case x => MergeStrategy.first
}