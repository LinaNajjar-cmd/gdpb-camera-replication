# GDP-B smartphone-camera study: sensitivity extension
# Research Methods I, University of Exeter — Tutorial 2, October 2026
# Original paper: Brynjolfsson et al. (2025), AEJ: Macroeconomics
# Original replication archive: https://doi.org/10.3886/E209901V1
#
# Prerequisite: Keep Cameras.R and Cameras.csv in the same working folder.
# To run, use RStudio: Session > Set Working Directory > To Source File Location;
# then source("Cameras_extension.R").

# Run the authors' original script if baseline estimates are not already loaded.
if (!exists("share.BDM.obs") || !exists("model1") || !exists("median.BDM")) {
  source("Cameras.R")
}

# Change one modelling choice: compensation range used for fitting.
# The same 213 respondents and empirical shares are retained.
extension_data <- subset(share.BDM.obs, E <= 250)
model_extension <- lm(log(Share) ~ log(E), data = extension_data)

median_extension <- exp(
  (coef(model_extension)[1] - log(0.5)) / (-coef(model_extension)[2])
)

comparison <- data.frame(
  Specification = c("Original: EUR 5-500", "Extension: EUR 5-250"),
  Median_WTA_EUR = round(c(as.numeric(median.BDM), as.numeric(median_extension)), 2)
)

cat("\n=== GDP-B: CAMERA WTA REPLICATION + EXTENSION ===\n")
cat("Survey respondents:", nrow(dat), "\n")
cat("Raw median bid: EUR", median(dat$BDM_minimum.for.giving.up.both.smartphone.cameras.for.1.month), "\n")
print(comparison, row.names = FALSE)
cat("Change: EUR", round(as.numeric(median_extension - median.BDM), 2), "\n")
cat("Percent change:", round(100 * as.numeric(median_extension - median.BDM) / as.numeric(median.BDM), 2), "%\n")
cat("Original R-squared:", round(summary(model1)$r.squared, 3), "\n")
cat("Extension R-squared:", round(summary(model_extension)$r.squared, 3), "\n")

# Make an extension comparison graph using BASE R only (no external packages).
offers <- seq(5, 250, by = 5)
share_original <- exp(coef(model1)[1] + coef(model1)[2] * log(offers))
share_extension <- exp(coef(model_extension)[1] + coef(model_extension)[2] * log(offers))

png("Extension_comparison.png", width = 1500, height = 950, res = 160)
plot(offers, 100 * share_original, type = "l", lwd = 3,
     col = "#1e4c43", xlim = c(0, 250), ylim = c(0, 100),
     xlab = "Compensation offered (EUR)", ylab = "Predicted share keeping camera (%)",
     main = "Sensitivity of fitted camera valuation")
lines(offers, 100 * share_extension, lwd = 3, col = "#c6734e")
abline(h = 50, lty = 3, col = "grey45")
abline(v = as.numeric(median.BDM), lty = 3, col = "#1e4c43")
abline(v = as.numeric(median_extension), lty = 3, col = "#c6734e")
legend("topright", c("Original: EUR 5-500", "Extension: EUR 5-250"),
       col = c("#1e4c43", "#c6734e"), lwd = 3, bty = "n")
dev.off()

write.csv(comparison, "Extension_results.csv", row.names = FALSE)
cat("Saved Extension_comparison.png and Extension_results.csv.\n")
cat("Interpretation: specification sensitivity, NOT a change in respondents' welfare.\n")
