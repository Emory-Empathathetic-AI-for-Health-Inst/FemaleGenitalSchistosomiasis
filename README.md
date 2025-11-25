# FGS Detection Repository

This repository contains feature files and code used in the manuscript on **FGS detection**.

## 📂 Repository Contents

- **Ensemble_model.ipynb**  
  Jupyter Notebook implementing the ensemble model used in the final classification.

- **environment.yml**  
  Conda environment file to install all required dependencies.

- **specular_reflection_mask_estimation.m**  
  MATLAB code to compute the specular reflection mask.

## ⚙️ Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/fgs-detection.git
   cd fgs-detection
   
2.Create the Conda environment:
  ```bash
   conda env create -f environment.yml
   conda activate my_env
3. Open the Jupyter Notebook:
  ```bash
    jupyter lab
- Then run Ensemble_model.ipynb.
🧾 Notes
- The MATLAB script (specular_reflection_mask_estimation.m) requires MATLAB installed locally.
- The environment file ensures reproducibility of results by installing the exact dependencies.


