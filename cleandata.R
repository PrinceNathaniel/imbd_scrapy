library(tidyr)
library(dplyr)
library(ggplot2)
df=read.csv('data/data.csv')
colnames(df2)
unique(df$Rank)
rank<-df3 %>% group_by(Rank) %>% summarise(n=n())
df1<-df[1:939,]
df2<-df[941:40238,]
df.size()
dim(df)
names(df2)[names(df2)=='class']='Rank'
names(df2)[names(df2)=='Rank']='Review'
df3<-rbind(df1,df2)
filter(df3,df3$Rank=='Rank')
df4<-df3 %>% filter(df3$Rank!='Rank')
df5<- df4 %>% filter(df4$Rank!='5' & df4$Rank!='6')
df6<- df5 %>% mutate(class=1)
df6$class[df6$Rank %in% c('1','2','3','4')] <- 0
class<-df6 %>% group_by(class) %>% summarise(n=n())
year<-df6 %>% group_by(Year) %>% summarise(n=n())
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
ggplot(data=year,aes(x=Year,y=n,group=1))+geom_line()
write.csv(df6,file='data2.csv')
####pic
df=read.csv('data/data2.csv')
nchar(as.character(df$Review[1]))
df2 <- df %>% mutate(length=nchar(as.character(df$Review)))
df3 <- df2 %>% group_by(Year) %>% summarise(n=n(),meanlen=mean(length))
p<-ggplot(df3,aes(x=Year))+geom_col(alpha=0.55,aes(y=n),color= "royalblue",fill= "royalblue")+geom_line(alpha=0.55,aes(y=meanlen*2.5),color='navy',size=2)
p<-p + scale_y_continuous(sec.axis = sec_axis(~./2.5, name = "mean length of reviews"))
p <- p + scale_fill_brewer(
  palette = "Blues") 
p <- p + labs(y = "number of reviews",
              x = "year",color='Parameter')
p <- p + theme(legend.position = c(0.8, 0.9))+style
p
