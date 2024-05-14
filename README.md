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
This Blockspan project has been built and publically [available here on Posit](https://posit.cloud/content/8202743).

### Steps to get this working:
Easy to follow along steps with getting this code working, zero installs required, only the aformentioned Blockspan API key
1: Open the project on [Posit.cloud](https://posit.cloud/content/8202743) and open the blockspanWithR.rmd file
2: Run the {r testrun} Code Chunk to get familiar with using R Markdown files (see below)
3: Get a free API key at [Blockspan](https://blockspan.com/)
4: Paste the key between the '' quote markts in the appropriate Code Chunk (see below)

![howto0](https://github.com/Amphlux/R_With_Blockspan/assets/115769719/7c670fd0-f991-4309-be8b-85bd25cc76e1)

![howTo1](https://github.com/Amphlux/R_With_Blockspan/assets/115769719/b582c7c8-a1d8-4fc9-8fd5-a6d3d8146c5d)

### Running code chunks on Posit
Running the code is simple on Posit. All you need to do is click the green play area located at the top right of each code chunk 
For the project, all one needs to do is follow along with the code chunks and enter their API key in the appropriate place when it comes up.

![howTo2](https://github.com/Amphlux/R_With_Blockspan/assets/115769719/50025cd8-12b3-489e-9f33-82163738e889)

![howto4](https://github.com/Amphlux/R_With_Blockspan/assets/115769719/aa31dfa7-06cf-4537-b08f-c9154691fe03)

### An API key from Blockspan
When you get to the Code Chunk containing "api <- ''" you will need to copy and paste your API key between the quote marks.
Afterwards, you can continue to run the code by clicking on each code chunk in order.
You will see a section where NFT Collections are defined. You can edit this section with your own favorite NFT collection to see different data results.

![howto5](https://github.com/Amphlux/R_With_Blockspan/assets/115769719/334be036-6b4b-40b2-ac75-04f42faeae4d)

![howto6](https://github.com/Amphlux/R_With_Blockspan/assets/115769719/19d846a0-0b61-4622-b21e-2f329633a571)

If you follow along, you can read what each Code Chunk is axcomplishing as it is ran. 
If you look at the environment section to the upper-right of the screen you will see values and data populate as you go.
These values are how R is receiving the raw JSON data, parsing it into using R Dataframes to finally produce a visual result.
If you have ran each step of the markdown successfully, you should see a chart displayed under the Plot section.

