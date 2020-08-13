###########################################################################
# Joshua C. Fjelstul, Ph.D.
# eutris R package
###########################################################################

# read in data
member_states <- read.csv("data-raw/member_states.csv", stringsAsFactors = FALSE)

# save
save(member_states, file = "data/member_states.RData")

###########################################################################
# end R script
###########################################################################
