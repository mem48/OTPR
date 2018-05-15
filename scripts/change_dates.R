cal = read.csv("D:/Users/earmmor/OneDrive - University of Leeds/Routing/atoc-gtfs/calendar.txt")
cal$start_date = 20170101
cal$end_date = 20200101
head(cal)
write.csv(cal,"D:/Users/earmmor/OneDrive - University of Leeds/Routing/atoc-gtfs/calendar2.txt", row.names = F)
