#===================================================================================
#��������ҵ
#===================================================================================
setwd("C:\\Users\\Administrator\\Desktop\\suyao")
mydata<-read.table("suyaoR.csv",header=TRUE,sep=",")#��������
#------------------------------------------------------------------------------------
#���ݴ�����
#------------------------------------------------------------------------------------
id<-c(1:1663)
mydata<-data.frame(id,mydata)                       #���ÿ������id
#------------------------------------------------------------------------------------
mydata$out<-factor(mydata$out,order=FALSE)          #���˳���ʽ��������Ϊ��������������
mydata$Hytype<-factor(mydata$Hytype,order=FALSE)    #����ҵ������������Ϊ��������������
mydata$year<-factor(mydata$year,order=FALSE)        #����¶�����������Ϊ��������������

#------------------------------------------------------------------------------------
mydata$Camp<-log(mydata$Camp)                       #���г�����������ȡ����
#mydata$condi<-log(mydata$condi)                     #���Ƴ�����������ȡ����

mydata$NrmOutDeg<-scale(mydata$NrmOutDeg,center=T,scale=T)
#mydata$NrmOutDeg<-ifelse((mydata$NrmOutDeg)<0,0,mydata$NrmOutDeg)
mydata$NrmInDeg<-scale(mydata$NrmInDeg,center=T,scale=T)
#mydata$NrmInDeg<-ifelse((mydata$NrmInDeg)<0,0,mydata$NrmInDeg)
mydata$NrmDegree<-scale(mydata$NrmDegree,center=T,scale=T)
#mydata$NrmDegree<-ifelse((mydata$NrmDegree)<0,0,mydata$NrmDegree)
mydata$nBetweenness<-scale(mydata$nBetweenness,center=T,scale=T)
#mydata$nBetweenness<-ifelse((mydata$nBetweenness)<0,0,mydata$nBetweenness)
mydata$condi<-scale(mydata$condi,center=T,scale=T)
mydata$condi<-ifelse((mydata$condi)<0,0,mydata$condi)
mydata$expe<-scale(mydata$expe,center=T,scale=T)
mydata$expe<-ifelse((mydata$expe)<0,0,mydata$expe)
#------------------------------------------------------------------------------------
summary(mydata)                                     #������Դmydata����������ͳ��
#------------------------------------------------------------------------------------
set.seed(1234)                                      #�������������Ϊ1234
mydata1<-mydata[sample(1663,1200),]                 
mydata1<-rbind(mydata1,mydata[294,])                #��ȡ��ģ���ݼ�mydata1��1201������

mydata2<-mydata[!mydata$id%in%mydata1$id,]          #�������Լ����ݼ�mydata2Ϊʣ��462������
#-------------------------------------------------------------------------------------
#ģ�͹���
#-------------------------------------------------------------------------------------
suyao1<-glm(out~NrmInDeg+expe+Tztype+times+condi+Hytype+year,data=mydata1,family=binomial(probit),control=list(maxit=100))
summary(suyao1)                                     #ģ��һ��NrmInDegΪ���ͱ���ʱ
suyao12<-glm(out~NrmInDeg+expe+Tztype+times+condi+Hytype+year,data=mydata1,family=binomial(probit),control=list(maxit=100))
summary(suyao12)
#-------------------------------------------------------------------------------------
suyao2<-glm(out~NrmOutDeg+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata1,family=binomial(probit),control=list(maxit=100))
summary(suyao2)                                     #ģ�Ͷ���MrmOutDegΪ���ͱ���ʱ
#-------------------------------------------------------------------------------------
suyao3<-glm(out~NrmDegree+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata1,family=binomial(probit),control=list(maxit=100))
summary(suyao3)                                     #ģ������NrmDegreeΪ���ͱ���ʱ
#-------------------------------------------------------------------------------------
suyao4<-glm(out~nBetweenness+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata1,family=binomial(probit),control=list(maxit=100))
summary(suyao4)                                     #ģ���ģ�nBetWeennessΪ���ͱ���ʱ
#=====================================================================================
#ģ�ͼ��飨��������
#=====================================================================================
suyao11<-glm(out~NrmInDeg+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata2,family=binomial(probit),control=list(maxit=100))
suyao11pre<-ifelse(predict(suyao11)>0,"1","0")
table(mydata2$out,suyao11pre)                       #ģ��һ��������
suyao121<-glm(out~NrmInDeg+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata2,family=binomial(probit),control=list(maxit=100))
suyao121pre<-ifelse(predict(suyao121)>0,"1","0")
table(mydata2$out,suyao121pre)
#-------------------------------------------------------------------------------------
suyao22<-glm(out~NrmOutDeg+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata2,family=binomial(probit),control=list(maxit=100))
suyao22pre<-ifelse(predict(suyao22)>0,"1","0")
table(mydata2$out,suyao22pre)                       #ģ�Ͷ���������
#-------------------------------------------------------------------------------------
suyao33<-glm(out~NrmDegree+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata2,family=binomial(probit),control=list(maxit=100))
suyao33pre<-ifelse(predict(suyao33)>0,"1","0")
table(mydata2$out,suyao33pre)                       #ģ������������
#-------------------------------------------------------------------------------------
suyao44<-glm(out~nBetweenness+expe+Tztype+times+Camp+condi+Hytype+year,data=mydata2,family=binomial(probit),control=list(maxit=100))
suyao44pre<-ifelse(predict(suyao44)>0,"1","0")
table(mydata2$out,suyao44pre)                       #ģ���Ļ�������
#=====================================================================================
