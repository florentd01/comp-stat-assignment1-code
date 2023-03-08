data <- read.csv('C:/users/Test user/OneDrive/UM/Comp_Stat/Assignment_1/a1_data.csv', header = TRUE)

edges1 <- c()
edges2 <- c()
alpha <- 0.05
for (i in colnames(data)) {
  for (j in colnames(data)) {
    if (i != j && i < j){
      datx <- data[[j]]
      daty <- data[[i]]
      correl <- cor.test(datx, daty, method = c('pearson'))
      p_value <- correl$p.value
      if (p_value < alpha) {
        edges1 <- append(edges1, i)
        edges2 <- append(edges2, j)
      }
    }
  }
}

parent_nodes <- c()
child_nodes <- c()
for (i in 1:length(edges1)) {
  dat1 <- data[[edges1[i]]]
  dat2 <- data[[edges2[i]]]
  res.ftest <- var.test(dat1, dat2, data=data, alternative = 'less')
  if (res.ftest$estimate < 1) {
    parent_nodes <- append(parent_nodes, edges1[i])
    child_nodes <- append(child_nodes, edges2[i])
  } else {
    parent_nodes <- append(parent_nodes, edges2[i])
    child_nodes <- append(child_nodes, edges1[i])
  }
}



for (i in 1:42) {
  print(paste(parent_nodes[i], ' ', child_nodes[i]))
}
