#!/usr/bin/env python3
"""
Sample data generator for Scala Data Analysis Code Practice
This script generates sample datasets for the labs
"""

import pandas as pd
import numpy as np
from faker import Faker
import random
import os

fake = Faker()

def generate_student_data(num_students=1000):
    """Generate student performance data"""
    data = []
    for i in range(num_students):
        student = {
            'id': i + 1,
            'name': fake.name(),
            'age': random.randint(18, 25),
            'grade_level': random.randint(9, 12),
            'gpa': round(random.uniform(2.0, 4.0), 2),
            'study_hours': round(random.uniform(1.0, 10.0), 1),
            'attendance': round(random.uniform(0.5, 1.0), 2),
            'score': round(random.uniform(50, 100), 1)
        }
        data.append(student)
    
    df = pd.DataFrame(data)
    return df

def generate_iris_data(num_samples=150):
    """Generate iris-like dataset"""
    species = ['setosa', 'versicolor', 'virginica']
    data = []
    
    for i in range(num_samples):
        species_type = random.choice(species)
        if species_type == 'setosa':
            sepal_length = round(random.uniform(4.3, 5.8), 1)
            sepal_width = round(random.uniform(2.3, 4.4), 1)
            petal_length = round(random.uniform(1.0, 1.9), 1)
            petal_width = round(random.uniform(0.1, 0.6), 1)
        elif species_type == 'versicolor':
            sepal_length = round(random.uniform(4.9, 7.0), 1)
            sepal_width = round(random.uniform(2.0, 3.4), 1)
            petal_length = round(random.uniform(3.0, 5.1), 1)
            petal_width = round(random.uniform(1.0, 1.8), 1)
        else:
            sepal_length = round(random.uniform(4.9, 7.9), 1)
            sepal_width = round(random.uniform(2.2, 3.8), 1)
            petal_length = round(random.uniform(4.5, 6.9), 1)
            petal_width = round(random.uniform(1.4, 2.5), 1)
        
        data.append({
            'sepal_length': sepal_length,
            'sepal_width': sepal_width,
            'petal_length': petal_length,
            'petal_width': petal_width,
            'species': species_type
        })
    
    df = pd.DataFrame(data)
    return df

def generate_regression_data(num_samples=500):
    """Generate regression dataset"""
    data = []
    for i in range(num_samples):
        x = random.uniform(0, 10)
        y = 2 * x + 3 + random.gauss(0, 1)  # Linear relationship with noise
        data.append({
            'x': x,
            'y': y
        })
    
    df = pd.DataFrame(data)
    return df

def main():
    """Generate all sample datasets"""
    print("Generating sample datasets...")
    
    # Create output directory
    output_dir = "data/sample"
    os.makedirs(output_dir, exist_ok=True)
    
    # Generate student data
    print("Generating student data...")
    student_df = generate_student_data(1000)
    student_df.to_csv(f"{output_dir}/students.csv", index=False)
    
    # Generate iris data
    print("Generating iris data...")
    iris_df = generate_iris_data(150)
    iris_df.to_csv(f"{output_dir}/iris.csv", index=False)
    
    # Generate regression data
    print("Generating regression data...")
    regression_df = generate_regression_data(500)
    regression_df.to_csv(f"{output_dir}/regression.csv", index=False)
    
    print(f"✅ Sample datasets generated successfully in {output_dir}/")

if __name__ == "__main__":
    main()