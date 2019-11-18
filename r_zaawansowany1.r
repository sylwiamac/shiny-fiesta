# Warsztat R zaawansowany 1 - 18.11.2019

hello <- function() print("Hello World!")

Sys.getlocale()
Sys.setlocale("LC_MESSAGES", "en_GB.UTF-8") # zmiana j?zyka - sprawdzi?

# [git] branch x
# checkout -b x
# diff
# add
# commit (etap)
# push / pull (wysy?anie/pobieranie z repozytorium)
# remote
# merge

# Nowy Projekt -> Version Control -> GIT

num_der <- function(f, x, h) { # pochodna numeryczna
  (f(x+h)-f(x))/h
}

f <- function(x) exp(x)

num_der(f, 3, 1/100000)

n<-200
samp<-rt(n,10)
print(samp)
plot(samp)


l <- as.list(rep(1,n))
