#1761066 한찬규
#257쪽 연습문제 4번 풀이

#4-1
fine_dust <- read.csv("finedust_PM10__1910_2003.csv")

#4-2
head(fine_dust, 5)
class(fine_dust)
summary(fine_dust)

#4-3
dust_2020 <- fine_dust %>% select(시도별.1., 시도별.2., X2020..01, X2020..02, X2020..03)

#4-4
colnames(dust_2020) <- c("province", "city", "month1", "month2", "month3")
dust_2020$month1 <- as.numeric(dust_2020$month1)
dust_2020$month2 <- as.numeric(dust_2020$month2)
dust_2020$month3 <- as.numeric(dust_2020$month3)

#4-5
is.na(dust_2020)
#평균값으로 결측치 제거
dust_2020$month1[is.na(dust_2020$month1)] = mean(dust_2020$month1, na.rm = T)
dust_2020$month2[is.na(dust_2020$month2)] = mean(dust_2020$month2, na.rm = T)
dust_2020$month3[is.na(dust_2020$month3)] = mean(dust_2020$month3, na.rm = T)
#세종은 해외로 검색이 되므로 세종시로 변경
dust_2020$province <- ifelse(dust_2020$province == "세종", "세종시", dust_2020$province)

#4-6
dust_2020 <- dust_2020 %>% mutate(sum = month1 + month2 + month3, avg = sum/3)

#4-7
dust_province <- dust_2020 %>% group_by(province) %>% summarise(mean = mean(avg))

#4-8
names <- dust_province$province
gc <- geocode(enc2utf8(names))
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat, mean = dust_province$mean)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 7)
gmap<-ggmap(map)
gmap + geom_point(data = df, 
                  aes(x = lon, y = lat),
                  size = df$mean/2,
                  color = rainbow(length(df$name)),
                  alpha = 0.5)
