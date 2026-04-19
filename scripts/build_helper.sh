#!/bin/bash

# Build helper script for Scala Data Analysis Code Practice
# This script helps build and test different chapters

set -e

CHAPTER=$1
COMMAND=${2:-compile}

if [ -z "$CHAPTER" ]; then
    echo "Usage: ./build_helper.sh <chapter> [command]"
    echo ""
    echo "Available chapters:"
    echo "  chapter1"
    echo "  chapter2"
    echo "  chapter3"
    echo "  chapter4"
    echo "  chapter5"
    echo "  chapter6"
    echo "  chapter7"
    echo ""
    echo "Available commands:"
    echo "  compile (default)"
    echo "  run"
    echo "  test"
    echo "  clean"
    echo "  package"
    echo ""
    echo "Examples:"
    echo "  ./build_helper.sh chapter1 compile"
    echo "  ./build_helper.sh chapter5 run"
    echo "  ./build_helper.sh chapter3 package"
    echo ""
    exit 1
fi

echo "Building chapter: $CHAPTER"
echo "Command: $COMMAND"
echo ""

case $COMMAND in
    compile)
        echo "Compiling project..."
        sbt clean compile
        ;;
    run)
        echo "Running project..."
        echo "Note: To run specific chapter code, use sbt console or create main classes"
        sbt compile
        echo "To run specific examples, use: sbt 'runMain com.scalaanalysis.$CHAPTER.YourClassName'"
        ;;
    test)
        echo "Running tests..."
        sbt test
        ;;
    clean)
        echo "Cleaning project..."
        sbt clean
        ;;
    package)
        echo "Creating JAR package..."
        sbt package
        ;;
    *)
        echo "Unknown command: $COMMAND"
        exit 1
        ;;
esac

echo ""
echo "✅ Command completed successfully"