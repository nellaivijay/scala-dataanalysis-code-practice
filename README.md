# Scala Data Analysis Code Practice

## 🎯 Educational Mission

A comprehensive Scala data analysis learning environment designed for developers, data engineers, and data scientists who want to master modern data analysis concepts through hands-on practice with Scala.

**7 progressive chapters with 50+ exercises. Completely free and open source. Built for learners, by learners.**

## 🏗️ Project Structure

```
scala-dataanalysis-code-practice/
├── src/
│   └── main/
│       └── scala/
│           └── com/
│               └── scalaanalysis/
│                   ├── chapter1/  # Breeze basics & Spark fundamentals
│                   ├── chapter2/  # (referenced in labs)
│                   ├── chapter3/  # Data loading & preparation
│                   ├── chapter4/  # Visualization
│                   ├── chapter5/  # Machine learning
│                   ├── chapter6/  # Scaling & deployment
│                   └── chapter7/  # Streaming & GraphX
├── labs/                    # Hands-on lab guides
│   ├── chapter-01-breeze-basics.md
│   ├── chapter-02-spark-fundamentals.md
│   ├── chapter-03-data-loading.md
│   ├── chapter-04-visualization.md
│   ├── chapter-05-machine-learning.md
│   ├── chapter-06-scaling-up.md
│   └── chapter-07-advanced-topics.md
├── docs/                    # Documentation
│   ├── SETUP_GUIDE.md
│   ├── TROUBLESHOOTING.md
│   ├── DATASETS.md
│   └── conceptual-guides/
├── scripts/                 # Utility scripts
│   ├── setup.sh
│   ├── build_helper.sh
│   └── generate_sample_data.py
├── data/                    # Sample datasets
│   ├── iris.data
│   ├── StudentData.csv
│   ├── dow_jones_index.data
│   └── sample/
├── config/                  # Configuration files
├── notebooks/              # Jupyter notebooks (placeholder)
├── solutions/              # Solution code (placeholder)
├── k8s/                    # Kubernetes manifests (placeholder)
├── wiki/                   # Wiki documentation (placeholder)
├── build.sbt              # SBT build configuration
├── docker-compose.yaml    # Docker setup
├── .env.example          # Environment variables template
└── README.md             # This file
```

## 🚀 Quick Start

### Prerequisites

- JDK 1.7 or higher
- Scala 2.10.4 or higher
- SBT 0.13.8 or higher
- Python 3.8+ (for utility scripts)

### Setup

1. **Clone the repository**
```bash
git clone https://github.com/nellaivijay/scala-dataanalysis-code-practice.git
cd scala-dataanalysis-code-practice
```

2. **Run setup script**
```bash
./scripts/setup.sh
```

3. **Compile the project**
```bash
sbt clean compile
```

### Alternative: Docker Setup

```bash
cp .env.example .env
docker-compose up -d
```

## 📚 Learning Path

### Beginner (Chapters 1-2)
- **Chapter 1**: Breeze numerical computing & Spark fundamentals
- **Chapter 2**: Spark DataFrames and basic operations

### Intermediate (Chapters 3-4)
- **Chapter 3**: Data loading, cleaning, and preparation
- **Chapter 4**: Data visualization with Zeppelin and Bokeh

### Advanced (Chapters 5-7)
- **Chapter 5**: Machine learning with MLlib
- **Chapter 6**: Scaling and deployment strategies
- **Chapter 7**: Streaming and GraphX

## 🛠️ Core Technologies

- **Scala 2.10.4**: Programming language
- **Apache Spark 1.6.0**: Distributed data processing
- **Breeze 0.13**: Numerical computing
- **Spark MLlib**: Machine learning library
- **Spark Streaming**: Real-time processing
- **GraphX**: Graph processing
- **Apache Zeppelin**: Interactive notebooks

## 📖 Available Labs

1. **Lab 1**: Getting Started with Breeze - Vectors, Matrices and RNGs
2. **Lab 2**: Getting Started with Spark - DataFrames, Vectors and Matrices
3. **Lab 3**: Data Loading and Preparation - Spark DataFrames
4. **Lab 4**: Data Visualization with Zeppelin and Bokeh Scala
5. **Lab 5**: Learning from Data - Spark MLlib
6. **Lab 6**: Scaling Up - Deploying Spark on clusters
7. **Lab 7**: Going Further - Streaming and GraphX

## 🔧 Development

### Build Commands

```bash
# Compile the project
sbt compile

# Run tests
sbt test

# Create JAR package
sbt package

# Start Scala REPL
sbt console

# Run specific class
sbt 'runMain com.scalaanalysis.chapter1.YourClassName'
```

### Using Build Helper

```bash
# Compile specific chapter
./scripts/build_helper.sh chapter1 compile

# Package the project
./scripts/build_helper.sh chapter1 package
```

## 📊 Sample Datasets

The project includes various datasets for hands-on learning:

- **Iris Dataset**: Classic machine learning dataset
- **Student Data**: Educational performance metrics
- **Dow Jones Index**: Financial time series data
- **MT Cars**: Automobile performance data
- **Profile Data**: User profile information

## 🤝 Contributing

This is an educational repository. Contributions are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

Apache License 2.0

## 🔗 Additional Resources

- [Scala Documentation](https://docs.scala-lang.org/)
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Breeze Documentation](https://github.com/scalanlp/breeze)
- [Setup Guide](docs/SETUP_GUIDE.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## 🎓 Educational Mission

This repository is designed to help data professionals:
- Practice Scala data analysis and data science concepts
- Learn vendor-independent data engineering patterns
- Understand modern data processing with Spark and Breeze
- Build hands-on experience with machine learning and streaming
- Prepare for real-world data science challenges

**Disclaimer**: This is an independent educational resource for learning Scala data analysis and data science concepts. It is not affiliated with, endorsed by, or sponsored by Apache Spark, Scala, or any vendor.