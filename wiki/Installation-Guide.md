---
title: "Installation Guide - Scala Data Analysis Code Practice"
description: "Step-by-step installation guide for Scala, Spark, Breeze, and development tools for data analysis"
keywords: "scala installation, spark installation, breeze setup, development environment setup"
---

# Installation Guide

This guide will help you set up your development environment for Scala data analysis.

## Prerequisites

Before you begin, ensure you have:

- **Operating System**: Linux, macOS, or Windows (with WSL)
- **Internet Connection**: For downloading dependencies
- **Administrator Rights**: For installing software
- **Disk Space**: At least 10GB free space

## Installing Java (JDK)

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install openjdk-7-jdk
```

### macOS

```bash
brew install openjdk@7
```

### Windows

Download and install from [Oracle's website](https://www.oracle.com/java/technologies/javase/jdk7-downloads.html)

### Verify Installation

```bash
java -version
javac -version
```

## Installing Scala

### Linux

```bash
wget https://www.scala-lang.org/files/archive/scala-2.10.4.tgz
sudo tar -xzf scala-2.10.4.tgz -C /usr/local/
export PATH=$PATH:/usr/local/scala-2.10.4/bin
```

### macOS

```bash
brew install scala@2.10
```

### Windows

Download from [Scala website](https://www.scala-lang.org/download/)

### Verify Installation

```bash
scala -version
scalac -version
```

## Installing SBT (Scala Build Tool)

### Linux

```bash
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt
```

### macOS

```bash
brew install sbt@0.13
```

### Verify Installation

```bash
sbt --version
```

## Installing Apache Spark

### Download and Install

```bash
wget http://www.apache.org/dyn/closer.cgi/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz
tar -xzf spark-1.6.0-bin-hadoop2.6.tgz
export SPARK_HOME=/path/to/spark-1.6.0-bin-hadoop2.6
export PATH=$PATH:$SPARK_HOME/bin
```

### Verify Installation

```bash
spark-shell --version
```

## Installing Python (for utility scripts)

### Linux

```bash
sudo apt-get install python3 python3-pip
```

### macOS

```bash
brew install python3
```

### Install Python Dependencies

```bash
pip3 install -r requirements.txt
```

## Docker Installation (Optional)

### Linux

```bash
sudo apt-get update
sudo apt-get install docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
```

### macOS

Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop)

## Setting Up the Project

### Clone the Repository

```bash
git clone https://github.com/nellaivijay/scala-dataanalysis-code-practice.git
cd scala-dataanalysis-code-practice
```

### Run Setup Script

```bash
./scripts/setup.sh
```

### Manual Setup

1. **Configure Environment Variables**

```bash
cp .env.example .env
# Edit .env with your configuration
```

2. **Compile the Project**

```bash
sbt clean compile
```

3. **Generate Sample Data**

```bash
python3 scripts/generate_sample_data.py
```

## IDE Setup

### IntelliJ IDEA

1. Install IntelliJ IDEA (Community Edition is free)
2. Install Scala plugin
3. Open the project directory
4. Wait for SBT import to complete

### VS Code

1. Install VS Code
2. Install Scala extension (Metals)
3. Install Code Runner extension
4. Open the project directory

### Eclipse

1. Install Scala IDE
2. Import existing project
3. Select the project directory

## Troubleshooting

### Java Version Issues

If you encounter Java version issues:

```bash
export JAVA_HOME=/path/to/jdk1.7.0
export PATH=$JAVA_HOME/bin:$PATH
```

### Scala Version Issues

If you encounter Scala version issues:

```bash
export SCALA_HOME=/path/to/scala-2.10.4
export PATH=$SCALA_HOME/bin:$PATH
```

### SBT Issues

If SBT fails to resolve dependencies:

```bash
rm -rf ~/.sbt ~/.ivy2
sbt reload
```

### Docker Issues

If Docker fails to start:

```bash
sudo systemctl start docker
sudo usermod -aG docker $USER
# Log out and log back in
```

## Verification

### Test Java

```bash
java -version
```

### Test Scala

```bash
scala -version
```

### Test SBT

```bash
sbt --version
```

### Test Project Compilation

```bash
sbt clean compile
```

### Test Docker (if installed)

```bash
docker --version
docker-compose --version
```

## Next Steps

Once your environment is set up:

1. Read the [Quick Start guide](Quick-Start)
2. Begin with [Lab 1: Breeze Basics](Lab-1-Breeze-Basics)
3. Follow the [Beginner Learning Path](Beginner-Path)
4. Join the community discussions

## Additional Resources

- [Official Scala Documentation](https://docs.scala-lang.org/)
- [SBT Documentation](https://www.scala-sbt.org/documentation.html)
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Docker Documentation](https://docs.docker.com/)

---

**Need Help?** Check our [Common Issues](Common-Issues) page or [ask a question](https://github.com/nellaivijay/scala-dataanalysis-code-practice/discussions).