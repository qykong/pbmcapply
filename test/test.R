library(pbmcapply)

testMultipleArguments <- function(element, args1, args2, args3, args4) {
  return(paste(sqrt(element) * 10, args1, args2, args3, args4, sep = ", ", collapse = ""))
}

testErrorHandling <- function(num) {
  # Sleep randomly between 0 to 0.5 second
  Sys.sleep(runif(1, 0, 0.5))
  if (num == 2) {
    stop("throw error on purpose")
  }
  return(sqrt(num))
}

# Tests for pbmclapply
control <- mclapply(1:20, testMultipleArguments, "alice", "bob", 42, "chris")
# Test four arguments
res1 <- pbmclapply(1:20, testMultipleArguments, "alice", "bob", 42, "chris")
# Test four arguments plus parameters
res2 <- pbmclapply(1:20, testMultipleArguments, "alice", "bob", 42, "chris", mc.cores = 4)
# Check if the results are the same as control
if(!all(identical(control, res1), identical(control, res2))) {
  warning("Tests for pbmclapply failed.")
}

# Tests for pbmcmapply
control <- mcmapply(testMultipleArguments, 1:20, MoreArgs = list("alice", "bob", 42, "chris"))
# Test four arguments
res3 <- pbmcmapply(testMultipleArguments, 1:20, MoreArgs = list("alice", "bob", 42, "chris"))
# Test four arguments plus parameters
res4 <- pbmcmapply(testMultipleArguments, 1:20, MoreArgs = list("alice", "bob", 42, "chris"), mc.cores = 4)
# Check if the results are the same as control
if(!all(identical(control, res3), identical(control, res4))) {
  warning("Tests for pbmcmapply failed.")
}
