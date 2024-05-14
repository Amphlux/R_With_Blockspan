# This code creates API calls to the Blockspan Ethereum service. 
# These API call requests information of 3 NFT Collections, defined by their contract address.
# You can get a free blockspan API code at https://blockspan.com/ as of the time of this writing. 
# Feel free to write your own API calls if you prefer another service.
# After the raw JSON data is returned, the JSON is parsed into usable R Dataframes, stored as environment variables.
# Once the data is usable, the code uses ggplot2 to generate visualized data.
# Finally, the data is printed to a *.JSON log in directory "~/NFT_Collection_Data/"

# only for local RStudio installs
# set to your preferred working directory
#setwd("~/script/RStudio")

# Uncomment to install the required packages.
# Only needed to do once.
# See RStudio docs for details.
#install.packages('tidyverse')
#install.packages('httr')
#install.packages("jsonlite")

# load the required packages
library(tidyverse)
library(httr)
library(jsonlite)

# enter your API key here between the quotes
# You can get a free blockspan API code at https://blockspan.com/ as of the time of this writing. 
api <- ''

# Enter in the contract address of an NFT Collection you are interested in learning more about between the ''.
# 1 Currently set to Doodles(DOODLE)
# 2 Currently set to Cryptopunks
# 3 Currently set to Bored Ape Yacht Club
collectionContract <- '0x8a90cab2b38dba80c64b7734e58ee1db38b8992e'
collection2Contract <- '0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB'
collection3Contract <- '0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d'

# This code constructs an API call to Blockscan that requests back data about a previously specified NFT token contract.
# Construct URL object + Collection Contract object
singleCollectionURL <- paste0("https://api.blockspan.com/v1/collections/contract/", collectionContract)
secondCollectionURL <- paste0("https://api.blockspan.com/v1/collections/contract/", collection2Contract)
thirdCollectionURL <- paste0("https://api.blockspan.com/v1/collections/contract/", collection3Contract)

# Construct a Query object for API query
# Further implementation will allow different blockchains and query types
# This will be further modified and implemented into a function in the future
queryString <- list(chain = "eth-main")

# Construct a generated response 
# Using httr, receive a response back from the Blockscan API
# URL + collection + query + header(with api key), 
# content_type/source from blockscan, format type from blockscan
# Response is in raw JSON text format
responseSingleCollection <- VERB("GET", singleCollectionURL, query = queryString, add_headers('X-API-KEY' = api), content_type("application/octet-stream"), accept("application/json"))
responseSecondCollection <- VERB("GET", secondCollectionURL, query = queryString, add_headers('X-API-KEY' = api), content_type("application/octet-stream"), accept("application/json"))
responseThirdCollection <- VERB("GET", thirdCollectionURL, query = queryString, add_headers('X-API-KEY' = api), content_type("application/octet-stream"), accept("application/json"))

# Generate parsed JSON data format
jsonSingleCollection <- content(responseSingleCollection, "parsed", type = "application/json")
jsonSecondCollection <- content(responseSecondCollection, "parsed", type = "application/json")
jsonThirdCollection <- content(responseThirdCollection, "parsed", type = "application/json")

# Extract both data and stats for each exchange, for each collection
looksrare_collection1_data <- jsonSingleCollection$exchange_data[[1]]
looksrare_collection2_data <- jsonSecondCollection$exchange_data[[1]]
looksrare_collection3_data <- jsonThirdCollection$exchange_data[[1]]
opensea_collection1_data <- jsonSingleCollection$exchange_data[[2]]
opensea_collection2_data <- jsonSecondCollection$exchange_data[[2]]
opensea_collection3_data <- jsonThirdCollection$exchange_data[[2]]

# Function to create data frames from exchange information
create_exchange_df <- function(data) {
  tibble(
    exchange = data$exchange,
    update_at = data$update_at,
    key = data$key,
    name = data$name,
    description = data$description %||% NA,
    exchange_url = data$exchange_url,
    external_url = data$external_url,
    banner_image_url = data$banner_image_url %||% NA,
    featured_image_url = data$featured_image_url %||% NA,
    large_image_url = data$large_image_url %||% NA,
    image_url = data$image_url %||% NA,
    chat_url = data$chat_url %||% NA,
    discord_url = data$discord_url,
    telegram_url = data$telegram_url %||% NA,
    twitter_username = data$twitter_username,
    wiki_url = data$wiki_url %||% NA,
    instagram_username = data$instagram_username %||% NA
  )
}

# Function to create data frames for stats
create_stats_df <- function(data) {
  stats <- data$stats
  
  # Create a tibble directly with safe handling for NULL values using dplyr's `mutate` and `across`
  tibble(
    market_cap = stats$market_cap,
    num_owners = stats$num_owners,
    floor_price = stats$floor_price,
    # floor_price_symbol omitted due to NULL
    total_minted = stats$total_minted,
    total_supply = stats$total_supply,
    total_volume = stats$total_volume,
    one_day_volume = stats$one_day_volume,
    seven_day_volume = stats$seven_day_volume,
    thirty_day_volume = stats$thirty_day_volume,
    one_day_volume_change = stats$one_day_volume_change,
    seven_day_volume_change = stats$seven_day_volume_change,
    thirty_day_volume_change = stats$thirty_day_volume_change,
    total_sales = stats$total_sales,
    one_day_sales = stats$one_day_sales,
    seven_day_sales = stats$seven_day_sales,
    thirty_day_sales = stats$thirty_day_sales,
    total_average_price = stats$total_average_price,
    one_day_average_price = stats$one_day_average_price,
    seven_day_average_price = stats$seven_day_average_price,
    thirty_day_average_price = stats$thirty_day_average_price
  ) %>% 
    mutate(across(everything(), ~ as.numeric(.) %||% NA)) 
  # forces all strings into numeric, with NULL returning NA
}

# Create data frames
# Collection1
looksrare_collection1_data_df <- create_exchange_df(looksrare_collection1_data)
looksrare_collection1_stats_df <- create_stats_df(looksrare_collection1_data)
opensea_collection1_data_df <- create_exchange_df(opensea_collection1_data)
opensea_collection1_stats_df <- create_stats_df(opensea_collection1_data)
# Collection2
looksrare_collection2_data_df <- create_exchange_df(looksrare_collection2_data)
looksrare_collection2_stats_df <- create_stats_df(looksrare_collection2_data)
opensea_collection2_data_df <- create_exchange_df(opensea_collection2_data)
opensea_collection2_stats_df <- create_stats_df(opensea_collection2_data)
# Collection3
looksrare_collection3_data_df <- create_exchange_df(looksrare_collection3_data)
looksrare_collection3_stats_df <- create_stats_df(looksrare_collection3_data)
opensea_collection3_data_df <- create_exchange_df(opensea_collection3_data)
opensea_collection3_stats_df <- create_stats_df(opensea_collection3_data)

# Extracting a name to use as a later variable
singleCollectionName <- opensea_collection1_data$name
secondCollectionName <- opensea_collection2_data$name
thirdCollectionName <- opensea_collection3_data$name

# Put all the names into a collection for later use
collection_names <- rep(c(singleCollectionName, secondCollectionName, thirdCollectionName, singleCollectionName, secondCollectionName, thirdCollectionName))

# Combine Exchange Data Into Dataframes
# Data Dataframes
opensea_combined_data_df <- bind_rows(opensea_collection1_data_df, opensea_collection2_data_df, opensea_collection3_data_df)
looksrare_combined_data_df <- bind_rows(looksrare_collection1_data_df, looksrare_collection2_data_df, looksrare_collection3_data_df)
all_combined_data_df <- bind_rows(opensea_combined_data_df, looksrare_combined_data_df)

# Combine Exchange Stats Into Dataframes
# Stats Dataframes
opensea_combined_stats_df <- bind_rows(opensea_collection1_stats_df, opensea_collection2_stats_df, opensea_collection3_stats_df)
looksrare_combined_stats_df <- bind_rows(looksrare_collection1_stats_df, looksrare_collection2_stats_df, looksrare_collection3_stats_df)
all_combined_stats_df <- bind_rows(opensea_combined_stats_df, looksrare_combined_stats_df)

# add an 'exchange_name' column to clearly distinguish the exchanges.
# add a 'name' column to clearly distinguish the collections.
# not needed for data, needed for stats
final_combined_stats_df <- bind_rows(
  mutate(opensea_combined_stats_df, exchange_name = "opensea"),
  mutate(looksrare_combined_stats_df, exchange_name = "looksrare")
) %>%
  mutate(Name = collection_names)

# visualize the data with ggplot2
metrics_plot1 <- final_combined_stats_df %>%
  select(exchange_name, total_sales) %>%
  pivot_longer(cols = -exchange_name, names_to = "metric", values_to = "value")

# Create the bar chart for total_volume and total_sales
#ggplot(metrics_plot1, aes(x = metric, y = value, fill = exchange_name)) +
#  geom_bar(stat = "identity", position = position_dodge()) +
#  labs(title = "Total Volume and Total Sales Comparison",
#       # subtitle = paste("for ", singleCollectionName, secondCollectionName, thirdCollectionName),
#       x = "Metric",
#       y = "Value",
#       fill = "Exchange") +
#  theme_minimal()

opensea_data <- final_combined_stats_df %>%
  select(Name, market_cap, total_volume) %>%
  filter(final_combined_stats_df$exchange_name == "opensea")
opensea_long <- opensea_data %>%
  pivot_longer(cols = c(market_cap, total_volume), names_to = "metric", values_to = "value")
ggplot(opensea_long, aes(x = Name, y = value, fill = Name)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  facet_wrap(~ metric, scales = "free_y") +  # Facet by metric, with independent y scales
  labs(title = "Comparison of Market Cap and Total Volume",
       subtitle = "Data from Opensea for Three NFT Collections",
       x = "NFT Collection",
       y = "Value",
       fill = "NFT Collection") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis text for readability

# Save the JSON string to a file in the specified directory 
# with date and timestamp

# Set the directory path
# create this directory if an error is thrown
nftCollection_dir <- "NFT_Collection_Data/"

# Generate raw text JSON and write it to file
# Collection1
jsonSingleCollection_raw <- content(responseSingleCollection, "text")
write(jsonSingleCollection_raw, file.path(nftCollection_dir, paste0(singleCollectionName, " ", format(Sys.time(), "%Y-%m-%d %H-%M-%S"), ".json")))
# Remove raw text data, leaving just the compiled file.
rm(jsonSingleCollection_raw)

# Collection2
jsonSecondCollection_raw <- content(responseSecondCollection, "text")
write(jsonSecondCollection_raw, file.path(nftCollection_dir, paste0(secondCollectionName, " ", format(Sys.time(), "%Y-%m-%d %H-%M-%S"), ".json")))
rm(jsonSecondCollection_raw)

# Collection3
jsonThirdCollection_raw <- content(responseThirdCollection, "text")
write(jsonThirdCollection_raw, file.path(nftCollection_dir, paste0(thirdCollectionName, " ", format(Sys.time(), "%Y-%m-%d %H-%M-%S"), ".json")))
rm(jsonThirdCollection_raw)
