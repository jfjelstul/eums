################################################################################
# Joshua C. Fjelstul, Ph.D.
# eums R package
################################################################################

##################################################
# member states
##################################################

# read in data
member_states <- read.csv("data-raw/member-states-raw.csv", stringsAsFactors = FALSE)

# dates
member_states$accession_date <- lubridate::ymd(member_states$accession_date)
member_states$exit_date <- lubridate::ymd(member_states$exit_date)
member_states$emu_accession_date <- lubridate::ymd(member_states$emu_accession_date)
member_states$schengen_date_signed <- lubridate::ymd(member_states$schengen_date_signed)
member_states$schengen_date_implemented <- lubridate::ymd(member_states$schengen_date_implemented)

# arrange
member_states <- dplyr::arrange(member_states, accession_date, member_state)

# key ID
member_states$key_id <- 1:nrow(member_states)

# organize variables
member_states <- dplyr::select(
  member_states,
  key_id, everything()
)

# save
save(member_states, file = "data/member_states.RData")

##################################################
# member states (CSTS)
##################################################

# create a template
member_states_csts <- expand.grid(
  member_state = member_states$member_state,
  year = 1952:2021
)

# merge in data
member_states_csts <- dplyr::left_join(
  member_states_csts,
  dplyr::select(member_states, member_state_id, member_state, member_state_code, accession_year),
  by = "member_state"
)

# observations to keep
member_states_csts <- dplyr::filter(member_states_csts, year >= accession_year)

# years as a member
member_states_csts$years_as_member <- member_states_csts$year - member_states_csts$accession_year + 1

# arrange
member_states_csts <- dplyr::arrange(member_states_csts, year, member_state_id)

# key ID
member_states_csts$key_id <- 1:nrow(member_states_csts)

# organize variables
member_states_csts <- dplyr::select(
  member_states_csts, 
  key_id, year, 
  member_state_id, member_state, member_state_code,
  years_as_member
)

# save
save(member_states_csts, file = "data/member_states_csts.RData")

##################################################
# member states (DDY)
##################################################

# create a template
member_states_ddy <- expand.grid(
  from_member_state = member_states$member_state,
  to_member_state = member_states$member_state,
  year = 1952:2021
)

# merge in data (from member state)
member_states_ddy <- dplyr::left_join(
  member_states_ddy,
  dplyr::select(member_states, member_state_id, member_state, member_state_code, accession_year),
  by = c("from_member_state" = "member_state")
)

# rename variables
member_states_ddy <- dplyr::rename(
  member_states_ddy,
  from_member_state_id = member_state_id,
  from_member_state_code = member_state_code,
  from_accession_year = accession_year,
)

# merge in data (to member state)
member_states_ddy <- dplyr::left_join(
  member_states_ddy,
  dplyr::select(member_states, member_state_id, member_state, member_state_code, accession_year),
  by = c("to_member_state" = "member_state")
)

# rename variables
member_states_ddy <- dplyr::rename(
  member_states_ddy,
  to_member_state_id = member_state_id,
  to_member_state_code = member_state_code,
  to_accession_year = accession_year,
)

# observations to keep
member_states_ddy <- dplyr::filter(member_states_ddy, year >= from_accession_year & year >= to_accession_year)
member_states_ddy <- dplyr::filter(member_states_ddy, from_member_state != to_member_state)

# arrange
member_states_ddy <- dplyr::arrange(member_states_ddy, year, from_member_state_id, to_member_state_id)

# key ID
member_states_ddy$key_id <- 1:nrow(member_states_ddy)

# organize variables
member_states_ddy <- dplyr::select(
  member_states_ddy, 
  key_id, year, 
  from_member_state_id, from_member_state, from_member_state_code,
  to_member_state_id, to_member_state, to_member_state_code,
)

# save
save(member_states_ddy, file = "data/member_states_ddy.RData")

##################################################
# QMV weights
##################################################

# read in data
qmv_weights <- read.csv("data-raw/QMV-weights-raw.csv", stringsAsFactors = FALSE)

# merge in member state ID
qmv_weights <- dplyr::left_join(
  qmv_weights,
  dplyr::select(member_states, member_state_id, member_state, member_state_code),
  by = "member_state"
)

# normalized weight
qmv_weights$normalized_weight <- qmv_weights$votes / qmv_weights$total_votes

# dates
qmv_weights$start_date <- lubridate::ymd(qmv_weights$start_date)
qmv_weights$end_date <- lubridate::ymd(qmv_weights$end_date)

# year
qmv_weights$start_year <- lubridate::year(qmv_weights$start_date)
qmv_weights$end_year <- lubridate::year(qmv_weights$end_date)

# month
qmv_weights$start_month <- lubridate::month(qmv_weights$start_date)
qmv_weights$end_month <- lubridate::month(qmv_weights$end_date)

# day
qmv_weights$start_day <- lubridate::day(qmv_weights$start_date)
qmv_weights$end_day <- lubridate::day(qmv_weights$end_date)

# arrange
qmv_weights <- dplyr::arrange(qmv_weights, period, votes)

# key ID
qmv_weights$key_id <- 1:nrow(qmv_weights)

# organize variables
qmv_weights <- dplyr::select(
  qmv_weights,
  key_id, period, 
  start_date, start_year, start_month, start_day,
  end_date, end_year, end_month, end_day,
  count_member_states,
  member_state_id, member_state, member_state_code,
  votes, total_votes, normalized_weight
)

# save
save(qmv_weights, file = "data/qmv_weights.RData")

##################################################
# codebook
##################################################

# read in data
codebook <- read.csv("data-raw/codebook/codebook.csv", stringsAsFactors = FALSE)

# convert to a tibble
codebook <- dplyr::as_tibble(codebook)

# save
save(codebook, file = "data/codebook.RData")

# documentation
codebookr::document_data(
  path = "R/",
  codebook_file = "data-raw/codebook/codebook.csv",
  markdown_file = "data-raw/codebook/descriptions.txt",
  author = "Joshua C. Fjelstul, Ph.D.",
  package = "eums"
)

################################################################################
# end R script
################################################################################
