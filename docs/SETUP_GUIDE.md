# Setup Guide for Scala Data Analysis Code Practice

This guide will help you set up your development environment for the Scala Data Analysis Code Practice labs.

## Prerequisites

Before you begin, ensure you have the following installed:

### Required Software

- **JDK 1.7 or higher**: Java Development Kit
  ```bash
  # Check Java version
  java -version
  ```

- **Scala 2.10.4 or higher**: Scala programming language
  ```bash
  # Check Scala version
  scala -version
  ```

- **SBT 0.13.8 or higher**: Scala Build Tool
  ```bash
  # Check SBT version
  sbt --version
  ```

- **Python 3.8+** (for utility scripts)
  ```bash
  # Check Python version
  python3 --version
  ```

### Optional Software

- **Apache Spark 1.6.0+**: For Spark-based chapters
- **Apache Zeppelin**: For visualization chapters
- **Docker**: For containerized setup
- **Git**: For version control

## Installation Instructions

### Installing Java (JDK)

**Ubuntu/Debian**:
```bash
sudo apt-get update
sudo apt-get install openjdk-7-jdk
```

**macOS** (using Homebrew):
```bash
brew install openjdk@7
```

**Windows**: Download from [Oracle's website](https://www.oracle.com/java/technologies/javase/jdk7-downloads.html)

### Installing Scala

**Ubuntu/Debian**:
```bash
wget https://www.scala-lang.org/files/archive/scala-2.10.4.tgz
sudo tar -xzf scala-2.10.4.tgz -C /usr/local/
export PATH=$PATH:/usr/local/scala-2.10.4/bin
```

**macOS** (using Homebrew):
```bash
brew install scala@2.10
```

### Installing SBT

**Ubuntu/Debian**:
```bash
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt
```

**macOS** (using Homebrew):
```bash
brew install sbt@0.13
```

### Installing Apache Spark

```bash
wget http://www.apache.org/dyn/closer.cgi/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz
tar -xzf spark-1.6.0-bin-hadoop2.6.tgz
export SPARK_HOME=/path/to/spark-1.6.0-bin-hadoop2.6
export PATH=$PATH:$SPARK_HOME/bin
```

## Project Setup

### 1. Clone the Repository

```bash
git clone https://github.com/nellaivijay/scala-dataanalysis-code-practice.git
cd scala-dataanalysis-code-practice
```

### 2. Run the Setup Script

```bash
./scripts/setup.sh
```

This script will:
- Check for required dependencies
- Create necessary directories
- Set up environment variables
- Install Python dependencies
- Compile the project

### 3. Configure Environment Variables

Copy the example environment file and customize it:

```bash
cp .env.example .env
# Edit .env with your specific configuration
```

### 4. Generate Sample Data

```bash
python3 scripts/generate_sample_data.py
```

### 5. Compile the Project

```bash
sbt clean compile
```

## Docker Setup (Alternative)

If you prefer using Docker, follow these steps:

### 1. Install Docker

**Ubuntu/Debian**:
```bash
sudo apt-get update
sudo apt-get install docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
```

**macOS**: Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop)

### 2. Configure Environment

```bash
cp .env.example .env
# Edit .env with your Docker-specific configuration
```

### 3. Start Services

```bash
docker-compose up -d
```

This will start:
- Spark Master
- Spark Worker
- Spark History Server
- Kafka (for streaming chapters)
- Zeppelin (for visualization chapters)

### 4. Access Services

- Spark UI: http://localhost:8080
- Spark History Server: http://localhost:18080
- Zeppelin: http://localhost:8080
- Kafka UI: http://localhost:8085

## Verification

### Verify Java Installation
```bash
java -version
javac -version
```

### Verify Scala Installation
```bash
scala -version
scalac -version
```

### Verify SBT Installation
```bash
sbt --version
```

### Verify Project Compilation
```bash
sbt clean compile
```

### Verify Spark Installation (if installed)
```bash
spark-shell --version
```

## Troubleshooting

### Issue: Java version mismatch
**Solution**: Ensure you have JDK 1.7 or higher installed and set JAVA_HOME:
```bash
export JAVA_HOME=/path/to/jdk
```

### Issue: Scala not found
**Solution**: Add Scala to your PATH:
```bash
export PATH=$PATH:/path/to/scala/bin
```

### Issue: SBT compilation errors
**Solution**: 
- Clear SBT cache: `rm -rf ~/.sbt ~/.ivy2`
- Update project dependencies in build.sbt
- Check internet connectivity for dependency downloads

### Issue: Docker containers not starting
**Solution**:
- Check Docker is running: `docker ps`
- Check logs: `docker-compose logs`
- Verify ports are not already in use

### Issue: Out of memory errors
**Solution**: Increase memory allocation in .env or spark-submit command:
```bash
export SPARK_DRIVER_MEMORY=2g
export SPARK_EXECUTOR_MEMORY=4g
```

## Next Steps

Once your environment is set up:

1. **Start with Lab 1**: [Breeze Basics](labs/chapter-01-breeze-basics.md)
2. **Progress through labs**: Follow the [Learning Path](wiki/Learning-Path)
3. **Explore documentation**: Check the [docs](docs/) directory for detailed guides
4. **Join the community**: Participate in discussions and contribute

## Additional Resources

- [Scala Documentation](https://docs.scala-lang.org/)
- [SBT Documentation](https://www.scala-sbt.org/documentation.html)
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Docker Documentation](https://docs.docker.com/)

## Getting Help

If you encounter issues:

1. Check the [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
2. Search existing [GitHub Issues](https://github.com/nellaivijay/scala-dataanalysis-code-practice/issues)
3. Ask questions in [GitHub Discussions](https://github.com/nellaivijay/scala-dataanalysis-code-practice/discussions)
4. Consult the [Wiki](wiki) for additional guidance