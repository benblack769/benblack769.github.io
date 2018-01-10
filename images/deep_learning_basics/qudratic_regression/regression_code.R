library(tidyverse)

len = 20
start = -3
end = 8
x_values = rnorm(len,mean=3,sd=2)
y_values = x_values^2 + rnorm(len)*(x_values + 3)

raw_data = data.frame(x_values,y_values)

regression = function(ps){
  ggplot(ps,aes(x=x_values,y=y_values)) +
   geom_point() +
   geom_smooth(method="lm",formula=y~I(x^2)+x)
}
valuation = function(x_values,coefs){
  coefs[1] + coefs[2] * x_values + coefs[3] * x_values^2
}
coef_cost = function(ps,coefs){
  sum((valuation(ps$x_values, coefs) - ps$y_values)^2)
}
coefs_differnetial = function(ps,coefs){
  cost = coef_cost(ps,coefs)
  a = coefs[3]
  b = coefs[2]
  c = coefs[1]
  x = ps$x_values
  y = ps$y_values
  coefs_diff = numeric(3)
  inner_val = (c+b*x+a*x^2-y)
  coefs_diff[1] = sum(2*inner_val)
  coefs_diff[2] = sum(2*x*inner_val)
  coefs_diff[3] = sum(2*x^2*inner_val)
  coefs_diff
}
plot_function = function(coefs){
  x_points = runif(100,min=start,max=end)
  y_points = valuation(x_points,coefs)
  point_data = data.frame(x_points,y_points)
  geom_line(data=point_data,mapping=aes(x=x_points,y=y_points))
}
plot_overlayed = function(){
  ggplot(raw_data,aes(x=x_values,y=y_values)) +
    geom_point()# + 
    #geom_smooth(method="lm", formula=y~I(x^2)+x)
}
cur_plot = plot_overlayed() 
start_coefs = c(0,0.11,3)
cur_plot = cur_plot + plot_function(start_coefs)
for(x in 1:10){
  new_coefs = start_coefs - 0.00002 * coefs_differnetial(raw_data,start_coefs)
  start_coefs = new_coefs
  cur_plot = cur_plot + plot_function(new_coefs)
  print(coef_cost(raw_data,new_coefs))
  print(start_coefs)
}
cur_plot
cur_plot + geom_smooth(method="lm", formula=y~I(x^2)+x)

ggsave("regression.png",plot=regression(data))

