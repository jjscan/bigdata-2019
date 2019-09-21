# ------------------------------step 1------------------------------
# check.packages function: install and load multiple R packages.
check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages<-c("fpc", "cluster", "dplyr", "factoextra", "NbClust", "clValid", "FactoMineR", "fclust")
check.packages(packages)

# ------------------------------기존 abc파일에서 원하는 열만 추출------------------------------
# abc <- read.csv("new_abc.csv", header=TRUE, na.strings="NA", stringsAsFactors=default.stringsAsFactors(),fileEncoding = 'euc-kr',encoding = 'utf-8')
# pamk_test <- select(abc1, c(다문화.복지,장애.복지,가정위탁.복지,기초생활.복지))

# ------------------------------csv파일 저장------------------------------
# write.csv(pamk_test, file = "pamk_test.csv",row.names=FALSE)

# ------------------------------최적의 K 결정------------------------------
# 데이터 불러오기
data<-read.csv("pamk_test.csv")
data2<-as.data.frame(scale(data))

### k(군집 개수) 결정
# 클러스터링에서는 적절한 군집 개수의 선택이 중요합니다. 
# 사전지식이 없으므로 Elbow point, Average Silhouette을 살펴보고 k를 결정하도록 하겠습니다.
# k-means 수행
result<-NULL
for (k in 1:10){
  result[[k]]<-kmeans(data2,k,nstart=10)
}

## 1) Elbow point  
# The total within-cluster sum of square(wss)이 작을수록 좋습니다. 
# wss의 그래프을 그려보고 elbowpoint를 참고하겠습니다.
wss <- numeric(10)
for(k in 1:10){
  wss[k]<-result[[k]]$tot.withinss
}
plot(wss,type="l")
abline(v=c(2,3),col="red",lty=2)

## 2) Average Silhouette
# 평균 실루엣이 최대가 되도록 하는 k가 군집의 수로 적절합니다. 
avgsil<-numeric(10)
for (k in 2:10){
  si<-summary(silhouette(result[[k]]$cluster,dist(data2)))
  avgsil[k]<-si$avg.width
}
avgsil
plot(avgsil,type="l")
abline(v=c(2,3),col="red",lty=2)

# factoextra 패키지를 이용하여 적절한 클러스터 개수를 결정하고 시각화하는 함수 fviz_nbclust를 사용해도 됩니다.
#fviz_nbclust(data2, FUNcluster=kmeans, method = "wss") # k=2
#fviz_nbclust(data2, FUNcluster=kmeans, method = "silhouette") # k=2

## 3) 시각화
# 변수들의 상관관계를 파악하기 위해 산점도 그래프를 그려서 분산을 살펴본다,
panel.fun <- function(x, y, ...) { horizontal <- (par("usr")[1] + par("usr")[2]) / 2; vertical <- (par("usr")[3] + par("usr")[4]) / 2; text(horizontal, vertical, format(abs(cor(x,y)), digits=2)) }
pairs(data2, pch=21, bg=c("blue3"), upper.panel = panel.fun, main = "Scatter Plot of Children welfare Dataset")
plot(data2, pch=result[[3]]$cluster, col=result[[3]]$cluster)

# k=2,3,4,5일 때 클러스터링을 시각화하여 살펴보겠습니다.
fviz_cluster(result[[2]],data=data2,geom="point",stand=FALSE,ellipse.type="norm")
fviz_cluster(result[[3]],data=data2,geom="point")
fviz_cluster(result[[4]],data=data2,geom="point",stand=FALSE,ellipse.type="norm")
fviz_cluster(result[[5]],data=data2,geom="point",stand=FALSE,ellipse.type="norm")

# 데이터를 표준화하되, 군집의 개수는 3개로 클러스터링하는 것으로 결정합니다.
### k-means clustering 
(kmeans <- kmeans(data2,3))

#---------------------------------------------------------------------------
### k 값 평가
# 군집화에 대한 평가의 척도로 실루엣과 Dunn Index가 있습니다. 

## 1) 실루엣
plot(silhouette(kmeans$cluster,dist=dist(data2)))
# 평균 실루엣은 0.38으로 작으나, 가능한 k의 범위에서 가장 평균 실루엣이 높은 k였으므로 군집 수를 다시 설정하지 않습니다.
# 1에 가까울수록 잘 클러스터화 되어 있는것이고 0 주변은 두 군집 사이에 놓여 있는 점을 말하며,
# 음수로 나타나면 잘못된 클러스터에 속해 있을 가능성이 높습니다. 음수로 나타난 점은 적은 편이라고 판단합니다.

## 2) Dunn Index
dunn.index<-numeric(10)
d <- dist(data2,method="euclidean")
for (k in 2:10){
  dunn.index[k]<-dunn(d, result[[k]]$cluster)
}
dunn.index
# [1] 0.0000000 0.2246103 0.2539498 0.3153616 0.3256604 0.3256604 0.4443657 0.4443657 0.5641878 0.5985109
# k값의 비례해서 dunn.index 값이 큽니다.

#---------------------
### k-medoids clustering과의 비교 
# pam 함수는 k-medoids clustering 함수입니다. 
# k-Means 알고리즘보다 특이값이 대해서 안정적인 결과를 얻게 해줍니다. 
avsil.pam<-numeric(20)
for (k in 2:20){
  avsil.pam[k]<-pam(data2,k)$silinfo$avg.width
}
avsil.pam
which.max(avsil.pam)
# 역시 k=2일 때 평균 실루엣이 가장 크지만, k=2일 때 음수의 값을 가지는 잘못된 클러스터링 값이 두 개라서 k=3으로 결정합니다.

#---------------------
# kmeans와 클러스터링의 결과를 비교해보겠습니다. 
pam<-pam(data2,3)
plot(pam)

#---------------------
# +) 평균 실루엣이 최적화된 군집의 수로 클러스터링하는 pamk함수를 써도 됩니다. 
pamk.result <- pamk(data2)
pamk.result$nc # k=2
pamk.result$pamobject
#---------------------
### Hclust와의 비교 
hc<-NULL
hc[[1]] <- hclust(dist(data2),method="single") # method="single" 최단연결법
hc[[2]] <- hclust(dist(data2),method="complete") # method="complete" 최장연결법
hc[[3]] <- hclust(dist(data2),method="average") # method="average" 평균연결법 
hc[[4]] <- hclust(dist(data2),method="centroid") # method="centroid" 중심연결
hc[[5]] <- hclust(dist(data2),method="ward.D2") # method="ward.D2" 와드연결법

hcluster<-NULL
for (i in 1:5){
  hcluster[[i]] <- cutree(hc[[i]],3)
}

for (i in 1:5){
  plot(hc[[i]],hang=-1)
  rect.hclust(hc[[i]],k=3,border="red")
}

## 평균 실루엣
avsil.hc<-numeric(5)
for (i in 1:5){
  si<-silhouette(cutree(hc[[i]],k=3),dist(data2))
  ssi<-summary(si)
  avsil.hc[i]<-ssi$avg.width
}
avsil.hc
# 최단연결법 최장연결법 평균연결법 중심연결법 와드연결법
# 0.1832588  0.3676428  0.3833957  0.2095303  0.3676428

## 실루엣 plot
for (i in 1:5){
  plot(silhouette(hcluster[[i]],dist=dist(data2)))
}
# Hclust 중 평균연결법이 가장 군집화가 잘 되었다고 판단합니다. 

#---------- Fuzzy Cluster----------------
# rational starting point Maxtix U
rational_starting_point <- matrix(c(0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2), nrow = 25, ncol = 5, byrow = F)
rational_starting_point # 가중치 줘서 퍼지 클러스터링 할 때 사용할 가중치 행렬
# Fuzzy K-means clustering with FKM() fuctnion of fclust package
data2_FKM <- FKM(X = data2, k = 3, m = 2)
# x =  Matrix or data.frame / k =  Number of clusters (default: 2) / m = Parameter of fuzziness (default: 2) / startU = Rational starting point for the membership degree matrix U
data2_FKM

#----------------------위에 결과를 바탕으로 k=3, kmeans로 클러스터링 정리------------------------- 
residual <- kmeans(data2, 3, nstart=25)
#residual
fviz_cluster(residual, data=data2)
# 시각화된 결과를 보면, 전체 지역구가 총 세 개의 그룹으로 구분된다.
# Dim1(첫 번째 차원)이 전체 응답자를 세 그룹으로 나누는데 약 77.3%의 공헌을 했고,
# Dim2(두 번째 차원)은 약 11.8%의 공헌을 했음을 알 수 있다.
# 아래 각 클러스터별 내용 분석을 통해서 각 그룹은 무엇을 더 중요시 하는지 파악한다.

### 각 클러스터별 내용 분석 (주성분분석 : PCA)
pca.res <- PCA(data2, graph=FALSE)
fviz_contrib(pca.res, choice = "var", axes=1, top=5)
# 첫 번째 차원(Dim1)을 구성하고 있는 요인(factor)로는 한부모, 아동기초, 아동가정, 다문화, 장애로 구성됐습니다.
# 빨간 기준선을 초과하는 앞에서 두 개의 요인(한부모, 아동기초)이 첫 번째 차원에서 제일 큰 영향을 미치고 있습니다.

fviz_contrib(pca.res, choice = "var", axes=2, top=5)
# 첫 번째 차원(Dim1)을 구성하고 있는 요인(factor)로는 한부모, 아동기초, 아동가정, 다문화, 장애로 구성됐습니다.
# 빨간 기준선을 초과하는 앞에서 한 개의 요인(장애)이 두 번째 차원에서 제일 큰 영향을 미치고 있습니다.
