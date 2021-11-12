#1761066 한찬규
#257쪽 연습문제 3번 풀이

#3-1
birth <- read.csv("seoul_birth_202007.csv")

#3-2 
head(birth, 10)
class(birth)
summary(birth)

#3-3
names <- birth$행정구역
gc <- geocode(enc2utf8(names))
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     zoom = 11,
                     marker = gc)
gmap <- ggmap(map)
gmap + geom_text(data = df,
                 aes(x = lon, y = lat),
                 size = 5,
                 label = df$name)

#3-4
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 11)
gmap <- ggmap(map)
gmap + geom_point(data = df, 
                  aes(x = lon, y = lat),
                  color = 'blue',
                  alpha = 0.5)

#3-5
library(dplyr)
top10 <- birth %>% arrange(desc(출생인구수)) %>% slice(1:10)

#3-6
names <- top10$행정구역
gc <- geocode(enc2utf8(names))
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat, 출생인구수 = top10$출생인구수)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 11)
gmap <- ggmap(map)
gmap + geom_point(data = df, 
                  aes(x = lon, y = lat),
                  size = top10$출생인구수/30,
                  color = 'blue',
                  alpha = 0.5)

#3-7
gmap + geom_point(data = df, 
                  aes(x = lon, y = lat),
                  size = top10$출생인구수/30,
                  color = rainbow(length(df$출생인구수)),
                  alpha = 0.5)