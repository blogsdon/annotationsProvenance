require(synapseClient)
synapseLogin()
require(rSynapseUtilities)


parseGithubLink <- function(x){
  x <- gsub('\\.','_',x)
  foo <- strsplit(x,'/')[[1]]
  return(paste(foo[c(3,4,5,7,8)],collapse='-'))
}


permLink =githubr::getPermlink('blogsdon/annotationsProvenance',
                               'annoProvenance.R',
                               ref = 'branch',
                               refName = 'dev')

parentDf <- data.frame(foo = rnorm(20),
                     bar = rnorm(20),
                     baz = rnorm(20),
                     stringsAsFactors=F)
View(parentDf)
dummyAnno <- list(a = 'b', 
                  c = 'd',
                  e = 'f')
dummyAnno <- c(dummyAnno,setNames(list('executed'),parseGithubLink(permLink)))

parentDfObj <- rSynapseUtilities::pushDf2Synapse(parentDf,
                              'parentDf.csv',
                              dummyAnno,
                              'syn8007196')
onWeb(parentDfObj)


dummyAnno1 <- list(a = 'b', 
                   c= 'd', 
                   e = 'f')
dummyAnno1 <- c(dummyAnno1,setNames(list('used'),synapseClient::synGetProperties(parentDfObj)$id))
dummyAnno1 <- c(dummyAnno1,setNames(list('executed'),parseGithubLink(permLink)))

childDf1 <- data.frame(foo = rnorm(20),
                       bar = rnorm(20),
                       baz = rnorm(20),
                       stringsAsFactors=F)

childDf1Obj <- rSynapseUtilities::pushDf2Synapse(childDf1,
                                                 'childDf1.csv',
                                                 dummyAnno1,
                                                 'syn8007196')


dummyAnno2 <- list(a = 'b', 
                   c= 'd', 
                   e = 'f')
dummyAnno2 <- c(dummyAnno2,setNames(list('used'),synapseClient::synGetProperties(parentDfObj)$id))
dummyAnno2 <- c(dummyAnno2,setNames(list('used'),synapseClient::synGetProperties(childDf1Obj)$id))
dummyAnno2 <- c(dummyAnno2,setNames(list('executed'),parseGithubLink(permLink)))

childDf2 <- data.frame(foo = rnorm(20),
                       bar = rnorm(20),
                       baz = rnorm(20),
                       stringsAsFactors=F)

childDf2Obj <- rSynapseUtilities::pushDf2Synapse(childDf2,
                                                 'childDf2.csv',
                                                 dummyAnno2,
                                                 'syn8007196')

