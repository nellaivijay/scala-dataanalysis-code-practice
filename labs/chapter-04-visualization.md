# Lab 4: Data Visualization with Zeppelin and Bokeh Scala

## Overview

Data visualization is the bridge between raw data and actionable insights. This lab teaches you how to transform your analyzed data into compelling visual stories using Apache Zeppelin (interactive notebooks) and Bokeh Scala (interactive visualization library). You'll learn to create charts, graphs, and dashboards that communicate findings effectively to both technical and non-technical audiences.

**What makes this lab important**: The best analysis is useless if you can't communicate your findings effectively. Data visualization is a critical skill for data scientists and analysts, enabling you to discover patterns, communicate results, and influence decisions. This lab complements the technical skills from previous labs with essential communication skills.

**Real-world applications**: Business intelligence dashboards, real-time monitoring systems, executive reporting, exploratory data analysis, and presenting machine learning model results. Visualization is essential for stakeholder communication, data-driven decision making, and making complex data accessible to non-technical audiences.

## Learning Objectives

By the end of this lab, you will be able to:
- Set up Apache Zeppelin for Scala visualization
- Create basic charts and graphs
- Use Bokeh Scala for interactive visualizations
- Visualize data from Spark DataFrames
- Create dashboards and reports

## Prerequisites

- Completed Lab 3: Data Loading and Preparation
- Apache Zeppelin installed (or use Docker setup)
- Basic understanding of data visualization concepts

## Estimated Time

60-90 minutes

## Conceptual Background

Data visualization is essential for understanding and communicating insights. This lab covers:

- **Apache Zeppelin**: Interactive notebook for data visualization
- **Bokeh Scala**: Interactive plotting library for Scala
- **Spark Integration**: Visualizing distributed data
- **Chart Types**: Line charts, bar charts, scatter plots, histograms

## Lab Steps

### Step 1: Set Up Apache Zeppelin

1. Start Zeppelin (if using Docker):
```bash
docker-compose up -d zeppelin
```

2. Access Zeppelin web UI:
```
http://localhost:8080
```

3. Create a new notebook:
- Click "Notebook" → "Create new note"
- Name it "Data Visualization Lab"
- Select "spark" as the interpreter

### Step 2: Basic Visualizations in Zeppelin

1. Load data in Zeppelin:
```scala
%spark
val df = sqlContext.read
  .format("csv")
  .option("header", "true")
  .option("inferSchema", "true")
  .load("data/iris.data")

df.registerTempTable("iris")
```

2. Create a basic table display:
```scala
%spark
z.show(df.limit(10))
```

3. Create a bar chart:
```scala
%spark
val speciesCount = sqlContext.sql(
  "SELECT species, COUNT(*) as count FROM iris GROUP BY species"
)

z.show(speciesCount)
```
- Click the chart icon in the result
- Select "bar" as chart type
- Configure x-axis as "species" and y-axis as "count"

### Exercise 4.1
Using the iris dataset in Zeppelin:
- Display the first 20 rows
- Create a bar chart showing count by species
- Create a pie chart showing species distribution

### Step 3: Advanced Zeppelin Visualizations

1. Create a scatter plot:
```scala
%spark
val scatterData = sqlContext.sql(
  "SELECT sepal_length, sepal_width, species FROM iris"
)

z.show(scatterData)
```
- Configure as scatter plot with sepal_length on x-axis and sepal_width on y-axis
- Color by species

2. Create a histogram:
```scala
%spark
val histogramData = sqlContext.sql(
  "SELECT sepal_length FROM iris"
)

z.show(histogramData)
```
- Configure as histogram

3. Create a line chart:
```scala
%spark
val lineData = sqlContext.sql(
  "SELECT sepal_length, petal_length FROM iris ORDER BY sepal_length"
)

z.show(lineData)
```
- Configure as line chart

### Exercise 4.2
Create visualizations for the StudentData dataset:
- Histogram of student ages
- Bar chart of grade distribution
- Scatter plot of age vs score
- Line chart showing score trends

### Step 4: Bokeh Scala Integration

1. Add Bokeh Scala dependencies to your project:
```scala
libraryDependencies += "io.continuum" %% "bokeh-scala" % "0.8"
```

2. Create a basic Bokeh plot:
```scala
import io.continuum.bokeh._

val x = List(1, 2, 3, 4, 5)
val y = List(2, 4, 6, 8, 10)

val plot = new Plot()
  .x_range(new Range1d(0, 6))
  .y_range(new Range1d(0, 12))
  .title("Basic Line Plot")

val line = new Line()
  .x(x)
  .y(y)
  .line_color("blue")
  .line_width(2)

plot.renderers += line

val html = HTMLFile.save(plot, "output/basic_plot.html")
```

3. Create a scatter plot with Bokeh:
```scala
val scatter = new Scatter()
  .x(List(1, 2, 3, 4, 5))
  .y(List(2, 4, 6, 8, 10))
  .size(10)
  .color("red")
  .alpha(0.6)

val scatterPlot = new Plot()
  .title("Scatter Plot")
scatterPlot.renderers += scatter

HTMLFile.save(scatterPlot, "output/scatter_plot.html")
```

### Exercise 4.3
Using Bokeh Scala:
- Create a bar chart for species counts
- Create a scatter plot for iris measurements
- Add tooltips to your visualizations
- Customize colors and sizes

### Step 5: Interactive Dashboards

1. Create a multi-paragraph Zeppelin notebook:
```scala
%spark
// Paragraph 1: Data loading
val df = sqlContext.read.format("csv").option("header", "true").load("data/iris.data")
df.registerTempTable("iris")

%spark
// Paragraph 2: Summary statistics
z.show(sqlContext.sql("SELECT * FROM iris").describe())

%spark
// Paragraph 3: Species distribution
z.show(sqlContext.sql("SELECT species, COUNT(*) as count FROM iris GROUP BY species"))

%spark
// Paragraph 4: Measurement correlations
z.show(sqlContext.sql("SELECT sepal_length, sepal_width, petal_length, petal_width FROM iris"))
```

2. Use Zeppelin's dynamic forms:
```scala
%spark
val species = z.select("Species", Seq("setosa", "versicolor", "virginica"))

val filteredData = sqlContext.sql(
  s"SELECT * FROM iris WHERE species = '${species}'"
)

z.show(filteredData)
```

### Exercise 4.4
Create an interactive dashboard:
- Add dynamic filters for age range
- Add dropdown for category selection
- Create linked visualizations
- Add summary statistics panel

## Expected Results

After completing this lab, you should:
- Be comfortable using Apache Zeppelin for data visualization
- Understand how to create various chart types
- Know how to use Bokeh Scala for interactive plots
- Be able to create interactive dashboards
- Understand visualization best practices

## Troubleshooting

### Issue: Zeppelin interpreter not connecting to Spark
**Solution**: Check Spark interpreter configuration in Zeppelin:
- Go to Interpreter → spark → edit
- Verify spark.master and other properties

### Issue: Bokeh Scala dependency conflicts
**Solution**: Ensure compatible versions of Bokeh and Scala in your build.sbt

### Issue: Charts not displaying
**Solution**: Check browser console for JavaScript errors and ensure data is properly formatted

## Next Steps

After completing this lab, you can proceed to:
- Lab 5: Learning from Data - Machine Learning with MLlib
- Explore advanced visualization techniques
- Learn about real-time visualization with streaming data

## Additional Resources

- [Apache Zeppelin Documentation](https://zeppelin.apache.org/docs/)
- [Bokeh Scala Documentation](https://bokeh.pydata.org/en/latest/docs/user_guide/bokehjs.html)
- [Data Visualization Best Practices](https://www.tableau.com/learn/articles/best-beautiful-data-visualization-examples)