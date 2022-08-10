# 1. Elasticsearch Field Types
<!-- TOC -->

- [1. Elasticsearch Field Types](#1-elasticsearch-field-types)
	- [1.1. Text](#11-text)
	- [1.2. Keyword](#12-keyword)
	- [1.3. Numeric](#13-numeric)
	- [1.4. Date](#14-date)
	- [1.5. Boolean](#15-boolean)
	- [1.6. Array](#16-array)
	- [1.7. IP](#17-ip)
	- [1.8. Alias](#18-alias)
	- [1.9. Binary](#19-binary)
	- [1.10. Range](#110-range)
	- [1.11. Geo-point](#111-geo-point)
	- [1.12. Geo-shape](#112-geo-shape)
	- [1.13. Object](#113-object)
	- [1.14. Nested](#114-nested)
	- [1.15. Token count](#115-token-count)
	- [1.16. Percolator](#116-percolator)
	- [1.17. Join](#117-join)
	- [1.18. *Rank feature](#118-rank-feature)
	- [1.19. *Rank features](#119-rank-features)
	- [1.20. *Dense vector](#120-dense-vector)
	- [1.21. *Sparse vector](#121-sparse-vector)

<!-- /TOC -->
## 1.1. Text

Full text value analyzed by terms.

```json
"field_1": {"type":"text"}
```
## 1.2. Keyword

A string where its value can be used for filtering, sorting, or aggregation.

```json
"field_1": {"type": "keyword"}
```

## 1.3. Numeric

- A 6-bit signed integer between [-263, 263-1].

```json
"field_1": {"type":"long"}
```

- A 32-bit signed integer between [-231, 231-1].

```json
"field_1": {"type":"integer"}
```
- A 16-bit signed integer between [-32168, 32767].

```json
"field_1": {"type":"short"}
```

- An 8-bit signed integer between [-128, 127].

```json
"field_1": {"type":"byte"}
```

- A 64-bit IEEE-754 floating point number.
```json
"field_1": {"type":"double"}
```

- A 32-bit IEEE-754 floating point number.

```json
"field_1": {"type":"float"}
```

- A 16-bit IEEE-754 floating point number.
```json
"field_1": {"type":"half_float"}
```
- A float point number using long and a scale factor.
```json
"field_1": {"type":"scaled_float"}
```

## 1.4. Date

Either a date format string or a number. A long number is the elapsed milliseconds from the epoch. An integer is the elapsed seconds from the epoch. The default date format is `strict_date_optional_time||epoch_millis`.

```json
"field_1": {"type":"date"}
```
A long number represents a formatted date in nanosecond resolution.
```json
"field_1": {"type":"date_nanos"}
```

## 1.5. Boolean

A `true` or `false` value.

```json
"field_1": {"type":"boolean"}
```

## 1.6. Array

An array of values in the same datatype. The mapping type is the element's datatype; for example, `[1, 2, 3, 4, 5]`.

```json
"field_1":{"type":"integer"}
```

## 1.7. IP

IPv4 or IPv6 address.
```json
"field_1":{"type":"ip"}
```

## 1.8. Alias

Another name of a field.

```json
"field_1": {"type": "alias", "path":"full.dotted.path.of.the.field"}
```

## 1.9. Binary

A binary value as a Base64-encoded string. By default, it is not stored and is not searchable.
```json
"field_1":{"type":"binary"}
```

## 1.10. Range

- A range of values in numeric type including integer_range, float_range, long_range, and double_range.

```json
"field_1":{"type":"long_range"}
```

- A range of values in date type.
```json
"field_1":{"type":"date_range", "format":{2019-02-15}
```

- A range of values in IP type.
```json
"field_1":{"type":"ip_range"}
```

## 1.11. Geo-point

A single location point in geo-point format.

```json
"field_1":{"type":"geo-point"}
```

## 1.12. Geo-shape

A shape in GeoJSON format, such as point, circle, box, and line.

```json
"field_1":{"type":"geo-shape"}
```

## 1.13. Object

A JSON format value.

```json
"field_1":{"properties": {

"field_1_1":{"type":"type 1_1"},

"field_1_2": {"type": "type 1_2"}}}
```

## 1.14. Nested

An array of objects. Each object is on purpose for the search.

```json
"field_1":{"type":"nested"}
```

## 1.15. Token count

A value to count the number of tokens in the text.

```json
"field_1":{"type":"text", "fields":{"field_1_1":
{"type":"token_count","analyzer":"analyzer_1"}}}
```
## 1.16. Percolator

A JSON format value to be parsed into a native query.

```json
"field_1":{"type":"percolator"}
```

## 1.17. Join

- A mapping field to create a simple parent/child relation.

```json
"field_1": {"type": "join",

"relations": {"parent_field": "child_field"}}
```

- A mapping field to create multiple levels of parent/child relation.

```json
"field_1": {"type": "join",

"relations": {"parent_field": ["child_field_1", "child_field_2"], "child_field_x":"child_of_child_field_x"}}
```

## 1.18. *Rank feature

A mapping field to provide ranking ability for the numeric field.

```json
"field_1":{"type":"rank_feature"}
```

## 1.19. *Rank features

A mapping field to provide ranking ability for the numeric feature vector.

```json
"field_1":{"type":"rank_features"}
```

## 1.20. *Dense vector

A mapping field to provide a dense vector of float values.
```json
"field_1":{"type":"dense_vector"}
```

## 1.21. *Sparse vector

A mapping field to provide a sparse vector of float values represented in `{"dimension_1": value_1, "dimension_2":value_2, ...}`. The dimension range is between [0,65536].

```json
"field_1":{"type":"sparse_vector"}
```