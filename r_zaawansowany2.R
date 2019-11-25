install.packages("microbenchmark")
library(microbenchmark)

N1<-10000 # stala

microbenchmark(
  test1 = {
    x1 <- NULL
    for(i in 1:N1){
      x1 <- c(x, i)
    }
  }, 
  test2 = {
    x2 <- NULL
    for(i in 1:N1){
      x2[i] <- i
    }
  },
  test3 = {
    x3 <- numeric(N1)
    for(i in 1:N1){
      x3[i] <- i
      }
  }
)

# lapply
# sapply
# vapply
# mapply

a<-b<-c<-1
paste(a, b, c, "xxx", sep=".")
sprintf("Numer %s, tekst; %s", 1, "cos") # d, i, s
sprintf("Numer %s, tekst; %s", 1:10, "cos")

l <- list(
  "I" = list("pierwsza", 1L, "podlista"),
  "II" = list("pierwsza", 1L, "podlista"),
  "III" = list("pierwsza", 1L, "podlista"),
  "IV" = list("pierwsza", 1L, "podlista"),
  "V" = list("pierwsza", 1L, "podlista"),
  "VI" = list("pierwsza", 1L, "podlista"),
  "VII" = list("pierwsza", 1L, "podlista"),
  "VIII" = list("pierwsza", 1L, "podlista"),
  "IX" = list("pierwsza", 1L, "podlista"),
  "X" = list("pierwsza", 1L, "podlista"),
  "XI" = list("pierwsza", 1L, "podlista"),
  "XII" = list("pierwsza", 1L, "podlista")
)

test_fun1 <- function(subl){
  n <- 3-floor(log(subl[[2]],10))
  zeros <- paste(rep("0", n), collapse="")
  sprintf("%s%i: Oto %s %s", zeros, subl[[2]], subl[[1]], subl[[3]])
}

microbenchmark(
  test0 = {
    val <- character(12)
    for(i in 1:12){
      val[i] <- test_fun1(l[[i]])
    }
  },
  test1 = {
    val <- sapply(l, test_fun1)
  },
  test2 = {
    val <- vapply(l, test_fun1, "coś")
    },
  test3 = {
    val <- purrr::map_chr(l, test_fun1)
    }
)

install.packages("tidyverse")
library(tidyverse)

install.packages("purrr")
library(purrr)

remove.packages("rlang") # OGARNAC TO!!

library(datasets)

data("iris")
class(iris)
iris$Sepal.Width <- floor(iris$Sepal.Width)
View(iris)

unique(iris$Sepal.Width)
# funkcja dzielaca iris na podzbiory wzgl szerokosci kielicha
res <- lapply(c(2,3,4), function(x){
  iris[iris$Sepal.Width == x,]
})
# srednia w grupach z operatorem pipe %>%
res2 <- sapply(c(2,3,4), function(x){
  iris[iris$Sepal.Width == x,]$Sepal.Length %>% mean # wywolanie funkcji z pierwszym argumentem zadanym zbiorem danych mean(iris[...])
})

data("iris")
res3 <- mapply(function(x, y) {
  x*y+y
}, iris$Sepal.Length, iris$Sepal.Width)

res4 <- pmap(list(iris$Sepal.Length, iris$Sepal.Width), function(x, y) {
  x*y+y
})

res5 <- pmap_dbl(list(iris$Sepal.Length, iris$Sepal.Width), function(x, y) {
  x*y+y
})

install.packages("lubridate")
library(lubridate)

date1 <- as_date("1991-01-01")
month(date1)
date_int <- as.numeric(date1)
as.Date(date_int, origin="1970-01-01") # nalezy zawsze definiowac origin, zeby hulalo

# dopisywanie kolumn do tabeli
# data.table
# dplyr + tibble

library(tidyverse)
data("iris")
iris <- as_tibble(iris)

unique(iris$Species)
sub1 <- iris %>% 
  filter(Species == 'setosa') %>%
  select(-Species) %>%
  mutate(Sepal.Length = sprintf("Dlugosc rowna %f", Sepal.Length)) %>%
  rename(Dlugosc=Sepal.Length) %>%
  add_column(id=1:50)
View(sub1)

sub2 <- iris %>%
  group_by(Species) %>%
  summarise_all(mean) %>% ungroup()

rm(list = ls())

library(data.table)
data("iris")
dt_iris <- as.data.table(iris)
class(dt_iris) # lista referencji na kolumny, szybsze operacje, bo nie trzeba zmieniac calej tabeli
dt_iris[, jakies_liczby := rnorm(150)] # := operator pozwalajacy dodawac kolumny z uzyciem referencji (nic sie nie zmienia)
colnames(dt_iris) # (ale liczby sa, chociaz ich nie ma w podgladzie)
View(dt_iris)
dt2_iris <- dt_iris # juz ma 6 zmiennych
dtf<-as.data.frame(dt_iris)

# dtplyr - nakladka tidyverse na data.table