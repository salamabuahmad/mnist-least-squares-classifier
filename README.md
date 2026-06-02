# MNIST Least-Squares Digit Classifier

## Overview

This project implements a handwritten digit recognition system in MATLAB using the MNIST dataset.

The classifier uses a least-squares approach. Each digit is treated as a binary classification problem, where the target digit is labeled as `+1` and all other digits are labeled as `-1`.

The project then combines the digit classifiers to perform multi-class digit prediction.

## Features

- Loads and processes MNIST image data
- Converts 28×28 digit images into 784-dimensional feature vectors
- Trains binary classifiers for digits 0 through 9
- Uses the pseudoinverse to solve a least-squares problem
- Evaluates training and test accuracy
- Displays misclassified digit images
- Performs multi-class digit recognition by comparing classifier scores

## Technologies Used

- MATLAB
- Linear Algebra
- Least Squares
- Pseudoinverse
- Matrix Operations
- MNIST Dataset
- Basic Machine Learning

## Project Files

- `DigitRecognition.m` - trains and evaluates a binary classifier for a selected digit
- `section_1.m` - runs binary classification for digit 0 against all other digits
- `section_2.m` - trains classifiers for digits 0 through 9
- `section_3.m` - performs full multi-class digit recognition on the MNIST test set

## Dataset

This project expects a file named:

```text
mnist.mat
