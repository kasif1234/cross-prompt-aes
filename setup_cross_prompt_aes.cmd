@echo off
setlocal enabledelayedexpansion

set "SRC=C:\Users\GZ\Downloads\DL_Project\Project"
set "REPO=C:\Users\GZ\Downloads\DL_Project\cross-prompt-aes"
set "TMP=%REPO%\_tmp"

echo Creating clean project folder...

if exist "%REPO%" rmdir /s /q "%REPO%"

mkdir "%REPO%"
mkdir "%REPO%\data"
mkdir "%REPO%\src"
mkdir "%REPO%\notebooks\deployment"
mkdir "%REPO%\notebooks\approach_A"
mkdir "%REPO%\notebooks\approach_B"
mkdir "%REPO%\notebooks\approach_C"
mkdir "%REPO%\models\approach_A"
mkdir "%REPO%\models\approach_B"
mkdir "%REPO%\results\approach_A\step1"
mkdir "%REPO%\results\approach_A\step2"
mkdir "%REPO%\results\approach_B\step1"
mkdir "%REPO%\results\approach_B\step2"
mkdir "%REPO%\examples"
mkdir "%REPO%\docs\report"
mkdir "%REPO%\docs\project_resources"
mkdir "%TMP%"

echo Copying dataset and utilities...

copy "%SRC%\Start\dataset.csv" "%REPO%\data\dataset.csv"
copy "%SRC%\Start\general_utils.py" "%REPO%\src\general_utils.py"

echo Copying project resources...

copy "%SRC%\Start\AES paper.pdf" "%REPO%\docs\project_resources\AES paper.pdf"
copy "%SRC%\Start\DL-F24-Project.final.pdf" "%REPO%\docs\project_resources\DL-F24-Project.final.pdf"
copy "%SRC%\Start\DL-F24-Project.v1.pdf" "%REPO%\docs\project_resources\DL-F24-Project.v1.pdf"
copy "%SRC%\Start\Project Description.xlsx" "%REPO%\docs\project_resources\Project Description.xlsx"
copy "%SRC%\Start\Project Report_template.docx" "%REPO%\docs\project_resources\Project Report_template.docx"

echo Copying report...

copy "%SRC%\G10_DL_Submission\G10_Project_Report.pdf" "%REPO%\docs\report\G10_Project_Report.pdf"
copy "%SRC%\G10_DL_Submission\G10_Project_Report___.docx" "%REPO%\docs\report\G10_Project_Report.docx"

echo Copying deployment notebook...

copy "%SRC%\G10_DL_Submission\G10_code\AES_System_AB.ipynb" "%REPO%\notebooks\deployment\AES_System_AB.ipynb"

echo Extracting code zip files...

python -m zipfile -e "%SRC%\G10_DL_Submission\G10_code\G10_Code_A.zip" "%TMP%\code_A"
python -m zipfile -e "%SRC%\G10_DL_Submission\G10_code\G10_Code_B.zip" "%TMP%\code_B"
python -m zipfile -e "%SRC%\G10_DL_Submission\G10_code\G10_Code_C.zip" "%TMP%\code_C"
python -m zipfile -e "%SRC%\G10_DL_Submission\G10_code\Example Data.zip" "%TMP%\examples"

echo Extracting model zip files...

python -m zipfile -e "%SRC%\G10_DL_Submission\G10_Models\G10_models_A.zip" "%TMP%\models_A"
python -m zipfile -e "%SRC%\G10_DL_Submission\G10_Models\G10_models_B.zip" "%TMP%\models_B"

echo Copying Approach A files...

for /r "%TMP%\code_A" %%F in (TrainingCodeA.ipynb) do copy "%%F" "%REPO%\notebooks\approach_A\TrainingCodeA.ipynb"
for /r "%TMP%\code_A" %%F in (*ImprovedCodeA*.ipynb) do copy "%%F" "%REPO%\notebooks\approach_A\ImprovedCodeA.ipynb"
for /r "%TMP%\code_A" %%F in (README_Approach_A.txt) do copy "%%F" "%REPO%\notebooks\approach_A\README_Approach_A.txt"
for /r "%TMP%\code_A" %%F in (Approach_A_ScoresTracking.xlsx) do copy "%%F" "%REPO%\results\approach_A\Approach_A_ScoresTracking.xlsx"

for /r "%TMP%\code_A" %%F in (*step_1*.csv) do copy "%%F" "%REPO%\results\approach_A\step1\"
for /r "%TMP%\code_A" %%F in (*step_2*.csv) do copy "%%F" "%REPO%\results\approach_A\step2\"

echo Copying Approach B files...

for /r "%TMP%\code_B" %%F in (TrainingCodeB.ipynb) do copy "%%F" "%REPO%\notebooks\approach_B\TrainingCodeB.ipynb"
for /r "%TMP%\code_B" %%F in (README_Approach_B.txt) do copy "%%F" "%REPO%\notebooks\approach_B\README_Approach_B.txt"
for /r "%TMP%\code_B" %%F in (Approach_B_ScoresTracking.xlsx) do copy "%%F" "%REPO%\results\approach_B\Approach_B_ScoresTracking.xlsx"

for /r "%TMP%\code_B" %%F in (*step_1*.csv) do copy "%%F" "%REPO%\results\approach_B\step1\"
for /r "%TMP%\code_B" %%F in (*step_2*.csv) do copy "%%F" "%REPO%\results\approach_B\step2\"
for /r "%TMP%\code_B" %%F in (*step 2*.csv) do copy "%%F" "%REPO%\results\approach_B\step2\"

echo Copying Approach C files...

if exist "%SRC%\G10_DL_Submission\G10_code\trainingCodeC.ipynb" (
    copy "%SRC%\G10_DL_Submission\G10_code\trainingCodeC.ipynb" "%REPO%\notebooks\approach_C\trainingCodeC.ipynb"
) else (
    for /r "%TMP%\code_C" %%F in (trainingCodeC.ipynb) do copy "%%F" "%REPO%\notebooks\approach_C\trainingCodeC.ipynb"
)

for /r "%TMP%\code_C" %%F in (README_Approach_C.txt) do copy "%%F" "%REPO%\notebooks\approach_C\README_Approach_C.txt"

echo Copying models...

for /r "%TMP%\models_A" %%F in (*.pt) do copy "%%F" "%REPO%\models\approach_A\"
for /r "%TMP%\models_B" %%F in (*.pt) do copy "%%F" "%REPO%\models\approach_B\"

echo Copying example data...

for /r "%TMP%\examples" %%F in (*.xls) do copy "%%F" "%REPO%\examples\"
for /r "%TMP%\examples" %%F in (*.xlsx) do copy "%%F" "%REPO%\examples\"
for /r "%TMP%\examples" %%F in (*.csv) do copy "%%F" "%REPO%\examples\"

echo Creating .gitignore...

(
echo __pycache__/
echo *.pyc
echo .ipynb_checkpoints/
echo .venv/
echo venv/
echo .DS_Store
echo Thumbs.db
echo *.zip
) > "%REPO%\.gitignore"

echo Creating requirements.txt...

(
echo numpy
echo pandas
echo torch
echo scikit-learn
echo transformers
echo tqdm
echo openpyxl
echo xlrd
echo jupyter
echo notebook
) > "%REPO%\requirements.txt"

echo Creating data README...

(
echo # Data
echo.
echo Place the dataset file here.
echo.
echo Expected file:
echo.
echo dataset.csv
echo.
echo This project uses ASAP and ASAP++ essay scoring data.
) > "%REPO%\data\README.md"

echo Creating main README.md...

(
echo # Cross-Prompt Automated Essay Scoring using Neural Models
echo.
echo This repository contains a deep learning project for Cross-Prompt Automated Essay Scoring.
echo.
echo The goal is to train models on essays from existing prompts and test whether they can score essays from a new unseen prompt without retraining on that prompt.
echo.
echo ## Project Idea
echo.
echo Automated Essay Scoring is the task of automatically predicting essay quality.
echo.
echo In this project, the model is trained on essays from 7 prompts and tested on essays from 1 unseen prompt.
echo.
echo ```text
echo Essays + Features -^> Model Training -^> Unseen Prompt Testing -^> Predicted Scores -^> QWK Evaluation
echo ```
echo.
echo ## Dataset
echo.
echo The project uses ASAP and ASAP++ essay scoring data.
echo.
echo Each essay contains:
echo.
echo - Essay text
echo - Prompt ID
echo - Holistic score
echo - Trait scores
echo - 86 prompt-independent features
echo.
echo The trait scores include Content, Organization, Word Choice, Sentence Fluency, Conventions, Prompt Adherence, Language, and Narrativity.
echo.
echo Expected dataset path:
echo.
echo ```text
echo data/dataset.csv
echo ```
echo.
echo ## Model Approaches
echo.
echo ### Approach A: FFN for Holistic Scoring
echo.
echo Input: 86 essay features  
echo Output: 1 holistic score
echo.
echo ### Approach B: FFN for Joint Scoring
echo.
echo Input: 86 essay features  
echo Output: 9 scores = 1 holistic score + 8 trait scores
echo.
echo ### Approach C: BERT + Features
echo.
echo Input: essay text + 86 features  
echo Output: 1 holistic score
echo.
echo Approach C was tested for Prompt 1 only.
echo.
echo ## Repository Structure
echo.
echo ```text
echo cross-prompt-aes/
echo ├── data/
echo ├── src/
echo ├── notebooks/
echo ├── models/
echo ├── results/
echo ├── examples/
echo └── docs/
echo ```
echo.
echo ## Important Files
echo.
echo src/general_utils.py contains utility functions for reading data, score ranges, and QWK evaluation.
echo.
echo notebooks/approach_A/TrainingCodeA.ipynb trains Approach A.
echo.
echo notebooks/approach_B/TrainingCodeB.ipynb trains Approach B.
echo.
echo notebooks/approach_C/trainingCodeC.ipynb trains Approach C.
echo.
echo notebooks/deployment/AES_System_AB.ipynb scores essays using deployed Approach A and B models.
echo.
echo ## Installation
echo.
echo ```cmd
echo python -m venv .venv
echo .venv\Scripts\activate
echo pip install -r requirements.txt
echo jupyter notebook
echo ```
echo.
echo ## Running in VSCode
echo.
echo Open this folder in VSCode:
echo.
echo ```cmd
echo code .
echo ```
echo.
echo If a notebook cannot find general_utils.py, add this near the top:
echo.
echo ```python
echo import sys
echo sys.path.append("../../src")
echo ```
echo.
echo If a notebook reads:
echo.
echo ```python
echo pd.read_csv("dataset.csv")
echo ```
echo.
echo change it to:
echo.
echo ```python
echo pd.read_csv("../../data/dataset.csv")
echo ```
echo.
echo ## Evaluation
echo.
echo The project uses leave-one-prompt-out cross-validation.
echo.
echo Train on 7 prompts and test on 1 unseen prompt.
echo.
echo The main metric is QWK, which means Quadratic Weighted Kappa.
echo.
echo Higher QWK means better agreement between model predictions and human scores.
echo.
echo ## Trained Models
echo.
echo Approach A models are stored in models/approach_A/
echo.
echo Approach B models are stored in models/approach_B/
echo.
echo The deployed models are model-A-deploy.pt and model-B-deploy.pt.
echo.
echo ## Results
echo.
echo Experiment results are stored in results/approach_A/ and results/approach_B/.
echo.
echo ## Project Documents
echo.
echo Final report is stored in docs/report/.
echo.
echo Original project resources are stored in docs/project_resources/.
echo.
echo ## Summary
echo.
echo This project compares feature-based feed-forward neural networks and a BERT-based model for scoring essays from unseen prompts.
) > "%REPO%\README.md"

echo Cleaning temporary folder...

rmdir /s /q "%TMP%"

echo.
echo Final project structure:
echo.

cd /d "%REPO%"
tree /f

echo.
echo Setup complete.
echo Repo created at:
echo %REPO%

endlocal