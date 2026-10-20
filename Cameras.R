############ Data Files ##############

dat <- read.csv("Cameras.csv")

############ Descriptives ############

table(dat$Gender)
table(dat$Age_category)
summary(dat$Pictures.per.week)
summary(dat$Videos.per.week)
summary(dat$BDM_minimum.for.giving.up.both.smartphone.cameras.for.1.month)

############ BDM #####################

share.BDM.obs <- matrix(c(c(1:100)*5, rep(0, 100)), nrow=100)

# calculate shares at price e
for(e in 1:100) {
  share <- prop.table(table(dat$BDM_minimum.for.giving.up.both.smartphone.cameras.for.1.month >= e*5))["TRUE"]
  share.BDM.obs[e,2] <- share
}

colnames(share.BDM.obs) <- c("E", "Share")
share.BDM.obs <- data.frame(share.BDM.obs)


# Fit multiplicative model to shares
model1 <- lm(log(share.BDM.obs$Share) ~ log(share.BDM.obs$E))
summary(model1)

# Calculate median valuation 
median.BDM <- exp((model1$coefficients[1] - log(0.5))/-model1$coefficients[2])
median.BDM

# Store predicted values
share.BDM.pred <- predict(model1, interval="prediction")
share.BDM.pred <- exp(share.BDM.pred)
share.BDM.pred <- cbind(share.BDM.obs$E, share.BDM.pred)
colnames(share.BDM.pred) <- c("E", "Share", "Lower", "Upper")
share.BDM.pred <- data.frame(share.BDM.pred)

### Plot results
# Plot observed shares
plot((share.BDM.obs$E) ~ I(share.BDM.obs$Share * 100), xaxt="n", col="black", pch=20, lty=2, type="l", xlab="% keep Camera", ylab="E in €", xlim=c(0,100), ylim=c(0,500))
axis(side = 1, at = (0:10)*10)

# Plot predicted shares (without shares > 1)
lines(share.BDM.pred$E[which(share.BDM.pred$Share <= 1)] ~ I(share.BDM.pred$Share[which(share.BDM.pred$Share <= 1)] * 100), col="black", lty=1)
lines(share.BDM.pred$E[which(share.BDM.pred$Upper <= 1)] ~ I(share.BDM.pred$Upper[which(share.BDM.pred$Upper <= 1)] * 100), col="black", lty=3)
lines(share.BDM.pred$E[which(share.BDM.pred$Lower <= 1)] ~ I(share.BDM.pred$Lower[which(share.BDM.pred$Lower <= 1)] * 100), col="black", lty=3)

legend('topright', c("Observed", "Fitted", "95% Interval"), col=c('black', 'black', 'black'), bty='n', lty = c(2, 1, 3), cex=1)
