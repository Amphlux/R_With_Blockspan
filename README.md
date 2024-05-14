# <center>R_With_Blockspan</center>
### <center>*Capstone project combining R programming and Blockspan API / Ethereum Blockchain queries and data visualization / dataviz*</center>
##### <center>***preffered*** [Easily run this code through Code Blocks on posit.cloud]() ***preferred***</center>
##### <center>[Peakd blogpost about this project](https://peakd.com/general/@amphlux/data-science-my-beginning)</center>
---

### The code
This code creates API calls to the Blockspan Ethereum service. These API call requests information of 3 NFT Collections, defined by their contract address.
You can get a free blockspan API code [here](https://blockspan.com/) as of the time of this writing. Feel free to write your own API calls if you prefer another service.
Once the raw JSON data is returned, the JSON is parsed into usable R Dataframes, stored as environment variables.
Once the data is usable, the code uses ggplot2 to generate visualized data. ***You should keep your API key securely stored and safe!!***

### Using the code
There are 2 files, blockspanWithR.rmd and blockSpanWithR_script.r. For those unfamiliar with R, using an online R interpreter such as Posit is highly recommended.
Posit is the creator of the widley used and well known RStudio software. However their online cloud is extremely easy to use and comes highly recommended.
This Blockspan project has been built and publically [available here on Posit]().



Running the code is simple on Posit. All one needs to do is follow along with the code chunks, and enter their API key in the appropriate place when it comes up.


---{rmd blockspanWithR}
title: 'Capstone: Data Viz for Opensea'
author: 'AJ Whitehead"
date: "MAY2024"
output: html_document
---
