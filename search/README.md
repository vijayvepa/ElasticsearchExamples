# 1. Search APIs

<!-- TOC -->

- [1. Search APIs](#1-search-apis)
	- [1.1. GetAll](#11-getall)
	- [1.2. URL Search Params](#12-url-search-params)
		- [1.2.1. from](#121-from)
		- [1.2.2. size](#122-size)
		- [1.2.3. sort](#123-sort)
		- [1.2.4. _source](#124-_source)

<!-- /TOC -->

## 1.1. GetAll

```api
GET /index_name/_search
GET /index1,index2/_search
GET /_search
```

## 1.2. URL Search Params

### 1.2.1. from

starting item to return in hits field

```
?from=2
```

default: 0

### 1.2.2. size

the number of items to return in the hits field

```
?size=10
```

default: 10

### 1.2.3. sort

sort the field by specifying `field:asc` or `field:desc`
```
?sort=field:desc
?sort=_score:asc
?sort=field
```
defaults to ascending

### 1.2.4. _source
If false, no _source field is returned

```
?_source=false
```

### 1.2.5. q 
Follow the DSL syntax to make search query
```
?q=fund_name:ishares edge global
```


### 1.2.6. default_operator
When more than one condition is in query, specify `and|or`

```
?default_operator=AND
```

### 1.2.7. explain
Provides a detailed explanation of relevance scoring

```
explain=true
```

### 1.2.8. analyzer
Search analyzer to be used to analyze input query string.

```
?analyzer=keyword
```

default: standard

### stored_fields
Retrieves those params marked store in mappings. Specify with a list of comma-separated fields or disable it by specifying `_none_`

```
?stored_fields=_none_
```