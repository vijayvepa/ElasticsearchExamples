# 1. Search APIs

<!-- TOC -->

- [1. Search APIs](#1-search-apis)
  - [1.1. GetAll](#11-getall)
  - [1.2. Search Params](#12-search-params)
    - [1.2.1. from](#121-from)
    - [1.2.2. size](#122-size)
    - [1.2.3. sort](#123-sort)
    - [1.2.4. \_source](#124-_source)
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
    - [1.2.15. search_type](#1215-search_type)
    - [1.2.16. timeout](#1216-timeout)
    - [1.2.17. terminate_after](#1217-terminate_after)
    - [1.2.18. track_scores](#1218-track_scores)
    - [1.2.19. track_total_hits](#1219-track_total_hits)

<!-- /TOC -->

## 1.1. GetAll

```api
GET /index_name/_search
GET /index1,index2/_search
GET /_search
```

## 1.2. Search Params

### 1.2.1. from

starting item to return in hits field

URL

```
?from=2
```

RequestBody

```json
{
  "from": 2
}
```

default: 0

### 1.2.2. size

the number of items to return in the hits field

URL

```
?size=10
```

RequestBody

```json
{
  "size": 10
}
```

default: 10

### 1.2.3. sort

sort the field by specifying `field:asc` or `field:desc`

URL

```
?sort=field:desc
?sort=_score:asc
?sort=field
```

RequestBody

```json
{
  "sort": { "field": "desc", "_score": "asc" },
  "sort": "field"
}
```

defaults to ascending

### 1.2.4. \_source

If false, no \_source field is returned

URL

```
?_source=false
```

RequestBody

```json
{
  "_source": false
}
```

### 1.2.5. q

Follow the DSL syntax to make search query

URL

```
?q=fund_name:ishares edge global
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:ishares edge global"
    }
  }
}
```

### 1.2.6. default_operator

When more than one condition is in query, specify `and|or`
URL

```
?default_operator=AND
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:ishares edge global",
      "default_operator": "AND"
    }
  }
}
```

### 1.2.7. explain

Provides a detailed explanation of relevance scoring

URL

```
explain=true
```

RequestBody

```json
{
  "explain": true
}
```

### 1.2.8. analyzer

Search analyzer to be used to analyze input query string.

URL

```
?analyzer=keyword
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:ishares edge global",
      "default_operator": "AND",
      "analyzer": "keyword"
    }
  },
  "explain": true
}
```

default: standard

### 1.2.9. stored_fields

Retrieves those params marked store in mappings. Specify with a list of comma-separated fields or disable it by specifying `_none_`

```
?stored_fields=_none_
```

```json
{
  "stored_fields": "_none_"
}
```

### 1.2.10. analyze_wildcard

determines whether to analyze wildcard or prefix queries. default:false

```
?analyze_wildcard=false
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:=* edge global",
      "default_operator": "AND",
      "analyze_wildcard": true
    }
  }
}
```

### 1.2.11. allow_partial_search_results

return partial results in the event of failure. default:true

```
?allow_partial_search_results=false
```

- must be passed in query string

### 1.2.12. batched_reduce_size

Reduces number of temporary results collected in coordinating node

```
?batched_reduce_size=5
```

- must be passed in query string

### 1.2.13. df

Specified default field to search

```
?df=fund_name
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:=ishares edge global",
      "default_operator": "AND",
      "default_field": "fund_name"
    }
  }
}
```

### 1.2.14. lenient

Ignore data type mismatch. default: false

```
?lenient=true
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:=ishares edge global",
      "default_operator": "AND",
      "lenient": false
    }
  }
}
```

### 1.2.15. search_type

- `query_then_fetch` -> good relevancy scoring method (default)
- `dfs_query_then_fetch` -> better in terms of accuracy

```
?search_type=query_then_fetch
```

- can only be specified in query string

### 1.2.16. timeout

Time permitted to complete search.

```
?timeout=5ms
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:=ishares edge global",
      "default_operator": "AND"
    }
  },
  "timeout": "5ms"
}
```

### 1.2.17. terminate_after

Number of documents permitted to be collected in a shard. Default is no limit.

```
?terminate_after=5
```

RequestBody

```json
{
  "query": {
    "query_string": {
      "query": "fund_name:=ishares edge global",
      "default_operator": "AND",
      "default_field": "fund_name"
    }
  },
  "terminate_after": 1
}
```

### 1.2.18. track_scores

Allow tracking scores when sorting available. Default false.

```
?sort=fund_name:desc&track_scores=true
```

RequestBody

```json
{
  "sort": "market_cap",
  "track_scores": true
}
```

### 1.2.19. track_total_hits

Stipulates total number of hits allowed for tracking. Can be disabled with false. Default is 10000

```
?track_total_hits=5
```

RequestBody

```json
{
  "sort": "market_cap",
  "track_total_hits": 5
}
```

### 1.2.20. scroll

See [Pagination with Scroll](#13-pagination-with-scroll) section.

```
?scroll=10m
```

- can only be specified in query string

## 1.3. Pagination with Scroll

- Forward-only cursor
- Keeps search context active, just like snapshot corresponding to a given timestamp
- If you need to process returned results further, need a snapshot
- `_scroll_id` is returned, can be used to get next batch of results
- `size` parameter controls the number of hits returned in the batch

### 1.3.1. Get Initial Batch

```
POST /cf_etf/_search?scroll=10m
```

```json
{
  "size": 313
}
```

Response

```json
{
	"_scroll_id": "<id>"
	...
}
```

### 1.3.2. Get Next Batches

NOTE: index name not specified
```
POST /_search/scroll
```

```json
{
  "scroll": "10m",
  "scroll_id": "<id>"
}
```

#### 1.3.2.1. Response (results exist)

```json
{
  "_scroll_id": "<id>",
  "hits": { "hits": ["<non_empty>"] }
}
```

#### 1.3.2.2. Response (results do not exist)

```json
{
  "_scroll_id": "<id>",
  "hits": { "hits": [] }
}
```

### 1.3.3. Cleanup Scroll

```
DELETE /_search/scroll
```

```json
{
  "scroll_id": ["<id>"]
}
```
