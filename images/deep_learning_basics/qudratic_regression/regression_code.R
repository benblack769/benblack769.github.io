
library(tidyverse)

len = 40
start = -3
end = 8

num_frames = 60
num_stocastic_frames = 1000
draw_stocastic_frams = 20
gradient_update = 0.00001

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
plot_function = function(coefs,framenum){
  x_points = runif(80,min=start,max=end)
  y_points = valuation(x_points,coefs)
  point_data = data.frame(x_points,y_points)
  geom_line(data=point_data,mapping=aes(x=x_points,y=y_points),alpha=0.2)# + 0.2 * (1-(framenum/num_frames)))
}
plot_overlayed = function(){
  ggplot(raw_data,aes(x=x_values,y=y_values)) +
    geom_point()# + 
    #geom_smooth(method="lm", formula=y~I(x^2)+x)
}

get_plot = function(start_coefs, grad_vec){
  cur_plot = plot_overlayed() 
  cur_plot = cur_plot + plot_function(start_coefs,0)
  for(x in 1:num_frames){
    new_coefs = start_coefs - gradient_update * grad_vec * coefs_differnetial(raw_data,start_coefs)
    start_coefs = new_coefs
    cur_plot = cur_plot + plot_function(new_coefs,x)
    print(coef_cost(raw_data,new_coefs))
    print(start_coefs)
  }
  regreessed_plot = cur_plot + geom_smooth(method="lm", formula=y~I(x^2)+x,se=FALSE)
  regreessed_plot
}

ggsave("points.png",plot=plot_overlayed())
plot_all = function(grad_vec){ 
  plot1 = get_plot(c(0,0.11,3),grad_vec)
  plot2 = get_plot(c(30,10,0),grad_vec)
  plot3 = get_plot(c(2,1,-1),grad_vec)
  
  grad_str = paste(grad_vec,collapse="")
  
  ggsave(paste("plot1",grad_str,".png",collapse=""),plot=plot1)
  ggsave(paste("plot2",grad_str,".png",collapse=""),plot=plot2)
  ggsave(paste("plot3",grad_str,".png",collapse=""),plot=plot3)
}
plot_all(c(1,1,1))
plot_all(c(100,10,1))

get_parameter_space_walk = function(){
  start_coefs = c(30,10,0)
  arg = data.frame(c=30,b=10,a=0)
  for(x in 1:num_frames){
    new_coefs = start_coefs - gradient_update * c(100,10,1) * coefs_differnetial(raw_data,start_coefs)
    start_coefs = new_coefs
    arg = rbind(arg,new_coefs)
  }
  ggplot(arg,aes(x=a,y=b,size=c)) + 
    #scale_fill_grey() + 
    geom_point()
}
ggsave("param_space_walk.png",plot=get_parameter_space_walk())


get_cost_decline = function(){
  start_coefs = c(30,10,0)
  arg = data.frame(time=0,cost=coef_cost(raw_data,start_coefs))
  for(x in 1:num_frames){
    new_coefs = start_coefs - gradient_update * c(100,10,1) * coefs_differnetial(raw_data,start_coefs)
    start_coefs = new_coefs
    arg = rbind(arg,c(x,coef_cost(raw_data,start_coefs)))
  }
  ggplot(arg,aes(x=time,y=cost)) + 
    #scale_fill_grey() + 
    geom_line()
}
ggsave("get_cost_decline.png",plot=get_cost_decline())

## Stocastic gradient descent 

# 
# get_socastic_plot = function(start_coefs){
#   cur_plot = plot_overlayed() 
#   cur_plot = cur_plot + plot_function(start_coefs,0)
#   for(x in 1:num_stocastic_frames){
#     data_entry = raw_data[sample(1:len,1),]
#     new_coefs = start_coefs - gradient_update * c(100,10,1) * coefs_differnetial(data_entry,start_coefs)
#     start_coefs = new_coefs
#     if(x%%(num_stocastic_frames/draw_stocastic_frams) == 0){
#       cur_plot = cur_plot + plot_function(new_coefs,x)
#       print(coef_cost(raw_data,new_coefs))
#       print(start_coefs)
#     }
#   }
#   regreessed_plot = cur_plot + geom_smooth(method="lm", formula=y~I(x^2)+x,se=FALSE)
#   regreessed_plot
# }
# 
# plot1 = get_socastic_plot(c(0,0.11,3))
# plot2 = get_socastic_plot(c(30,10,0))
# plot3 = get_socastic_plot(c(2,1,-1))
# 
# ggsave("stoc_plot1.png",plot=plot1)
# ggsave("stoc_plot2.png",plot=plot2)
# ggsave("stoc_plot3.png",plot=plot3)
# 
