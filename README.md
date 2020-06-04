# musicleague-vis
Looking at voter and submission data from Spotify Music League (check it out [here](https://musicleague.app/profile/)!)  Music League is an app where a group of people submit Spotify songs that align with a pre-selected theme. Those songs are aggregated into an anonymized playlist; after listening to everyone's submissions, players then upvote or downvote the submitted songs. At the end of each round, points are awarded based on net votes. This repo is meant to practice different network visualization strategies based on those voter data.

# Data
Submission and voter data were exported by a musicleague dev and provided via google sheet that updated on demand.

## Submissions
| Name | Description | Example |
| - | - | - |
| round | Name of the voting round for submission | Best angry song | 
| submitted | Timestamp for when each song was submitted | 4/23/2020 2:50:33 | 
| submitter | Username of who submitted that song | omgitsjessie | 
| song | Spotify song ID | spotify:track:1GCbc1vpkZA2zhjsSFhmHT | 

## Votes
| Name | Description | Example |
| - | - | - |
| round | Name of the voting round for submission | Best angry song | 
| voted | Timestamp for when the votes were cast | 4/27/2020 20:36:52 | 
| voter | Username of who cast the votes | omgitsjessie | 
| song | Spotify song ID | spotify:track:1GCbc1vpkZA2zhjsSFhmHT | 
| points | Total votes cast for a song. Negative number is a downvote | 2 | 

# Analysis
Questions of interest:
1. Is there someone in your music league that your tastes particularly align with?
2. Is there someone in your league who is your musical polar opposite? How do downvotes look?
3. Voting strategy: Do you spread out the love, or pour all your votes on the most deserving submission?
4. What do the songs you have submitted / upvoted / downvoted have in common?
