# Rastrigin Function Optimization Using Metaheuristics

This repository contains MATLAB implementations of three population-based metaheuristic algorithms—Genetic Algorithm (GA), Differential Evolution (DE), and Particle Swarm Optimization (PSO)—to minimize the 2D Rastrigin function.

---

## 📌 Objective

Minimize the Rastrigin function:
\[
f(x, y) = 20 + x^2 + y^2 - 10[\cos(2πx) + \cos(2πy)]
\]
within the domain \(-5.12 ≤ x, y ≤ 5.12\), using GA, DE, and PSO, and compare their convergence behavior.

---

## 📁 Contents

- `GA_Rastrigin.m`: MATLAB script for GA implementation
- `DE_Rastrigin.m`: MATLAB script for DE implementation
- `PSO_Rastrigin.m`: MATLAB script for PSO implementation
- `rastrigin.m`: The Rastrigin benchmark function
- `CompareConvergence.m`: Script to visualize convergence plots of GA, DE, and PSO
- `*.csv`: Generation-wise best fitness data for each method
- `/results`: Includes all convergence and surface plots

---

## 🚀 How to Run

1. Open MATLAB and navigate to the project folder.
2. Run any of the following scripts:
   - `GA_Rastrigin.m`
   - `DE_Rastrigin.m`
   - `PSO_Rastrigin.m`
3. Use `CompareConvergence.m` to visualize performance comparison.

---

## 📊 Output

- Individual convergence graphs
- Combined convergence plot
- Raw fitness data saved as CSV
- Surface plot of the Rastrigin function

---

## 🔬 Results Summary

| Algorithm | Best Fitness        | Convergence Generation |
|-----------|---------------------|-------------------------|
| GA        | 0.7568200000        | N/A                     |
| DE        | 0.0000058577        | 77                      |
| PSO       | 0.0000000052        | 32                      |

---

## 🧠 Insights

- **PSO** converges fastest and most accurately.
- **DE** offers steady and robust optimization.
- **GA** is effective early but requires enhancements to avoid stagnation.

---

## 📄 License

MIT License. Feel free to modify and use for research or academic purposes.
