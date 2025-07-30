# Load required packages (skip if already loaded)
library(QCA)

# Load your data
data <- read.csv(file.choose(), header = TRUE)  # or specify the file directly

# Define conditions and outcome
conditions <- c("ApplicationFeeAllowed", "BroadbandEligible", "Defederalization", 
                "FlexibleTerms", "MultimodalEligible", "PrivateEligibility", 
                "PublicPrivateProjects", "RepaymentEnforced", "TeamExpertise", "LargeSIB")
outcome <- "P_cal"

# Step 1: Generate the truth table
tt <- truthTable(data, outcome = outcome, conditions = conditions, 
                 incl.cut = 0.8, show.cases = TRUE)
print(tt)

# Step 2: Complex solution
sol_complex <- minimize(tt, details = TRUE, show.cases = TRUE)
cat("\n--- Complex Solution ---\n")
print(sol_complex)

# Step 3: Parsimonious solution
sol_parsimonious <- minimize(tt, include = "?", details = TRUE, show.cases = TRUE)
cat("\n--- Parsimonious Solution ---\n")
print(sol_parsimonious)

# Step 4: Intermediate solution
dir.exp <- rep(1, length(conditions))
names(dir.exp) <- conditions
sol_intermediate <- minimize(tt, include = "?", dir.exp = dir.exp, details = TRUE, show.cases = TRUE)
cat("\n--- Intermediate Solution ---\n")
print(sol_intermediate)
