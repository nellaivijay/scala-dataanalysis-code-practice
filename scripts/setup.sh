#!/bin/bash

# Scala Data Analysis Code Practice - Setup Script
# This script sets up the development environment for Scala data analysis

set -e

echo "=========================================="
echo "Scala Data Analysis Code Practice Setup"
echo "=========================================="
echo ""

# Check for required tools
echo "Checking for required tools..."

# Check Java
if ! command -v java &> /dev/null; then
    echo "❌ Java is not installed. Please install JDK 1.7 or higher."
    exit 1
else
    JAVA_VERSION=$(java -version 2>&1 | head -n 1)
    echo "✅ Java found: $JAVA_VERSION"
fi

# Check Scala
if ! command -v scala &> /dev/null; then
    echo "❌ Scala is not installed. Please install Scala 2.10.4 or higher."
    exit 1
else
    SCALA_VERSION=$(scala -version 2>&1 | head -n 1)
    echo "✅ Scala found: $SCALA_VERSION"
fi

# Check SBT
if ! command -v sbt &> /dev/null; then
    echo "❌ SBT is not installed. Please install SBT 0.13.8 or higher."
    exit 1
else
    SBT_VERSION=$(sbt --version | head -n 1)
    echo "✅ SBT found: $SBT_VERSION"
fi

echo ""
echo "Setting up environment..."

# Create necessary directories
echo "Creating project directories..."
mkdir -p logs
mkdir -p data/sample
mkdir -p output

# Set up environment variables
echo "Setting up environment variables..."
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your specific configuration"
else
    echo "✅ .env file already exists"
fi

# Install Python dependencies if needed
if command -v python3 &> /dev/null; then
    echo "Installing Python dependencies..."
    pip3 install -r requirements.txt || echo "⚠️  Some Python dependencies may not be installed"
else
    echo "⚠️  Python3 not found, skipping Python dependencies"
fi

# Compile the project
echo ""
echo "Compiling Scala project..."
sbt clean compile || echo "⚠️  Compilation may have warnings"

echo ""
echo "=========================================="
echo "Setup completed successfully!"
echo "=========================================="
echo ""
echo "Project Structure:"
echo "  src/main/scala/com/scalaanalysis/ - Source code organized by chapter"
echo "  labs/ - Lab markdown files for hands-on exercises"
echo "  docs/ - Documentation and guides"
echo "  scripts/ - Utility scripts"
echo "  data/ - Sample datasets"
echo ""
echo "Next steps:"
echo "1. Edit .env file with your configuration"
echo "2. Run 'sbt compile' to compile the project"
echo "3. Run 'sbt console' to start Scala REPL"
echo "4. Or use 'docker-compose up -d' for Docker setup"
echo "5. Check the labs/ directory for hands-on exercises"
echo ""
echo "For more information, see README.md"