
# Load necessary libraries
library(survival)
library(netmeta)
library(dplyr)
library(tidyr)
library(ggplot2)

# Read the dataset
data <- read.csv("simulated_survival_data.csv")

# View first few rows
head(data)

# Basic Cox proportional hazards model
cox_model <- coxph(Surv(time, event) ~ treatment + age, data = data)
summary(cox_model)

# Summarize survival outcomes by study and treatment
summary_table <- data %>%
  group_by(study_id, treatment) %>%
  summarise(events = sum(event),
            person_time = sum(time),
            .groups = 'drop')

# Print summary table
print(summary_table)

# Prepare pairwise data for network meta-analysis
pw_data <- pairwise(treat = treatment,
                    event = event,
                    n = rep(100, nrow(data)),
                    studlab = study_id,
                    data = data,
                    sm = "HR")

# Run network meta-analysis
net <- netmeta(TE = pw_data$TE,
               seTE = pw_data$seTE,
               treat1 = pw_data$treat1,
               treat2 = pw_data$treat2,
               studlab = pw_data$studlab,
               sm = "HR",
               comb.fixed = TRUE,
               comb.random = TRUE)

# View network meta-analysis results
summary(net)

# Plot network
netgraph(net, thickness = "seTE", multiarm = TRUE)

# Forest plot of treatment effects
forest(net, ref = "A")
