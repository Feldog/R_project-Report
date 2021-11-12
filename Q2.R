#1761066 한찬규
#257쪽 연습문제 2번 풀이

install.packages("ggmap")
library(ggmap)

register_google(key = "AIzaSyCjkCo0PGLEi0ldH3pR_1suDf9jgthUiIM")

#2-1
names <- c("서울", "부산", "인천", "대전", "광주", "울산", "대구")
gc <- geocode(enc2utf8(names))
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 8,
                     marker = gc)
gmap <- ggmap(map)
gmap + geom_text(data = df,
                 aes(x = lon, y = lat),
                 size = 6,
                 label = df$name)

#2-2
names <- c("성산일출봉", "한라산", "금오름", "천지연폭포", "용두암", "중문관광단지")
gc <- geocode(enc2utf8(names))
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 10,
                     marker = gc)
gmap <- ggmap(map)
gmap + geom_text(data = df,
                 aes(x = lon, y = lat),
                 size = 3,
                 label = df$name)