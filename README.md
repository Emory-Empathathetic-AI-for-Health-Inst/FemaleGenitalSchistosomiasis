# FGS Detection Repository

This repository contains the feature files and code used in the manuscript on **Female Genital Schistosomiasis (FGS) detection** using ensemble deep learning models and pre-processing techniques.

## 📂 Repository Contents

- **Ensemble_model.ipynb**  
  Jupyter Notebook implementing the ensemble model used for final FGS classification.

- **environment.yml**  
  Conda environment file containing all dependencies required to reproduce the results.

- **specular_reflection_mask_estimation.m**  
  MATLAB script for computing the specular reflection mask used during preprocessing.

## ⚙️ Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/your-username/fgs-detection.git
cd fgs-detection
```

### 2. Create and activate the Conda environment
```bash
conda env create -f environment.yml
conda activate my_env
```

### 3. Launch Jupyter Lab
```bash
jupyter lab
```

### 4. Run the Notebook
Open and execute **Ensemble_model.ipynb** to reproduce the model training and evaluation.

### 🧾 Notes

- The MATLAB script (**specular_reflection_mask_estimation.m**) requires a local installation of **MATLAB**.
- The provided **Conda environment** ensures reproducibility by installing the exact versions of all required libraries.

## 🧾 Citation

If you use this repository or any associated methods in your research, please cite:

```
'link coming soon
```




