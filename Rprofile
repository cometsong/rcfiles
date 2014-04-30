#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Rprofile (cometsong) ~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Default Repo Setup ~~~~~
# R is too stupid to multiple repos
repo_list <- c("http://cran.us.r-project.org/")
options(repos = repo_list)
rm(repo_list) #cleanup

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ General Options ~~~~~
options(prompt="R> ", continue=" + ")
options(tab.width = 2) 
options(width = 160)
options(graphics.record=TRUE) 
options(editor="vim")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Functions ~~~~~
whoami  <- function(){ 
  paste(system("whoami",T),sep="",collapse="")
}

sysdate <- function(){ 
  paste(system("date +'%Y-%m-%d %H:%M:%S'", intern=TRUE))
}

# Override q() to not save by default. Same as saying q("no")
q <- function (save="no", runLast=TRUE, ...) {
  quit(save=save, runLast=runLast, ...)
}

# Bioconductor Startup
bioStart <- function(){
  source("http://bioconductor.org/biocLite.R")
  biocLite()
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~
cd <- setwd
pwd <- getwd
lss <- dir


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ First and Last ~~~~~
# Session Startup/Shutdown Funcs
.First <- function(){
  cat(rep_len('=',80),"\n",sep="") #divider line
  cat("Welcome to R,", whoami(), "at", sysdate(), "\n") 
}

.Last <- function(){ 
  cat("\nBye at", sysdate(), "\n")
}

# vim: ft=R tw=80 ts=2 sts=2 sw=2
