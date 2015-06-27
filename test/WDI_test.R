# Warning no longer works
rm(list=ls())
library(RJSONIO)
library(WDI)
library(ggplot2)

# Country list
co = c('IN', 'US', 'BR', 'CN')
co1 = c('IN', 'CN')

# Cache
cache = WDIcache()
str(cache)

# Search
WDIsearch('gdp.*capita.*constant')
WDIsearch('gdp.*capita.*constant', cache=cache)

# 1 country 1 indicator
x = WDI(country='US', indicator='NY.GDP.PCAP.KD', start=1960, end=2005)
head(x)

# 3 countries 1 indicator
x = WDI(country=co1, indicator='NY.GDP.PCAP.PP.KD', start=1990, end=2011)

head(x)
ggplot(x, aes(year, NY.GDP.PCAP.PP.KD)) + geom_line(stat="identity", aes(color=country))


y = WDI(country=co, indicator='EN.CO2.ETOT.MT', start=1960, end=2011)
ggplot(y, aes(year, EN.CO2.ETOT.MT)) + geom_line(stat="identity", aes(color=country))

# 1 bad country (should raise warning) 
x = WDI(country=c('BADCOUNTRY_one', 'BADCOUNTRY_two', 'CA', 'MX', 'US'), indicator='NY.GDP.PCAP.KD', start=1960, end=2005)
head(x)

# Multiple indicators 1 country
x = WDIsearch('gdp.*capita')
x = WDI(country=co, indicator=x[,1], start=2002, end=2003)
head(x)

# Multiple indicators 1 country + 2 bad indicator (should raise warning)
x = WDIsearch('gdp.*capita')
x = WDI(country=c('BADCOUNTRY', 'CA', 'MX'), indicator=c('BADIND1', 'BADIND2',  x[1:4,1]))
head(x)

# All countries, multiple indicators
x = WDIsearch('gdp.*capita')
x = WDI(country='all', indicator=c('BADIND', x[1:4,1]))
head(x)

# Bad, but allowable user input
x = WDIsearch('gdp.*capita')
x = WDI(country=c('MX', 'all'), indicator=c('BADIND', x[1:4,1]))
head(x)

# Long list of countries
x = WDI(country=WDI_data[[2]][,'iso2c'])
head(x)

# Extra information
rm(x)
x = WDI(country=co, extra=TRUE)

# iso3c and iso2c
x = WDI(country=c('US', 'CAN'))

