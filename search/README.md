# 1. Search APIs

<!-- TOC -->

- [1. Search APIs](#1-search-apis)
	- [1.1. GetAll](#11-getall)
	- [1.2. URL Search Params](#12-url-search-params)
		- [1.2.1. from](#121-from)
		- [1.2.2. size](#122-size)
		- [1.2.3. sort](#123-sort)
		- [1.2.4. _source](#124-_source)
		- [1.2.5. q](#125-q)
		- [1.2.6. default_operator](#126-default_operator)
		- [1.2.7. explain](#127-explain)
		- [1.2.8. analyzer](#128-analyzer)
		- [1.2.9. stored_fields](#129-stored_fields)
		- [1.2.10. analyze_wildcard](#1210-analyze_wildcard)
		- [1.2.11. allow_partial_search_results](#1211-allow_partial_search_results)
		- [1.2.12. batched_reduce_size](#1212-batched_reduce_size)
		- [1.2.13. df](#1213-df)
		- [1.2.14. lenient](#1214-lenient)

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

### 1.2.9. stored_fields
Retrieves those params marked store in mappings. Specify with a list of comma-separated fields or disable it by specifying `_none_`

```
?stored_fields=_none_
```

### 1.2.10. analyze_wildcard
determines whether to analyze wildcard or prefix queries. default:false

```
?analyze_wildcard=false
```

### 1.2.11. allow_partial_search_results
return partial results in the event of failure. default:true

```
?allow_partial_search_results=false
```

### 1.2.12. batched_reduce_size
Reduces number of temporary results collected in coordinating node

```
?batched_reduce_size=5
```

### 1.2.13. df
Specified default field to search

```
?df=fund_name
```

### 1.2.14. lenient
Ignore data type mismatch. default: false

```
?lenient=true
```
