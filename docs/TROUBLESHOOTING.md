# Troubleshooting Guide for Scala Data Analysis Code Practice

## Overview

This comprehensive troubleshooting guide addresses common issues you may encounter while working with the Scala Data Analysis Code Practice labs. Development environments can be complex, and issues are inevitable - this guide provides systematic approaches to diagnose and resolve problems efficiently.

**What this guide covers**: Common installation issues, compilation errors, runtime exceptions, performance problems, Docker container issues, and Spark-specific challenges. Each issue includes systematic diagnosis steps, multiple solution approaches, and preventive measures to avoid recurrence.

**How to use this guide**: Start with the category that matches your issue, try the solutions in order, and follow the diagnostic steps to identify the root cause. If you don't find your issue here, check the community resources listed at the end of the guide.

## Common Issues and Solutions

### Java/Scala/SBT Issues

#### Issue: "java: command not found"
**Solution**: 
- Ensure Java is installed: `java -version`
- Set JAVA_HOME environment variable:
  ```bash
  export JAVA_HOME=/path/to/jdk
  export PATH=$PATH:$JAVA_HOME/bin
  ```

#### Issue: "scala: command not found"
**Solution**:
- Ensure Scala is installed: `scala -version`
- Add Scala to PATH:
  ```bash
  export PATH=$PATH:/path/to/scala/bin
  ```

#### Issue: "sbt: command not found"
**Solution**:
- Ensure SBT is installed: `sbt --version`
- Add SBT to PATH:
  ```bash
  export PATH=$PATH:/path/to/sbt/bin
  ```

#### Issue: "Unsupported major.minor version 52.0"
**Solution**:
- This indicates a Java version mismatch
- Ensure you're using JDK 1.7 or higher
- Check with: `java -version`

### SBT Compilation Issues

#### Issue: " unresolved dependency"
**Solution**:
- Clear SBT cache:
  ```bash
  rm -rf ~/.sbt ~/.ivy2
  ```
- Check internet connectivity
- Verify dependency versions in build.sbt
- Try running: `sbt reload`

#### Issue: "Compilation failed"
**Solution**:
- Check Scala version compatibility
- Review error messages for specific issues
- Ensure all imports are correct
- Clean and rebuild:
  ```bash
  sbt clean compile
  ```

#### Issue: "Out of memory during compilation"
**Solution**:
- Increase SBT memory:
  ```bash
  export SBT_OPTS="-Xmx2G -Xss2M"
  ```
- Or in project/build.properties:
  ```scala
  sbtOptions in Global += "-Xmx2G"
  ```

### Spark Issues

#### Issue: "SparkContext already exists"
**Solution**:
- Stop existing context before creating new one:
  ```scala
  sc.stop()
  ```
- Or use try-finally to ensure cleanup

#### Issue: "Out of memory in Spark"
**Solution**:
- Increase driver memory:
  ```scala
  conf.set("spark.driver.memory", "2g")
  ```
- Increase executor memory:
  ```scala
  conf.set("spark.executor.memory", "4g")
  ```
- Use caching strategically:
  ```scala
  rdd.persist(StorageLevel.MEMORY_AND_DISK_SER)
  ```

#### Issue: "File not found" errors
**Solution**:
- Use absolute paths
- Check file permissions
- Ensure data files are in correct location
- Use proper path separators for your OS

#### Issue: "Slow Spark jobs"
**Solution**:
- Increase parallelism:
  ```scala
  conf.set("spark.default.parallelism", "100")
  ```
- Use appropriate serialization:
  ```scala
  conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
  ```
- Cache frequently used data:
  ```scala
  df.cache()
  ```

### Breeze Issues

#### Issue: "Breeze dependency not found"
**Solution**:
- Add to build.sbt:
  ```scala
  libraryDependencies += "org.scalanlp" %% "breeze" % "0.13"
  ```
- Run: `sbt reload`

#### Issue: "Dimension mismatch in Breeze operations"
**Solution**:
- Verify vector/matrix dimensions
- Use appropriate operations for your data types
- Check for implicit conversions

### Data Loading Issues

#### Issue: "CSV parsing errors"
**Solution**:
- Specify CSV options:
  ```scala
  .option("header", "true")
  .option("inferSchema", "true")
  .option("delimiter", ",")
  ```
- Check file encoding
- Verify CSV format consistency

#### Issue: "Schema inference fails"
**Solution**:
- Provide explicit schema:
  ```scala
  import org.apache.spark.sql.types._
  val schema = StructType(Array(
    StructField("id", IntegerType, true),
    StructField("name", StringType, true)
  ))
  val df = sqlContext.read.schema(schema).csv("data.csv")
  ```

### Docker Issues

#### Issue: "Docker command not found"
**Solution**:
- Install Docker: https://docs.docker.com/get-docker/
- Start Docker service:
  ```bash
  sudo systemctl start docker
  ```

#### Issue: "Port already in use"
**Solution**:
- Check what's using the port:
  ```bash
  lsof -i :8080
  ```
- Change port in docker-compose.yaml
- Stop conflicting service

#### Issue: "Container won't start"
**Solution**:
- Check logs:
  ```bash
  docker-compose logs <service_name>
  ```
- Verify configuration in .env
- Check Docker daemon is running

### Visualization Issues

#### Issue: "Zeppelin won't connect to Spark"
**Solution**:
- Check Spark interpreter configuration
- Verify Spark master URL
- Check network connectivity
- Restart Zeppelin interpreter

#### Issue: "Charts not displaying"
**Solution**:
- Check browser console for errors
- Verify data format
- Ensure chart type is appropriate for data
- Try different visualization library

### MLlib Issues

#### Issue: "Model convergence issues"
**Solution**:
- Increase number of iterations
- Adjust learning rate (step size)
- Normalize features
- Check for data quality issues

#### Issue: "Poor model performance"
**Solution**:
- Feature engineering
- Try different algorithms
- Increase training data
- Use cross-validation
- Tune hyperparameters

### Streaming Issues

#### Issue: "Streaming context already started"
**Solution**:
- Stop existing context:
  ```scala
  ssc.stop(stopSparkContext = false)
  ```
- Use only one streaming context per JVM

#### Issue: "Kafka connection errors"
**Solution**:
- Verify Kafka is running
- Check broker configuration
- Ensure topic exists
- Check network connectivity

## Getting Additional Help

If you can't resolve your issue:

1. **Check the logs**: Look at detailed error messages
2. **Search existing issues**: Check GitHub Issues for similar problems
3. **Ask in discussions**: Post your question in GitHub Discussions
4. **Consult documentation**: Review Spark/Scala/Breeze official docs
5. **Minimal reproducible example**: Create a simple example that demonstrates the issue

## Reporting Issues

When reporting issues, include:

- Your operating system and version
- Java, Scala, SBT, and Spark versions
- Full error message and stack trace
- Steps to reproduce the issue
- Expected vs actual behavior
- Any relevant configuration files

## Performance Tips

### General Performance
- Use appropriate data structures (dense vs sparse)
- Cache intermediate results when beneficial
- Minimize data shuffling
- Use broadcast variables for large lookup tables

### Spark Performance
- Tune memory allocation
- Use appropriate parallelism
- Consider Kryo serialization
- Monitor with Spark UI

### Scala Performance
- Use functional programming idioms
- Avoid unnecessary object creation
- Use collection operations efficiently
- Profile with JVM tools

## Resource Limits

### Memory Issues
- Increase JVM heap size
- Use off-heap memory where appropriate
- Process data in batches
- Use streaming for large datasets

### Disk Space Issues
- Clean temporary files regularly
- Use compression for data storage
- Archive old results
- Monitor disk usage

## Environment-Specific Issues

### Windows
- Use proper file path separators
- Check line ending formats (CRLF vs LF)
- Verify WSL compatibility if using WSL

### macOS
- Check Homebrew package versions
- Verify Xcode command line tools
- Check security settings for network access

### Linux
- Verify package manager versions
- Check system library dependencies
- Verify file permissions

## Prevention Tips

1. **Regular updates**: Keep dependencies up to date
2. **Version control**: Use Git to track changes
3. **Testing**: Test changes in isolation
4. **Documentation**: Document your environment setup
5. **Backup**: Back up important data and configurations

## Additional Resources

- [Spark Troubleshooting](https://spark.apache.org/docs/latest/troubleshooting.html)
- [Scala FAQ](https://docs.scala-lang.org/faq/)
- [SBT Troubleshooting](https://www.scala-sbt.org/1.x/docs/FAQ.html)
- [Stack Overflow - Scala Tag](https://stackoverflow.com/questions/tagged/scala)
- [Stack Overflow - Apache Spark Tag](https://stackoverflow.com/questions/tagged/apache-spark)