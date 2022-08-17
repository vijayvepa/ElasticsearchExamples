# Search APIs

## GetAll

```api
GET /index_name/_search
GET /index1,index2/_search
GET /_search
```

## URL Search Params

### from

starting item to return in hits field

```
?from=2
```

default: 0

### size

the number of items to return in the hits field

```
?size=10
```

default: 10

### sort

sort the field by specifying `field:asc` or `field:desc`
```
?sort=field:desc
?sort=_score:asc
?sort=field
```
defaults to ascending

### _source
If false, no _source field is returned

```
?_source=false
```