# PlantGrowth ggplot2 Exercise

This \~30 minute exercise will guide you through exploratory data analysis and visualization of the **PlantGrowth** dataset using **ggplot2**.

---

## Dataset

The `PlantGrowth` dataset (base R) contains:

| Variable | Type    | Description                      |
| -------- | ------- | -------------------------------- |
| `weight` | numeric | Dry weight of each plant (grams) |
| `group`  | factor  | Treatment group:                 |
|          |         | • `ctrl`  = control fertilizer   |
|          |         | • `trt1`  = treatment 1          |
|          |         | • `trt2`  = treatment 2          |

Load the data:

```r
library(tidyverse)
data(PlantGrowth)
glimpse(PlantGrowth)
```

---

## Tasks

### 1. Summary Statistics (5 min)

1. Compute, **by group**, the mean and standard deviation of `weight`.
2. Report the sample size for each group (hint: `n()`).
3. Based on these summaries, which treatment appears to increase plant weight the most?

---

### 2. Basic Boxplot (5 min)

- Create a boxplot of `weight` by `group`.
- Add a descriptive title and axis labels with `labs()`.
- Flip the axes so that the groups are on the y-axis (`coord_flip()`).

---

### 3. Jitter + Boxplot (5 min)

- Overlay the raw data points on the boxplot using `geom_jitter(width = 0.2)`.
- Adjust transparency of the box (`alpha`) and add a clean theme (e.g. `theme_minimal()`).

---

### 4. Histogram & Density (5 min)

1. Plot a histogram of all `weight` values (10 bins; choose fill and border colors).
2. On the same plot, overlay density curves for each `group` (`aes(fill = group)`, `alpha = 0.4`).
3. Ensure the y-axis reflects count (use `..count..` for density).

---

### 5. Bar Plot of Means with Error Bars (8 min)

1. Summarize the data: compute mean ± standard error (SE = sd / √n) of `weight` for each group.
2. Create a bar chart of mean weight by group (`geom_col()`).
3. Add error bars showing ±1 SE (`geom_errorbar()`).
4. Include a title and axis labels; experiment with `theme_classic()`.

---

### 6. Bonus Customization (if time allows)

- Apply a custom color palette with `scale_fill_manual()`.
- Try different themes: `theme_bw()`, `theme_light()`, etc.
- Annotate the plot (e.g. label the tallest bar with `annotate("text", …)`).

---

## Submission

- **R script** or **RMarkdown** containing all code.
- **PNG** (or **PDF**) of each of your six plots.
- *(Optional)* A brief note (2–3 sentences) on which visualization you found most effective, and why.

Good luck and happy plotting! 🎨🚀

