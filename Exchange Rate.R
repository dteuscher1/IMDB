library(tidyverse)
── Attaching packages ────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
✓ ggplot2 3.3.2     ✓ purrr   0.3.4
✓ tibble  3.0.3     ✓ dplyr   1.0.0
✓ tidyr   1.1.0     ✓ stringr 1.4.0
✓ readr   1.3.1     ✓ forcats 0.4.0
── Conflicts ───────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
x dplyr::filter() masks stats::filter()
x dplyr::lag()    masks stats::lag()
> train <- read_csv("IMDBTrain.csv")
Parsed with column specification:
    cols(
        .default = col_double(),
        color = col_character(),
        director_name = col_character(),
        actor_2_name = col_character(),
        genres = col_character(),
        actor_1_name = col_character(),
        movie_title = col_character(),
        actor_3_name = col_character(),
        plot_keywords = col_character(),
        movie_imdb_link = col_character(),
        language = col_character(),
        country = col_character(),
        content_rating = col_character()
    )
See spec(...) for full column specifications.
> test <- read_csv("IMDBTest.csv")
Parsed with column specification:
    cols(
        .default = col_double(),
        color = col_character(),
        director_name = col_character(),
        actor_2_name = col_character(),
        genres = col_character(),
        actor_1_name = col_character(),
        movie_title = col_character(),
        actor_3_name = col_character(),
        plot_keywords = col_character(),
        language = col_character(),
        country = col_character(),
        content_rating = col_character()
    )
See spec(...) for full column specifications.
> test1 <- test %>% mutate(imdb_rating = 5) %>% bind_rows(train)
> head(test1)
# A tibble: 6 x 29
color director_name num_critic_for_… duration director_facebo… actor_3_faceboo… actor_2_name
<chr> <chr>                    <dbl>    <dbl>            <dbl>            <dbl> <chr>       
    1 NA    Doug Walker                 NA       NA              131               NA Rob Walker  
2 Color David Yates                375      153              282            10000 Daniel Radc…
3 Color Andrew Adams…              258      150               80              201 Pierfrances…
4 Color Bryan Singer               338      114                0              140 Ewen Bremner
5 Color Andrew Adams…              284      150               80               82 Kiran Shah  
6 Color David Ayer                 418      123              452              329 Robin Atkin…
# … with 22 more variables: actor_1_facebook_likes <dbl>, gross <dbl>, genres <chr>, actor_1_name <chr>,
#   movie_title <chr>, num_voted_users <dbl>, cast_total_facebook_likes <dbl>, actor_3_name <chr>,
#   facenumber_in_poster <dbl>, plot_keywords <chr>, num_user_for_reviews <dbl>, language <chr>,
#   country <chr>, content_rating <chr>, budget <dbl>, title_year <dbl>, actor_2_facebook_likes <dbl>,
#   aspect_ratio <dbl>, movie_facebook_likes <dbl>, imdb_rating <dbl>, movie_imdb_link <chr>,
#   imdb_score <dbl>
> length(unique(test1$country))
[1] 65
> unique(test1$country)
[1] NA                     "UK"                   "USA"                  "Belgium"             
[5] "Australia"            "Germany"              "Canada"               "Spain"               
[9] "France"               "South Korea"          "Libya"                "Italy"               
[13] "China"                "Russia"               "South Africa"         "Japan"               
[17] "Netherlands"          "Taiwan"               "Ireland"              "West Germany"        
[21] "India"                "Mexico"               "Hong Kong"            "Brazil"              
[25] "Kyrgyzstan"           "Greece"               "New Zealand"          "New Line"            
[29] "Czech Republic"       "Soviet Union"         "Aruba"                "Denmark"             
[33] "Iceland"              "Switzerland"          "Romania"              "Chile"               
[37] "Hungary"              "Panama"               "Norway"               "Official site"       
[41] "Cambodia"             "Thailand"             "Slovakia"             "Bulgaria"            
[45] "Iran"                 "Poland"               "Sweden"               "Georgia"             
[49] "Turkey"               "Nigeria"              "Finland"              "Bahamas"             
[53] "Argentina"            "Colombia"             "Israel"               "Egypt"               
[57] "Indonesia"            "Pakistan"             "Slovenia"             "Afghanistan"         
[61] "Dominican Republic"   "Cameroon"             "United Arab Emirates" "Kenya"               
[65] "Philippines"         
> # Load any needed packages
    > library(tidyverse)
> library(truncnorm)
> library(mvtnorm)
> # Read in the data
    > ag <- readxl::read_excel("../Data/MultiVariable_withZones.xlsx")
Error: `path` does not exist: ‘../Data/MultiVariable_withZones.xlsx’
> exchange_rates <- c(1.333048, 1.183079, .731915, 1.183079, .765707, 1.183079, 1.183079, .000843, .732160, 1.183079, .146409, .013253, .059373, .009414, 1.183079, .034073, 1.183079, 1.183079, .013647, .045970, .129029, .187244, .013, 1.183079, .676524, .044920, .013252, 1.80, .158986, .007192, 1.096524, .244275, .001296, .003303, 1,  .112718, .00024, .031935, 1.183079, .604899, .000024, .267994, .114464, .32, .135279, .0026, 1.183079, 1, .013457, .000273, .297150, .063, .000068, .006046, 1.183079, .013, .017, .0018, .27, .0092, .020584)
> countries <- unique(test1$country)
> countries <- countries[-1]
> countries
[1] "UK"                   "USA"                  "Belgium"             
[4] "Australia"            "Germany"              "Canada"              
[7] "Spain"                "France"               "South Korea"         
[10] "Libya"                "Italy"                "China"               
[13] "Russia"               "South Africa"         "Japan"               
[16] "Netherlands"          "Taiwan"               "Ireland"             
[19] "West Germany"         "India"                "Mexico"              
[22] "Hong Kong"            "Brazil"               "Kyrgyzstan"          
[25] "Greece"               "New Zealand"          "New Line"            
[28] "Czech Republic"       "Soviet Union"         "Aruba"               
[31] "Denmark"              "Iceland"              "Switzerland"         
[34] "Romania"              "Chile"                "Hungary"             
[37] "Panama"               "Norway"               "Official site"       
[40] "Cambodia"             "Thailand"             "Slovakia"            
[43] "Bulgaria"             "Iran"                 "Poland"              
[46] "Sweden"               "Georgia"              "Turkey"              
[49] "Nigeria"              "Finland"              "Bahamas"             
[52] "Argentina"            "Colombia"             "Israel"              
[55] "Egypt"                "Indonesia"            "Pakistan"            
[58] "Slovenia"             "Afghanistan"          "Dominican Republic"  
[61] "Cameroon"             "United Arab Emirates" "Kenya"               
[64] "Philippines"         
> countries <- countries[-2]
> countries
[1] "UK"                   "Belgium"              "Australia"           
[4] "Germany"              "Canada"               "Spain"               
[7] "France"               "South Korea"          "Libya"               
[10] "Italy"                "China"                "Russia"              
[13] "South Africa"         "Japan"                "Netherlands"         
[16] "Taiwan"               "Ireland"              "West Germany"        
[19] "India"                "Mexico"               "Hong Kong"           
[22] "Brazil"               "Kyrgyzstan"           "Greece"              
[25] "New Zealand"          "New Line"             "Czech Republic"      
[28] "Soviet Union"         "Aruba"                "Denmark"             
[31] "Iceland"              "Switzerland"          "Romania"             
[34] "Chile"                "Hungary"              "Panama"              
[37] "Norway"               "Official site"        "Cambodia"            
[40] "Thailand"             "Slovakia"             "Bulgaria"            
[43] "Iran"                 "Poland"               "Sweden"              
[46] "Georgia"              "Turkey"               "Nigeria"             
[49] "Finland"              "Bahamas"              "Argentina"           
[52] "Colombia"             "Israel"               "Egypt"               
[55] "Indonesia"            "Pakistan"             "Slovenia"            
[58] "Afghanistan"          "Dominican Republic"   "Cameroon"            
[61] "United Arab Emirates" "Kenya"                "Philippines"         
> countries <- countries[-26]
> countries
[1] "UK"                   "Belgium"              "Australia"           
[4] "Germany"              "Canada"               "Spain"               
[7] "France"               "South Korea"          "Libya"               
[10] "Italy"                "China"                "Russia"              
[13] "South Africa"         "Japan"                "Netherlands"         
[16] "Taiwan"               "Ireland"              "West Germany"        
[19] "India"                "Mexico"               "Hong Kong"           
[22] "Brazil"               "Kyrgyzstan"           "Greece"              
[25] "New Zealand"          "Czech Republic"       "Soviet Union"        
[28] "Aruba"                "Denmark"              "Iceland"             
[31] "Switzerland"          "Romania"              "Chile"               
[34] "Hungary"              "Panama"               "Norway"              
[37] "Official site"        "Cambodia"             "Thailand"            
[40] "Slovakia"             "Bulgaria"             "Iran"                
[43] "Poland"               "Sweden"               "Georgia"             
[46] "Turkey"               "Nigeria"              "Finland"             
[49] "Bahamas"              "Argentina"            "Colombia"            
[52] "Israel"               "Egypt"                "Indonesia"           
[55] "Pakistan"             "Slovenia"             "Afghanistan"         
[58] "Dominican Republic"   "Cameroon"             "United Arab Emirates"
[61] "Kenya"                "Philippines"         
> countries <- countries[-37]
> countries
[1] "UK"                   "Belgium"              "Australia"           
[4] "Germany"              "Canada"               "Spain"               
[7] "France"               "South Korea"          "Libya"               
[10] "Italy"                "China"                "Russia"              
[13] "South Africa"         "Japan"                "Netherlands"         
[16] "Taiwan"               "Ireland"              "West Germany"        
[19] "India"                "Mexico"               "Hong Kong"           
[22] "Brazil"               "Kyrgyzstan"           "Greece"              
[25] "New Zealand"          "Czech Republic"       "Soviet Union"        
[28] "Aruba"                "Denmark"              "Iceland"             
[31] "Switzerland"          "Romania"              "Chile"               
[34] "Hungary"              "Panama"               "Norway"              
[37] "Cambodia"             "Thailand"             "Slovakia"            
[40] "Bulgaria"             "Iran"                 "Poland"              
[43] "Sweden"               "Georgia"              "Turkey"              
[46] "Nigeria"              "Finland"              "Bahamas"             
[49] "Argentina"            "Colombia"             "Israel"              
[52] "Egypt"                "Indonesia"            "Pakistan"            
[55] "Slovenia"             "Afghanistan"          "Dominican Republic"  
[58] "Cameroon"             "United Arab Emirates" "Kenya"               
[61] "Philippines"         
> exchange_rates_df <- data.frame(country = countries, exchange_rate = exchange_rates)
> head(exchange_rates_df)
country exchange_rate
1        UK      1.333048
2   Belgium      1.183079
3 Australia      0.731915
4   Germany      1.183079
5    Canada      0.765707
6     Spain      1.183079
> train %>% left_join(exchange_rates_df, by = "country")
# A tibble: 4,428 x 29
color director_name num_critic_for_… duration director_facebo… actor_3_faceboo…
<chr> <chr>                    <dbl>    <dbl>            <dbl>            <dbl>
    1 Color James Cameron              723      178                0              855
2 Color Gore Verbins…              302      169              563             1000
3 Color Sam Mendes                 602      148                0              161
4 Color Christopher …              813      164            22000            23000
5 NA    Doug Walker                 NA       NA              131               NA
6 Color Andrew Stant…              462      132              475              530
7 Color Nathan Greno               324      100               15              284
8 Color Joss Whedon                635      141                0            19000
9 Color David Yates                375      153              282            10000
10 Color Zack Snyder                673      183                0             2000
# … with 4,418 more rows, and 23 more variables: actor_2_name <chr>,
#   actor_1_facebook_likes <dbl>, gross <dbl>, genres <chr>, actor_1_name <chr>,
#   movie_title <chr>, num_voted_users <dbl>, cast_total_facebook_likes <dbl>,
#   actor_3_name <chr>, facenumber_in_poster <dbl>, plot_keywords <chr>,
#   movie_imdb_link <chr>, num_user_for_reviews <dbl>, language <chr>, country <chr>,
#   content_rating <chr>, budget <dbl>, title_year <dbl>, actor_2_facebook_likes <dbl>,
#   imdb_score <dbl>, aspect_ratio <dbl>, movie_facebook_likes <dbl>, exchange_rate <dbl>
> train %>% select(country, budget, exchange_rates) %>% mutate(budget_dollars = budget * exchange_rates) %>% top_n(10)
Note: Using an external vector in selections is ambiguous.
ℹ Use `all_of(exchange_rates)` instead of `exchange_rates` to silence this message.
ℹ See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
This message is displayed once per session.
Error: Must subset columns with a valid subscript vector.
x Can't convert from <double> to <integer> due to loss of precision.
Run `rlang::last_error()` to see where the error occurred.
> train %>% select(country, budget, exchange_rates) %>% mutate(budget_dollars = budget * exchange_rates)
Error: Must subset columns with a valid subscript vector.
x Can't convert from <double> to <integer> due to loss of precision.
Run `rlang::last_error()` to see where the error occurred.
> train %>% select(country, budget, exchange_rate) %>% mutate(budget_dollars = budget * exchange_rates)
Error: Can't subset columns that don't exist.
x Column `exchange_rate` doesn't exist.
Run `rlang::last_error()` to see where the error occurred.
> train %>% left_join(exchange_rates_df, by = "country") %>% select(country, budget, exchange_rate) %>% mutate(budget_dollars = budget * exchange_rates)
# A tibble: 4,428 x 4
   country    budget exchange_rate budget_dollars
   <chr>       <dbl>         <dbl>          <dbl>
 1 USA     237000000         NA        315932376 
 2 USA     300000000         NA        354923700 
 3 UK      245000000          1.33     179319175 
 4 USA     250000000         NA        295769750 
 5 NA             NA         NA               NA 
 6 USA     263700000         NA        311977932.
 7 USA     260000000         NA        307600540 
 8 USA     250000000         NA           210750 
 9 UK      250000000          1.33     183040000 
10 USA     250000000         NA        295769750 
# … with 4,418 more rows
Warning message:
In budget * exchange_rates :
  longer object length is not a multiple of shorter object length
> train %>% left_join(exchange_rates_df, by = "country") %>% select(country, budget, exchange_rate, movie_title) %>% mutate(budget_dollars = budget * exchange_rates) %>% arrange(desc(budget_dollars))
# A tibble: 4,428 x 5
   country      budget exchange_rate movie_title                               budget_dollars
   <chr>         <dbl>         <dbl> <chr>                                              <dbl>
 1 Japan    2400000000       0.00941 Princess Mononoke                             648000000 
 2 Hungary  2500000000       0.00330 Fateless                                      610687500 
 3 Thailand  400000000       0.0319  The Legend of Suriyothai                      533219200 
 4 UK        200000000       1.33    Skyfall                                       360000000 
 5 USA       300000000      NA       Pirates of the Caribbean: At World's End      354923700 
6 USA       237000000      NA       Avatar                                        315932376 
7 USA       263700000      NA       John Carter                                   311977932.
8 USA       260000000      NA       Tangled                                       307600540 
9 USA       250000000      NA       The Dark Knight Rises                         295769750 
10 USA       250000000      NA       Batman v Superman: Dawn of Justice            295769750 
# … with 4,418 more rows
Warning message:
    In budget * exchange_rates :
    longer object length is not a multiple of shorter object length
> train %>% left_join(exchange_rates_df, by = "country") %>% select(country, budget, exchange_rate, movie_title) %>% mutate(exchange_rate = ifelse(country == "USA", 1, exchange_rate), budget_dollars = budget * exchange_rates) %>% arrange(desc(budget_dollars))
# A tibble: 4,428 x 5
country      budget exchange_rate movie_title                               budget_dollars
<chr>         <dbl>         <dbl> <chr>                                              <dbl>
    1 Japan    2400000000       0.00941 Princess Mononoke                             648000000 
2 Hungary  2500000000       0.00330 Fateless                                      610687500 
3 Thailand  400000000       0.0319  The Legend of Suriyothai                      533219200 
4 UK        200000000       1.33    Skyfall                                       360000000 
5 USA       300000000       1       Pirates of the Caribbean: At World's End      354923700 
 6 USA       237000000       1       Avatar                                        315932376 
 7 USA       263700000       1       John Carter                                   311977932.
 8 USA       260000000       1       Tangled                                       307600540 
 9 USA       250000000       1       The Dark Knight Rises                         295769750 
10 USA       250000000       1       Batman v Superman: Dawn of Justice            295769750 
# … with 4,418 more rows
Warning message:
In budget * exchange_rates :
  longer object length is not a multiple of shorter object length
> train %>% left_join(exchange_rates_df, by = "country") %>% select(country, budget, exchange_rate, movie_title) %>% mutate(exchange_rate = ifelse(country == "USA", 1, exchange_rate), budget_dollars = budget * exchange_rate) %>% arrange(desc(budget_dollars))
# A tibble: 4,428 x 5
   country    budget exchange_rate movie_title                               budget_dollars
   <chr>       <dbl>         <dbl> <chr>                                              <dbl>
 1 Spain   700000000          1.18 Tango                                          828155300
 2 France  390000000          1.18 The Messenger: The Story of Joan of Arc        461400810
 3 UK      250000000          1.33 Harry Potter and the Half-Blood Prince         333262000
 4 UK      245000000          1.33 Spectre                                        326596760
 5 USA     300000000          1    Pirates of the Caribbean: At World's End       300000000
6 UK      200000000          1.33 Quantum of Solace                              266609600
7 UK      200000000          1.33 Skyfall                                        266609600
8 USA     263700000          1    John Carter                                    263700000
9 USA     260000000          1    Tangled                                        260000000
10 USA     250000000          1    The Dark Knight Rises                          250000000
# … with 4,418 more rows
> train %>% left_join(exchange_rates_df, by = "country") %>% select(country, budget, exchange_rate, movie_title, year) %>% mutate(exchange_rate = ifelse(country == "USA", 1, exchange_rate), budget_dollars = budget * exchange_rate) %>% arrange(desc(budget_dollars))
Error: Can't subset columns that don't exist.
x Column `year` doesn't exist.
Run `rlang::last_error()` to see where the error occurred.
> str(train)
tibble [4,428 × 28] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
 $ color                    : chr [1:4428] "Color" "Color" "Color" "Color" ...
 $ director_name            : chr [1:4428] "James Cameron" "Gore Verbinski" "Sam Mendes" "Christopher Nolan" ...
 $ num_critic_for_reviews   : num [1:4428] 723 302 602 813 NA 462 324 635 375 673 ...
 $ duration                 : num [1:4428] 178 169 148 164 NA 132 100 141 153 183 ...
 $ director_facebook_likes  : num [1:4428] 0 563 0 22000 131 475 15 0 282 0 ...
 $ actor_3_facebook_likes   : num [1:4428] 855 1000 161 23000 NA 530 284 19000 10000 2000 ...
 $ actor_2_name             : chr [1:4428] "Joel David Moore" "Orlando Bloom" "Rory Kinnear" "Christian Bale" ...
 $ actor_1_facebook_likes   : num [1:4428] 1000 40000 11000 27000 131 640 799 26000 25000 15000 ...
 $ gross                    : num [1:4428] 7.61e+08 3.09e+08 2.00e+08 4.48e+08 NA ...
 $ genres                   : chr [1:4428] "Action|Adventure|Fantasy|Sci-Fi" "Action|Adventure|Fantasy" "Action|Adventure|Thriller" "Action|Thriller" ...
 $ actor_1_name             : chr [1:4428] "CCH Pounder" "Johnny Depp" "Christoph Waltz" "Tom Hardy" ...
 $ movie_title              : chr [1:4428] "Avatar " "Pirates of the Caribbean: At World's End " "Spectre " "The Dark Knight Rises " ...
 $ num_voted_users          : num [1:4428] 886204 471220 275868 1144337 8 ...
 $ cast_total_facebook_likes: num [1:4428] 4834 48350 11700 106759 143 ...
 $ actor_3_name             : chr [1:4428] "Wes Studi" "Jack Davenport" "Stephanie Sigman" "Joseph Gordon-Levitt" ...
 $ facenumber_in_poster     : num [1:4428] 0 0 1 0 0 1 1 4 3 0 ...
 $ plot_keywords            : chr [1:4428] "avatar|future|marine|native|paraplegic" "goddess|marriage ceremony|marriage proposal|pirate|singapore" "bomb|espionage|sequel|spy|terrorist" "deception|imprisonment|lawlessness|police officer|terrorist plot" ...
 $ movie_imdb_link          : chr [1:4428] "http://www.imdb.com/title/tt0499549/?ref_=fn_tt_tt_1" "http://www.imdb.com/title/tt0449088/?ref_=fn_tt_tt_1" "http://www.imdb.com/title/tt2379713/?ref_=fn_tt_tt_1" "http://www.imdb.com/title/tt1345836/?ref_=fn_tt_tt_1" ...
 $ num_user_for_reviews     : num [1:4428] 3054 1238 994 2701 NA ...
 $ language                 : chr [1:4428] "English" "English" "English" "English" ...
 $ country                  : chr [1:4428] "USA" "USA" "UK" "USA" ...
 $ content_rating           : chr [1:4428] "PG-13" "PG-13" "PG-13" "PG-13" ...
 $ budget                   : num [1:4428] 2.37e+08 3.00e+08 2.45e+08 2.50e+08 NA ...
 $ title_year               : num [1:4428] 2009 2007 2015 2012 NA ...
 $ actor_2_facebook_likes   : num [1:4428] 936 5000 393 23000 12 632 553 21000 11000 4000 ...
 $ imdb_score               : num [1:4428] 7.9 7.1 6.8 8.5 7.1 6.6 7.8 7.5 7.5 6.9 ...
 $ aspect_ratio             : num [1:4428] 1.78 2.35 2.35 2.35 NA 2.35 1.85 2.35 2.35 2.35 ...
 $ movie_facebook_likes     : num [1:4428] 33000 0 85000 164000 0 24000 29000 118000 10000 197000 ...
 - attr(*, "spec")=
  .. cols(
  ..   color = col_character(),
  ..   director_name = col_character(),
  ..   num_critic_for_reviews = col_double(),
  ..   duration = col_double(),
  ..   director_facebook_likes = col_double(),
  ..   actor_3_facebook_likes = col_double(),
  ..   actor_2_name = col_character(),
  ..   actor_1_facebook_likes = col_double(),
  ..   gross = col_double(),
  ..   genres = col_character(),
  ..   actor_1_name = col_character(),
  ..   movie_title = col_character(),
  ..   num_voted_users = col_double(),
  ..   cast_total_facebook_likes = col_double(),
  ..   actor_3_name = col_character(),
  ..   facenumber_in_poster = col_double(),
  ..   plot_keywords = col_character(),
  ..   movie_imdb_link = col_character(),
  ..   num_user_for_reviews = col_double(),
  ..   language = col_character(),
  ..   country = col_character(),
  ..   content_rating = col_character(),
  ..   budget = col_double(),
  ..   title_year = col_double(),
  ..   actor_2_facebook_likes = col_double(),
  ..   imdb_score = col_double(),
  ..   aspect_ratio = col_double(),
  ..   movie_facebook_likes = col_double()
  .. )
> train %>% left_join(exchange_rates_df, by = "country") %>% select(country, budget, exchange_rate, movie_title, title_year) %>% mutate(exchange_rate = ifelse(country == "USA", 1, exchange_rate), budget_dollars = budget * exchange_rate) %>% arrange(desc(budget_dollars))
# A tibble: 4,428 x 6
   country    budget exchange_rate movie_title                               title_year budget_dollars
   <chr>       <dbl>         <dbl> <chr>                                          <dbl>          <dbl>
 1 Spain   700000000          1.18 Tango                                           1998      828155300
 2 France  390000000          1.18 The Messenger: The Story of Joan of Arc         1999      461400810
 3 UK      250000000          1.33 Harry Potter and the Half-Blood Prince          2009      333262000
 4 UK      245000000          1.33 Spectre                                         2015      326596760
 5 USA     300000000          1    Pirates of the Caribbean: At World's End        2007      300000000
 6 UK      200000000          1.33 Quantum of Solace                               2008      266609600
 7 UK      200000000          1.33 Skyfall                                         2012      266609600
 8 USA     263700000          1    John Carter                                     2012      263700000
 9 USA     260000000          1    Tangled                                         2010      260000000
10 USA     250000000          1    The Dark Knight Rises                           2012      250000000
# … with 4,418 more rows
> USA <- data.frame(country = "USA", exchange_rate = 1)
> exchange_rates_df <- exchange_rates_df %>% bind_rows(USA)
> write_csv("exchange_rates.csv")
Error in write_delim(x, path, delim = ",", na = na, append = append, col_names = col_names,  : 
  is.data.frame(x) is not TRUE
> write_csv(exchange_rates_df, "exchange_rates.csv")
