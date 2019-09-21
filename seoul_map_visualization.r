# ------------------------------step 1------------------------------
# check.packages function: install and load multiple R packages.
check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages<-c("ggplot2", "ggmap", "raster", "rgeos", "maptools", "rgdal", "viridis", "mapproj", "extrafont", "ggrepel", "colorspace")
check.packages(packages)
#------------------------------폰트 변경할 때 사용------------------------------
#font_import() # 설치된 모든 폰트 불러오기 (시간 오래 걸림)
#fonts() (불러온 폰트 확인)
#loadfonts(device="win") (특정 폰트이름 넣어서 불러오기)
#------------------------------Choropleth Map------------------------------
# ------------------------------shp 파일 불러오기 및 좌표계 변환------------------------------
register_google(key='AIzaSyBxaEToyRZGHM9iOSNr9glfxPLBituRQmk')
korea = shapefile('TL_SCCO_SIG.shp')
# 좌표계 변환
from.crs =  "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs"
  to.crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  proj4string(korea) <- CRS(from.crs)
    korea<-spTransform(korea,CRS(to.crs))
korea@bbox # 변환된 좌표계 확인
#------------------지도 정보, 서울시 구별 좌표 불러오기------------------
map <- get_map(location='south korea', zoom=7, maptype='roadmap', color='bw')
abc = read.csv("choropleth.csv") # "data2.csv"
seoul = korea[korea$SIG_CD<=11740,]
seoul = fortify(seoul,region = 'SIG_CD')
seoul = merge(seoul,abc,by='id')
seoul.label <- read.csv("seoul_label.csv")

#------------------지도 색칠 색상 지정------------------
# colours = c("#a9db95","#fcae8d","#d53e4f")
colours = c("#d9828c", "#d53e4f", "#a9db95", "#7da26e", "#42aaea", "#2d79a8")
#------------------지도 그래프 시각화------------------
ggplot() + geom_polygon(data=seoul,colour="Black",size=0.05, aes(x=long, y=lat, group=group, fill=detail)) + # fill=result
  theme(plot.title = element_text(size=20),legend.title = element_text(size=10)) +
  ggtitle("지역구별 아동복지 취약 지도") + scale_fill_gradientn (colours = colours, name = "그룹", guide = "legend") +
  geom_text(data=seoul.label, aes(x=long, y=lat, label=city), size=7) # seoul.label 자료를 참고해서 지도에 지역구 이름 매핑
# palette = RdYlGn, RdYlBu, RdBu, YlGnBu, YlOrBr, YlOrRd, Spectral
# scale_fill_gradient(low = "#132B43", high = "#56B1F7",space = "Lab", na.value = "grey50", guide = "colourbar",aesthetics = "fill") +
# scale_fill_gradientn (colours = colours, name = "그룹", guide = "legend") +
# scale_fill_distiller(name = "그룹", palette = "Spectral", direction = 1, guide = "legend") +

#------------------csv파일 저장 코드------------------
#write.csv(seoul, file = "seoul_label.csv",row.names=FALSE)
