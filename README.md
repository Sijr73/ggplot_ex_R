# PlantGrowth ggplot2 Exercise

---

## Dataset

The `PlantGrowth` dataset (base R) contains:

Load the data:

```r
library(tidyverse)
data(PlantGrowth)
glimpse(PlantGrowth)
```

---

## Tasks

### 1. Summary of the data

1. Compute, **by group**, the mean and standard deviation of `weight`.
2. Report the sample size for each group (hint: `n()`).
3. Based on these summaries, which treatment appears to increase plant weight the most?

---

### 2. Basic Boxplot

- Create a boxplot of `weight` by `group`.
- Add a descriptive title and axis labels with `labs()`.
- Flip the axes so that the groups are on the y-axis (`coord_flip()`).

---

### 3. Jitter + Boxplot

- Overlay the raw data points on the boxplot using `geom_jitter(width = 0.2)`.
- Adjust transparency of the box (`alpha`) and add a clean theme (e.g. `theme_minimal()`).

---

### 4. Histogram & Density

1. Plot a histogram of all `weight` values (10 bins; choose fill and border colors).
2. On the same plot, overlay density curves for each `group` (`aes(fill = group)`, `alpha = 0.4`).
3. Ensure the y-axis reflects count (use `..count..` for density).

---

### 5. Bar Plot of Means with Error Bars

1. Summarize the data: compute mean ± standard error (SE = sd / √n) of `weight` for each group.
2. Create a bar chart of mean weight by group (`geom_col()`).
3. Add error bars showing ±1 SE (`geom_errorbar()`).
4. Include a title and axis labels; experiment with `theme_classic()`.





