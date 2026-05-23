# Cross-Prompt Automated Essay Scoring using Neural Models

A deep learning project for **Cross-Prompt Automated Essay Scoring (AES)**.  
The goal is to train models on essays from existing prompts and test whether they can score essays from a **new unseen prompt** without retraining on that prompt.

---
## Overview
<img width="1055" height="1491" alt="Image" src="https://github.com/user-attachments/assets/0a364b25-bae4-4edf-b0bf-e368880c58ef" />

## Project Summary

Automated Essay Scoring is the task of automatically predicting essay quality using machine learning.

In normal prompt-specific AES, a model is trained and tested on essays from the same prompt. This project focuses on a harder and more realistic setting: **cross-prompt scoring**.

```text
Train on 7 prompts → Test on 1 unseen prompt → Predict essay scores
```

The project compares simple feature-based neural networks with a BERT-based model to study how well neural models generalize to unseen essay prompts.

---

## Main Objective

The main objective is to answer:

> Can neural models score essays written for a new prompt without being retrained on that prompt?

The AES task is treated as a **regression problem**, where the model predicts numeric essay scores.

---

## Dataset

The project uses the **ASAP** and **ASAP++** datasets.

Each essay contains:

- Essay ID
- Prompt ID
- Essay text
- Holistic score
- Trait scores
- 86 prompt-independent features

The trait scores include:

- Content
- Organization
- Word Choice
- Sentence Fluency
- Conventions
- Prompt Adherence
- Language
- Narrativity

Expected dataset path:

```text
data/dataset.csv
```

> Note: If this repository is public, the dataset may not be included because of dataset sharing restrictions. Place `dataset.csv` inside the `data/` folder before running the notebooks.

---

## Model Approaches

### Approach A: FFN for Holistic Scoring

Approach A uses a feed-forward neural network to predict only the holistic essay score.

```text
Input: 86 essay features
Output: 1 holistic score
```

---

### Approach B: FFN for Joint Holistic and Trait Scoring

Approach B uses a feed-forward neural network in a multi-task learning setup.

```text
Input: 86 essay features
Output: 9 scores
        = 1 holistic score + 8 trait scores
```

The idea is that trait scores can help the model learn better representations for predicting the final holistic score.

---

### Approach C: BERT + Features

Approach C uses a BERT-based model for holistic scoring.

```text
Input: essay text + 86 essay features
Output: 1 holistic score
```

The BERT model extracts a text representation from the essay, combines it with the extracted essay features, and passes the combined representation into a regression head.

Approach C was tested for Prompt 1 only.

---

## Evaluation Method

The project uses **leave-one-prompt-out cross-validation**.

For each experiment:

```text
Train: essays from 7 prompts
Test: essays from 1 unseen prompt
```

This is repeated across the available prompts.

The main evaluation metric is:

```text
QWK = Quadratic Weighted Kappa
```

Higher QWK means better agreement between the model predictions and the human-assigned scores.

---

## Repository Structure

```text
cross-prompt-aes/
│
├── data/
│   ├── dataset.csv
│   └── README.md
│
├── src/
│   └── general_utils.py
│
├── notebooks/
│   ├── deployment/
│   │   └── AES_System_AB.ipynb
│   │
│   ├── approach_A/
│   │   ├── TrainingCodeA.ipynb
│   │   ├── ImprovedCodeA.ipynb
│   │   └── README_Approach_A.txt
│   │
│   ├── approach_B/
│   │   ├── TrainingCodeB.ipynb
│   │   └── README_Approach_B.txt
│   │
│   └── approach_C/
│       ├── trainingCodeC.ipynb
│       └── README_Approach_C.txt
│
├── models/
│   ├── approach_A/
│   └── approach_B/
│
├── results/
│   ├── approach_A/
│   └── approach_B/
│
├── examples/
│
├── docs/
│   ├── report/
│   └── project_resources/
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

## Important Files

| File | Description |
|---|---|
| `src/general_utils.py` | Utility functions for reading data, score ranges, and QWK evaluation |
| `notebooks/approach_A/TrainingCodeA.ipynb` | Training notebook for Approach A |
| `notebooks/approach_B/TrainingCodeB.ipynb` | Training notebook for Approach B |
| `notebooks/approach_C/trainingCodeC.ipynb` | Training notebook for Approach C |
| `notebooks/deployment/AES_System_AB.ipynb` | Notebook for using deployed models to score essays |
| `models/approach_A/` | Trained Approach A models |
| `models/approach_B/` | Trained Approach B models |
| `results/` | Experiment results and QWK tracking files |
| `docs/report/` | Final project report |
| `docs/project_resources/` | Original project description and supporting documents |

---

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/cross-prompt-aes.git
cd cross-prompt-aes
```

Create a virtual environment:

```bash
python -m venv .venv
```

Activate the environment on Windows:

```bash
.venv\Scripts\activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Start Jupyter Notebook:

```bash
jupyter notebook
```

---

## Running the Notebooks

### Run Approach A

Open:

```text
notebooks/approach_A/TrainingCodeA.ipynb
```

This notebook trains a feed-forward neural network for holistic scoring.

---

### Run Approach B

Open:

```text
notebooks/approach_B/TrainingCodeB.ipynb
```

This notebook trains a feed-forward neural network for joint holistic and trait scoring.

---

### Run Approach C

Open:

```text
notebooks/approach_C/trainingCodeC.ipynb
```

Approach C uses BERT, so it is recommended to run it on Google Colab with GPU enabled.

---

### Run the Deployment Notebook

Open:

```text
notebooks/deployment/AES_System_AB.ipynb
```

This notebook uses the deployed Approach A and Approach B models to score new essays.

---

## Notes for VSCode

Open the project in VSCode:

```bash
code .
```

If a notebook cannot find `general_utils.py`, add this near the top of the notebook:

```python
import sys
sys.path.append("../../src")
```

If a notebook reads:

```python
pd.read_csv("dataset.csv")
```

change it to:

```python
pd.read_csv("../../data/dataset.csv")
```

For notebooks inside `notebooks/deployment/`, use:

```python
pd.read_csv("../../data/dataset.csv")
```

---

## Trained Models

Approach A models are stored in:

```text
models/approach_A/
```

Approach B models are stored in:

```text
models/approach_B/
```

The deployed models are:

```text
model-A-deploy.pt
model-B-deploy.pt
```

---

## Results

Experiment results are stored in:

```text
results/approach_A/
results/approach_B/
```

These folders contain score tracking files, grid search results, batch size tuning results, and QWK performance records.

---

## Technologies Used

- Python
- PyTorch
- Hugging Face Transformers
- Pandas
- NumPy
- Scikit-learn
- Jupyter Notebook

---

## Key Learning Outcomes

This project demonstrates:

- Automated Essay Scoring as a regression task
- Cross-prompt model evaluation
- Feed-forward neural networks for feature-based scoring
- Multi-task learning for holistic and trait scoring
- BERT fine-tuning for essay scoring
- QWK-based model evaluation
- Experiment tracking and model deployment preparation

---

## Final Summary

This project investigates whether neural models can generalize across essay prompts.  
It compares feature-based feed-forward neural networks and a BERT-based model for scoring essays written for unseen prompts.

The main goal is:

```text
Score essays for new prompts without retraining on those prompts.
```
