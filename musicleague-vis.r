library(googlesheets4) #read in data from gsheet
library(googledrive) #call sheets by name
library(dplyr) #merge and clean data
library(tidyr) #uncount to generate edge list
#library(circlize) #visualize chord diagram
library(chorddiag) #visualize chord diagram #devtools::install_github("mattflor/chorddiag")

#read in data from musicleague googlesheet dump
gsheet_name <- "Jessie's Music League" #name of google sheet
submissions_sheet_name <- "Submissions" #name of tab w submission data
votes_sheet_name <- "Votes" #name of tab w vote data
music_league_gsheet <- drive_get(gsheet_name)  #this prompts googledrive auth
votes <- read_sheet(music_league_gsheet, sheet = votes_sheet_name) #this prompts googlesheets4 auth
submissions <- read_sheet(music_league_gsheet, sheet = submissions_sheet_name)


#Drop submissions from people who submitted but then never voted. Messes up your matrix later.
#Find those who submitted a song (ever) AND voted (ever)
submitters <- unique(submissions$submitter) %>% as.data.frame()
voters <- unique(votes$voter) %>% as.data.frame()
submitted_and_voted <- submitters %>% inner_join(voters)
colnames(submitted_and_voted) <- c("submitter") #so you can join on this common colname later

#TODO - Question for Nate -- can you vote if you don't submit? might need to control for that too someday

#join data to get submitters in the same table as votes; include only those who submitted and voted
joined_musicleague_voting_data_all <- votes %>% left_join(submissions)
joined_musicleague_voting_data <- joined_musicleague_voting_data_all %>% inner_join(submitted_and_voted)
#define factor levels
joined_musicleague_voting_data$voter <- as.factor(joined_musicleague_voting_data$voter)
joined_musicleague_voting_data$submitter <- as.factor(joined_musicleague_voting_data$submitter)


#Clean data to required formats.
#drop extra cols so we just have voters, submitters, and points
edge_list_weighted <- joined_musicleague_voting_data %>% subset(select = -c(round, voted, song, submitted))

#Separate out positive/negative points - run analyses separately
edge_list_weighted_pos <- edge_list_weighted[edge_list_weighted$points > 0, ]
edge_list_weighted_neg <- edge_list_weighted[edge_list_weighted$points < 0, ]

#Create edge lists for votes. One col per vote. [voter, submitter]
edge_list_long_pos <- uncount(edge_list_weighted_pos, points)
#For negative votes, ake absolute value of points on this one then uncount() the same way
edge_list_weighted_neg$points <- abs(edge_list_weighted_neg$points)
edge_list_long_neg <- uncount(edge_list_weighted_neg, points)

#Create adjacency matrices (used for chord diagram)
adj_matrix_pos <- table(edge_list_long_pos$voter, edge_list_long_pos$submitter) %>% as.matrix()
adj_matrix_neg <- table(edge_list_long_neg$voter, edge_list_long_neg$submitter) %>% as.matrix()








#Visualization

#clean data to get tables in the formats you need
#for heirarchical edge bundling (https://www.r-graph-gallery.com/311-add-labels-to-hierarchical-edge-bundling.html)
# voter | person they voted for | num votes


#chord diagram? https://www.r-graph-gallery.com/chord-diagram.html
# https://www.r-graph-gallery.com/123-circular-plot-circlize-package-2.html
# origin | destination (one row for each vote) - edge list

#Visualize basic chord diagram!!
chorddiag(adj_matrix_pos)
chorddiag(adj_matrix_neg)

