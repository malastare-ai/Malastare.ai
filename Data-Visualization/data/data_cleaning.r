data = read.csv('data/airlines_data.csv')
head(data)
str(data)

library(dplyr)

aggregated_data <- 
                    subset( data, !is.na(arr_flights) & !is.na(arr_del15)) %>%
                    group_by(year, carrier_name) %>%
                    summarise(
                                arrivals = sum(arr_flights),
                                delayed  = sum(arr_del15),
                                cancelled = sum(arr_cancelled),
                                diverted = sum(arr_diverted),
                                delay_rate = 100*delayed/arrivals,
                                timely_rate = 100 - delay_rate
                                
                    )

top_flights <- aggregated_data %>%
                group_by(carrier_name) %>%
                summarise( arrivals = mean(arrivals) )
                           

top_flights <- top_flights[ order(top_flights$arrivals, decreasing = TRUE), ]

selected_airlines <-  top_flights$carrier_name[1:5]

final_data <- subset(aggregated_data, is.element(carrier_name, selected_airlines))

write.csv(final_data, 'data/summarized_data.csv')
