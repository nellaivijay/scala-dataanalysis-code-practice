# Lab 6: Scaling Up - Deploying Spark on Standalone Cluster, EC2, Mesos and YARN

## Overview

Moving from development to production requires understanding cluster deployment and resource management. This lab covers the practical aspects of deploying Spark applications in production environments across different cluster managers: standalone clusters, AWS EC2, Apache Mesos, and Hadoop YARN. You'll learn to optimize performance, manage resources, and ensure your applications can handle real-world workloads.

**What makes this lab important**: Development environments differ significantly from production. Understanding cluster deployment, resource allocation, and performance optimization is what makes data engineers valuable in production environments. This lab bridges the gap between writing Spark code and running it reliably at scale in production systems.

**Real-world applications**: Production data pipeline deployment, big data processing in enterprise environments, cloud-based data engineering, cost optimization through efficient resource utilization, and ensuring high availability and performance for data applications. These skills are essential for senior data engineering roles.

## Learning Objectives

By the end of this lab, you will be able to:
- Set up a Spark standalone cluster
- Deploy Spark on AWS EC2
- Configure Spark on Apache Mesos
- Integrate Spark with Hadoop YARN
- Understand cluster resource management
- Optimize Spark applications for production

## Prerequisites

- Completed Lab 5: Machine Learning with MLlib
- Access to cloud resources (for EC2 deployment)
- Understanding of cluster computing concepts
- Basic system administration knowledge

## Estimated Time

90-120 minutes

## Conceptual Background

Spark can be deployed in various cluster managers:

- **Standalone Cluster**: Simple cluster manager included with Spark
- **Apache Mesos**: General-purpose cluster manager
- **Hadoop YARN**: Resource manager for Hadoop clusters
- **Kubernetes**: Container orchestration platform
- **AWS EC2**: Cloud-based deployment using Spark EC2 scripts

## Lab Steps

### Step 1: Spark Standalone Cluster Setup

1. Download and install Spark:
```bash
wget http://www.apache.org/dyn/closer.cgi/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz
tar -xzf spark-1.6.0-bin-hadoop2.6.tgz
cd spark-1.6.0-bin-hadoop2.6
```

2. Configure Spark master:
```bash
# Edit conf/spark-env.sh
export SPARK_MASTER_HOST=your_master_hostname
export SPARK_MASTER_PORT=7077
export SPARK_MASTER_WEBUI_PORT=8080
```

3. Start Spark master:
```bash
./sbin/start-master.sh
```

4. Start Spark workers:
```bash
./sbin/start-slave.sh spark://your_master_hostname:7077
```

5. Access Spark UI:
```
http://your_master_hostname:8080
```

### Exercise 6.1
Set up a local standalone cluster:
- Start a master process
- Start 2 worker processes
- Submit a simple job to the cluster
- Monitor the job through the Spark UI

### Step 2: Submitting Jobs to Standalone Cluster

1. Submit a Spark application:
```bash
./bin/spark-submit \
  --class com.example.YourApp \
  --master spark://your_master_hostname:7077 \
  --deploy-mode cluster \
  --executor-memory 2G \
  --total-executor-cores 4 \
  /path/to/your/app.jar
```

2. Submit with client mode:
```bash
./bin/spark-submit \
  --class com.example.YourApp \
  --master spark://your_master_hostname:7077 \
  --deploy-mode client \
  /path/to/your/app.jar
```

3. Monitor running applications:
```bash
# Check status through UI or command line
./bin/spark-submit --status <application_id>
```

### Exercise 6.2
Submit a machine learning job to the cluster:
- Package your MLlib application
- Submit with appropriate resource allocation
- Monitor execution through the UI
- Analyze performance metrics

### Step 3: Spark on AWS EC2

1. Set up AWS credentials:
```bash
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
```

2. Launch Spark cluster on EC2:
```bash
./ec2/spark-ec2 \
  --key-pair=my_key \
  --identity-file=my_key.pem \
  --region=us-west-2 \
  --zone=us-west-2a \
  --instance-type=m3.xlarge \
  --spot-price=0.15 \
  launch my_spark_cluster
```

3. Login to the master:
```bash
./ec2/spark-ec2 \
  --key-pair=my_key \
  --identity-file=my_key.pem \
  --region=us-west-2 \
  login my_spark_cluster
```

4. Submit jobs to EC2 cluster:
```bash
./bin/spark-submit \
  --master spark://ec2-xx-xx-xx-xx.compute-1.amazonaws.com:7077 \
  --deploy-mode cluster \
  your_app.jar
```

### Exercise 6.3
Deploy a simple Spark cluster on EC2:
- Launch a 2-node cluster
- Submit a test job
- Monitor cluster performance
- Terminate the cluster when done

### Step 4: Spark on Apache Mesos

1. Install Mesos:
```bash
# On Ubuntu/Debian
sudo apt-get install mesos

# Or download from Apache Mesos
wget http://www.apache.org/dyn/closer.cgi/mesos/mesos-1.0.0
```

2. Configure Spark for Mesos:
```bash
# Edit conf/spark-env.sh
export MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so
```

3. Start Mesos master:
```bash
mesos-master --ip=127.0.0.1 --work_dir=/var/lib/mesos
```

4. Start Mesos slave:
```bash
mesos-slave --master=127.0.0.1:5050 --work_dir=/var/lib/mesos
```

5. Submit Spark job to Mesos:
```bash
./bin/spark-submit \
  --master mesos://127.0.0.1:5050 \
  --deploy-mode cluster \
  your_app.jar
```

### Exercise 6.4
Configure Spark on Mesos:
- Set up a local Mesos cluster
- Configure Spark to use Mesos
- Submit a test application
- Monitor resource allocation

### Step 5: Spark on Hadoop YARN

1. Configure Spark for YARN:
```bash
# Edit conf/spark-env.sh
export HADOOP_CONF_DIR=/path/to/hadoop/conf
```

2. Submit Spark job to YARN:
```bash
# Cluster mode
./bin/spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --executor-memory 2G \
  --num-executors 4 \
  your_app.jar

# Client mode
./bin/spark-submit \
  --master yarn \
  --deploy-mode client \
  your_app.jar
```

3. Monitor YARN applications:
```bash
yarn application -list
yarn application -status <application_id>
```

### Exercise 6.5
Deploy Spark on YARN:
- Configure Spark for YARN
- Submit a job in cluster mode
- Submit a job in client mode
- Compare performance and resource usage

### Step 6: Performance Optimization

1. Memory tuning:
```bash
# In spark-submit
--executor-memory 4G
--driver-memory 2G
--executor-cores 2
```

2. Parallelism tuning:
```scala
// In Spark application
val conf = new SparkConf()
  .set("spark.default.parallelism", "100")
  .set("spark.sql.shuffle.partitions", "100")
```

3. Data serialization:
```scala
// Use Kryo serialization
conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
conf.registerKryoClasses(Array(classOf[MyClass]))
```

4. RDD persistence:
```scala
// Cache frequently used RDDs
rdd.persist(StorageLevel.MEMORY_AND_DISK_SER)
```

### Exercise 6.6
Optimize a Spark application:
- Profile the application
- Tune memory settings
- Adjust parallelism
- Implement caching strategies
- Measure performance improvements

## Expected Results

After completing this lab, you should:
- Understand different Spark deployment modes
- Be able to set up Spark on various cluster managers
- Know how to submit and monitor jobs
- Understand resource allocation and tuning
- Be able to optimize Spark applications for production

## Troubleshooting

### Issue: Workers not connecting to master
**Solution**: 
- Check network connectivity
- Verify firewall settings
- Ensure correct master hostname/URL

### Issue: Out of memory errors
**Solution**:
- Increase executor memory
- Reduce data size per partition
- Use appropriate serialization

### Issue: Slow job execution
**Solution**:
- Increase parallelism
- Use appropriate caching
- Optimize data skew
- Tune garbage collection

## Next Steps

After completing this lab, you can proceed to:
- Lab 7: Going Further - Streaming and Graph Processing
- Learn about Spark monitoring and debugging
- Explore production deployment best practices

## Additional Resources

- [Spark Cluster Overview](https://spark.apache.org/docs/latest/cluster-overview.html)
- [Spark on EC2](https://spark.apache.org/docs/latest/ec2.html)
- [Spark on Mesos](https://spark.apache.org/docs/latest/running-on-mesos.html)
- [Spark on YARN](https://spark.apache.org/docs/latest/running-on-yarn.html)