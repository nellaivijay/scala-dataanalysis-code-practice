# Lab 7: Going Further - Streaming from Twitter, Kafka, Streaming Logistic Regression and Twitter Sentiment Analysis using GraphX

## Overview

Real-time data processing and graph analysis represent the cutting edge of modern data engineering. This lab introduces Spark Streaming for real-time data processing, Apache Kafka for distributed messaging, and GraphX for graph computation. You'll learn to build real-time analytics pipelines, process streaming data, apply machine learning to data streams, and analyze graph-structured data like social networks.

**What makes this lab important**: Real-time data processing has become essential for applications requiring immediate insights and actions. Social networks, IoT devices, financial markets, and user activity streams all generate data that must be processed in real-time. Understanding streaming architecture and graph processing prepares you for the most advanced data engineering challenges.

**Real-world applications**: Real-time fraud detection, social media sentiment analysis, IoT sensor monitoring, real-time recommendation updates, network analysis, social graph mining, and any application where immediate data processing provides competitive advantage. These skills are at the forefront of modern data engineering.

## Learning Objectives

By the end of this lab, you will be able to:
- Set up Spark Streaming for real-time data processing
- Integrate with Apache Kafka for message streaming
- Implement streaming machine learning with logistic regression
- Use GraphX for graph processing and analysis
- Perform real-time sentiment analysis on Twitter data
- Understand streaming architecture and patterns

## Prerequisites

- Completed Lab 6: Scaling Up
- Apache Kafka installed and running
- Twitter API credentials (for Twitter streaming)
- Understanding of streaming concepts

## Estimated Time

120-150 minutes

## Conceptual Background

This lab covers advanced Spark capabilities:

- **Spark Streaming**: Real-time data processing with micro-batches
- **Kafka Integration**: Streaming data from Kafka topics
- **Streaming MLlib**: Machine learning on streaming data
- **GraphX**: Graph processing and analysis
- **Real-time Analytics**: Processing and analyzing data in motion

## Lab Steps

### Step 1: Spark Streaming Basics

1. Create a streaming context:
```scala
import org.apache.spark._
import org.apache.spark.streaming._
import org.apache.spark.streaming.StreamingContext._

val conf = new SparkConf().setAppName("StreamingExample")
val ssc = new StreamingContext(conf, Seconds(1)) // 1-second batches
```

2. Create a DStream from socket:
```scala
val lines = ssc.socketTextStream("localhost", 9999)
```

3. Process the stream:
```scala
val words = lines.flatMap(_.split(" "))
val wordCounts = words.map(x => (x, 1)).reduceByKey(_ + _)
wordCounts.print()
```

4. Start the streaming context:
```scala
ssc.start()
ssc.awaitTermination()
```

### Exercise 7.1
Create a basic streaming application:
- Set up a streaming context with 5-second batches
- Create a socket text stream
- Count words in the stream
- Display results in real-time

### Step 2: Kafka Integration

1. Add Kafka dependencies:
```scala
libraryDependencies += "org.apache.spark" %% "spark-streaming-kafka" % "1.6.0"
```

2. Create Kafka DStream:
```scala
import org.apache.spark.streaming.kafka._

val kafkaParams = Map(
  "metadata.broker.list" -> "localhost:9092"
)

val topics = "my-topic".split(",").toSet
val kafkaStream = KafkaUtils.createDirectStream[
  String, String, StringDecoder, StringDecoder
](ssc, kafkaParams, topics)
```

3. Process Kafka messages:
```scala
val messages = kafkaStream.map(_._2)
val processedMessages = messages.flatMap(_.split(","))
  .map(word => (word, 1))
  .reduceByKey(_ + _)

processedMessages.print()
```

### Exercise 7.2
Integrate with Kafka:
- Create a Kafka topic
- Produce messages to the topic
- Consume messages with Spark Streaming
- Process and analyze the stream

### Step 3: Streaming Logistic Regression

1. Prepare streaming data:
```scala
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.classification.StreamingLogisticRegressionWithSGD

// Create streaming labeled points
val trainingStream = kafkaStream.map { case (key, value) =>
  val parts = value.split(",")
  LabeledPoint(
    parts(0).toDouble,
    Vectors.dense(parts.slice(1, parts.length).map(_.toDouble))
  )
}
```

2. Train streaming logistic regression:
```scala
val numFeatures = 10
val model = new StreamingLogisticRegressionWithSGD()
  .setStepSize(0.01)
  .setNumIterations(50)
  .setInitialWeights(Vectors.zeros(numFeatures))

model.trainOn(trainingStream)
```

3. Predict on streaming data:
```scala
val testStream = kafkaStream.map { case (key, value) =>
  val parts = value.split(",")
  Vectors.dense(parts.slice(1, parts.length).map(_.toDouble))
}

val predictions = model.predictOn(testStream)
predictions.print()
```

### Exercise 7.3
Implement streaming classification:
- Create a streaming classification problem
- Train a logistic regression model on streaming data
- Make predictions on new streaming data
- Evaluate model performance over time

### Step 4: Twitter Streaming

1. Set up Twitter authentication:
```scala
import org.apache.spark.streaming.twitter._

System.setProperty("twitter4j.oauth.consumerKey", "your_consumer_key")
System.setProperty("twitter4j.oauth.consumerSecret", "your_consumer_secret")
System.setProperty("twitter4j.oauth.accessToken", "your_access_token")
System.setProperty("twitter4j.oauth.accessTokenSecret", "your_access_token_secret")
```

2. Create Twitter stream:
```scala
val filters = Seq("#scala", "#spark", "#bigdata")
val tweetStream = TwitterUtils.createStream(ssc, None, filters)
```

3. Process tweets:
```scala
val tweetText = tweetStream.map(_.getText())
val hashtags = tweetText.flatMap(_.split(" "))
  .filter(_.startsWith("#"))
  .map(word => (word, 1))
  .reduceByKey(_ + _)

hashtags.print()
```

### Exercise 7.4
Create a Twitter streaming application:
- Filter tweets by specific hashtags
- Extract and count hashtags
- Identify trending topics
- Display real-time statistics

### Step 5: GraphX Basics

1. Create a graph:
```scala
import org.apache.spark.graphx._
import org.apache.spark.rdd._

// Create vertices
val vertices: RDD[(Long, String)] = sc.parallelize(Array(
  (1L, "Alice"),
  (2L, "Bob"),
  (3L, "Charlie"),
  (4L, "David")
))

// Create edges
val edges: RDD[Edge[String]] = sc.parallelize(Array(
  Edge(1L, 2L, "friend"),
  Edge(2L, 3L, "friend"),
  Edge(3L, 4L, "friend"),
  Edge(1L, 3L, "colleague")
))

// Create graph
val graph = Graph(vertices, edges)
```

2. Perform graph operations:
```scala
// Count vertices and edges
println(s"Vertices: ${graph.vertices.count()}")
println(s"Edges: ${graph.edges.count()}")

// Get degrees
val degrees = graph.degrees
degrees.collect().foreach(println)
```

3. PageRank algorithm:
```scala
val ranks = graph.pageRank(10).vertices
ranks.collect().foreach { case (id, rank) =>
  println(s"Vertex $id has rank $rank")
}
```

### Exercise 7.5
Create a social network graph:
- Define users and relationships
- Build the graph
- Calculate PageRank
- Find connected components
- Identify communities

### Step 6: Twitter Sentiment Analysis with GraphX

1. Parse Twitter data:
```scala
case class Tweet(user: Long, text: String, mentions: Array[Long])

val tweets = sc.textFile("data/tweets.csv")
  .map(line => line.split(","))
  .map(parts => Tweet(
    parts(0).toLong,
    parts(1),
    parts.slice(2, parts.length).map(_.toLong)
  ))
```

2. Create mention graph:
```scala
val mentionEdges = tweets.flatMap { tweet =>
  tweet.mentions.map(mention => Edge(tweet.user, mention, "mentions"))
}

val users = tweets.map(tweet => (tweet.user, tweet.user))
val mentionGraph = Graph(users, mentionEdges)
```

3. Analyze influence:
```scala
val influenceRanks = mentionGraph.pageRank(20).vertices
val topInfluential = influenceRanks.top(10)(Ordering.by(_._2))
topInfluential.foreach(println)
```

4. Find communities:
```scala
val communities = mentionGraph.connectedComponents().vertices
communities.collect().foreach(println)
```

### Exercise 7.6
Build a Twitter analysis pipeline:
- Create a mention graph from Twitter data
- Calculate influence metrics
- Identify user communities
- Analyze sentiment patterns across communities

### Step 7: Combining Streaming and GraphX

1. Streaming graph updates:
```scala
val streamingEdges = kafkaStream.map { case (key, value) =>
  val parts = value.split(",")
  Edge(parts(0).toLong, parts(1).toLong, parts(2))
}

val graphStream = streamingEdges.updateStateByKey { (edges, state) =>
  val newEdges = edges.getOrElse(Seq.empty)
  Some(newEdges)
}
```

2. Real-time graph analytics:
```scala
graphStream.foreachRDD { rdd =>
  if (!rdd.isEmpty()) {
    val graph = Graph(sc.parallelize(Seq.empty[(Long, Long)]), rdd)
    val ranks = graph.pageRank(5).vertices
    ranks.take(5).foreach(println)
  }
}
```

### Exercise 7.7
Create a real-time graph analytics application:
- Stream edge updates from Kafka
- Maintain a dynamic graph
- Calculate real-time PageRank
- Detect communities in real-time

## Expected Results

After completing this lab, you should:
- Understand Spark Streaming architecture
- Be able to integrate with Kafka
- Know how to implement streaming ML
- Understand GraphX for graph processing
- Be able to build real-time analytics applications

## Troubleshooting

### Issue: Streaming context already started
**Solution**: Ensure you stop any existing streaming context before creating a new one:
```scala
ssc.stop(stopSparkContext = false)
```

### Issue: Kafka connection errors
**Solution**: 
- Verify Kafka is running
- Check broker configuration
- Ensure topic exists

### Issue: Twitter API rate limits
**Solution**: 
- Use appropriate filters
- Implement rate limiting
- Consider using Twitter's firehose API

## Next Steps

After completing this lab, you have completed all the chapters! You can:
- Explore advanced Spark topics (Structured Streaming, GraphX algorithms)
- Build production-grade applications
- Contribute to the Spark community
- Explore other big data technologies

## Additional Resources

- [Spark Streaming Programming Guide](https://spark.apache.org/docs/latest/streaming-programming-guide.html)
- [Spark Streaming + Kafka Integration](https://spark.apache.org/docs/latest/streaming-kafka-integration.html)
- [GraphX Programming Guide](https://spark.apache.org/docs/latest/graphx-programming-guide.html)
- [Twitter4J Documentation](http://twitter4j.org/en/index.html)