library(ggplot2)
library(dplyr)

years=read.csv('data/importance/1999.csv')
yearlist=c('X1999')
for (i in 2000:2017) {
  a='data/importance/'
  b=as.character(i)
  c='.csv'
  s=paste0(a,b,c)
  df=read.csv(s)
  years=merge(years,df,all=TRUE,by='feature')
  yearlist<-c(yearlist,paste0('X',b))
}
years[is.na(years)]<-0
midware <- years[, (names(years) %in% c('feature',yearlist))]
midware2<-mutate(midware,sum=rowSums(midware[,2:20]))
badword=c('worst','bad','terrible','waste','awful','boring','crap','horrible','stupid','poor','waste time','worse','disappointment')
goodword=c('great','best','good','love','believe','like')
neuter=c('movie','spoilers','film','money','time','just','supposed','thing','contains','watch','series','screenwritters','plot','really','spoiler','way','trying')
pic=t(midware)
pic<-data_frame(pic)
name<-midware$feature
pic <- as.data.frame(t(midware[,-1]))
colnames(pic) <- name
pic$myfactor <- factor(row.names(pic))
year=c(1999:2017)
pic<-cbind(pic,year)
plot1<-pic[, (names(pic) %in% c(goodword,'year'))]
plot11<-melt(plot1,id='year.1') %>% filter(.,variable!='year')
plot2<-pic[, (names(pic) %in% c(badword,'year'))]
plot22<-melt(plot2,id='year.1')%>% filter(.,variable!='year')
plot3<-pic[, (names(pic) %in% c(neuter,'year'))]
plot33<-melt(plot3,id='year.1')%>% filter(.,variable!='year')
style <-theme(
  plot.background = element_rect(
    fill = '#282B30', colour = '#282B30'),
  panel.background = element_rect(
    fill = "#282B30", colour = '#686868'),
  panel.grid.major = element_line(colour = '#686868'),
  panel.grid.minor = element_line(colour = '#686868'),
  axis.title = element_text(color = '#989898', size = 15), 
  axis.text = element_text(color = '#989898', size = 10),
  plot.title = element_text(
    color = '#989898', size = 18,hjust = 0.5), 
  legend.background = element_rect(
    fill = '#282B30', colour = '#282B30'),
  legend.text = element_text(color = '#989898', size = 10),
  legend.title = element_text(color = "#989898",size = 12) )

ggplot(plot11, aes(x=year.1,y=value,color=variable, fill=variable))+ 
  geom_col(alpha=0.55)+
  guides(fill=guide_legend(title = 'key word'),color=guide_legend(title = 'key word'))+
  style+
  labs(x = "Years", y = "feature importance",
       title = "Feature Importance of The Random Forest Classifier (Positive Words)")
ggplot(plot22, aes(x=year.1,y=value,color=variable, fill=variable))+ 
  geom_col(alpha=0.55)+
  guides(fill=guide_legend(title = 'key word'),color=guide_legend(title = 'key word'))+
  style+
  labs(x = "Years", y = "feature importance",
       title = "Feature Importance of the Random Forest Classifier (Negative Words)")
ggplot(plot33, aes(x=year.1,y=value,color=variable, fill=variable))+ 
  geom_col(alpha=0.55)+
  guides(fill=guide_legend(title = 'key word'),color=guide_legend(title = 'key word'))+
  style+
  labs(x = "Years", y = "feature importance",
       title = "Feature Importance of the Random Forest Classifier (Neuter Words)")
