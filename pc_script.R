library(pcalg)
data <- read.csv('C:/users/Test user/OneDrive/UM/Comp_Stat/Assignment_1/a1_data.csv', header = TRUE)
dag <- pc(suffStat = list(C = cor(data)), indepTest = gaussCItest,p=ncol(data), alpha = 0.05)

suffstat <- list(C = cor(data), n = nrow(data)) 
pc.data <- pc(suffstat,indepTest=gaussCItest, p=ncol(data),alpha=0.05)
plot(pc.data)



