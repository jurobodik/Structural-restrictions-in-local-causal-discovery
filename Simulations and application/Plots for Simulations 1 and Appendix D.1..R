################## Simulations 1 #######################################
# running this first part should give you the Figure from Simulation 1 

transmission_function <- function(x){
  if (x=="") return(0)
  if (x=="X1" || x=="X2") return(1)
  if (x=="X1 X2") return(2)
}

n=500
result = list()
for (gamma in seq(0,1,by=0.2)) {
  result_gamma = list()
for (c in seq(0,0.9,by=0.3)) { 
  result_gamma_c = c()
  for (number_of_repetitions in 1:50) {
    
  Sigma <- matrix(c(1,c,c,1),2,2); v = mvrnorm(n, rep(0, 2), Sigma)
  
  X1 = v[,1];X2 = v[,2]
  f1 = random_function_1d()
  f2 = random_function_1d()
  f =  random_function_2d()
  Y = evaluation_of_f_1d(f, X1) + evaluation_of_f_1d(f, X2) + gamma*evaluation_of_f_2d(f,X1, X2) + rnorm(n) 

  parents = F_identifiable_set_of_parents(Y=Y, X=as.data.frame(cbind(X1, X2)), constraint_set_F="Additive")
  result_gamma_c = c(result_gamma_c, transmission_function(parents$p.values[6]))
  }
  print(c)
  result_gamma = c(result_gamma, mean(result_gamma_c))
  
}
  result[[5*gamma+1]] = result_gamma
  }

result

r=list()
for (i in 1:4) {vector = c()
 for (j in 1:6)  vector = c(vector, result[[j]][[i]])
  r[[i]] =  vector 
}

s=seq(0,1,by=0.2)
plot(unlist( r[[1]] )~s, type = 'l', col = 1, lwd=2, xlab = expression(gamma), ylab = "Number of discovered parents", ylim = c(0,2))
for (i in 2:4) lines(unlist( r[[i]] )~s, type = 'l', col = i, lwd=2)
legend(
  "topleft",
  col = c(1,2,3,4),
  legend = c(0, 0.3, 0.6, 0.9),
  lwd = 2,
  title="c"
)


################## Plots in Appendix D.1 ############################
#Running this code should give you the Figures from Appendix D.1.


par(mfrow = c(1, 2))

set.seed(2)

n=1000

X1 = rnorm(n)
f1 = random_function_1d()
Y1 = evaluation_of_f_1d(f1, X1)  + 0*rnorm(n)

plot(Y1~X1, ylab = 'Y', main = 'First example')

set.seed(5)

n=1000

X1 = rnorm(n)
f1 = random_function_1d()
Y1 = evaluation_of_f_1d(f1, X1)  + 2*rnorm(n)

plot(Y1~X1, ylab = 'Y', main = 'Second example')


#################
#################
#################
set.seed(12)

n=1000

X1 = rnorm(n)
X2 = rnorm(n)
f2 = random_function_2d()
Y = evaluation_of_f_2d(f2, X1, X2)  + rnorm(n) 

plot_the_function_2d(f2)
plot3d(x=X1, y=X2, z=Y)

#################
#################
#################
set.seed(3)

n=1000

X1 = rnorm(n)
X2 = rnorm(n)
X3 = rnorm(n)
f3 = random_function_3d()
Y = evaluation_of_f_3d(f3, X1, X2, X3)  + rnorm(n) 

plot3d(x=X1, y=X2, z=Y)
plot3d(x=X1, y=X3, z=Y)
plot3d(x=X2, y=X3, z=Y)
