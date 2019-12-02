# install.packages("checkmate")
library(checkmate)
library(tidyverse)

rm(list = ls())

H <- 100000

num_der <- function(f,x){
  (f(x+H)-f(x))/H
}

f <- function(x) exp(x)

num_der(f, "jakis tekst") # Błąd w poleceniu 'x + H': argument nieliczbowy przekazany do operatora dwuargumentowego

##############################

# jezeli piszemy program / pakiet do uzytku dla innych osob, musimy zapewnic uzytkowanie zgodne z przeznaczeniem
# na przyklad wpisywanie argumentow wlasciwego typu - mozna to zrobic recznie albo biblioteka checkmate

add_list <- function(x){
  if(!is.numeric(x))
    return(NULL)
    # stop("Argument nie jest liczba!") # definiowanie tresci warningu
  len <- length(LL)
  LL[[len+1]] <- x
}

add_list("tekst")

LL <- NULL
add_list <- function(x, y){
  # assert_double(x)
 
  # check_double(x) %>% print # print do odczytania jak dziala funkcja / do nauki, nie do uzywania ;)
  # check_array(x) %>% print
  # check_atomic_vector(x) %>% print
  
  assert(check_double(x, min.len=2), check_integer(y, len=1),
         combine="and") # domyslna wartosc OR miedzy argumentami (wystarczy spelnic jeden zeby dzialalo!)
  
  len <- length(LL)
  LL[[len+1]] <<- x/y # <<- do nadpisywania zmiennej na zewnatrz funkcji
}

add_list("tekst") # dostajemy jasny przekaz o typie bledu
add_list(c(20,10),5)
add_list(c(20,10),5L)
add_list(2,1)

robi_cos <- function(x){
  print("cos")
}
robiCos <- function(x) robi_cos(x) # dobra praktyka, aby tworzyc funkcje ze wspolnym nazewnictwem / spojna koncepcja nazwenicza!

.robi_cos2 <- function(x){
  print("cos")
}
robi_cos2 <- function(x){
  assert_character(x)
  .robi_cos2(x)
} # albo nazywanie funkcji wewnetrznej z kropka

##############################

# OBSLUGA WYJATKOW

?tryCatch
tryCatch(num_der(f, "tekst"),
         error=function(e) print(e),
         warning=function(w) print(w))

my_equal <- function(x, y){
  x==y
}

my_equal(c(1,2),1)
