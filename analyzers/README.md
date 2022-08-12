# 1. Analyzers

<!-- TOC -->

- [1. Analyzers](#1-analyzers)
	- [1.1. Workflow](#11-workflow)
	- [1.2. Analyzer Components](#12-analyzer-components)
		- [1.2.1. Analyzer](#121-analyzer)
		- [1.2.2. Standard analyzer](#122-standard-analyzer)
	- [1.3. Tokenizers](#13-tokenizers)
		- [1.3.1. Word-Oriented Tokenizers](#131-word-oriented-tokenizers)
			- [1.3.1.1. standard](#1311-standard)
			- [1.3.1.2. letter](#1312-letter)
			- [1.3.1.3. lowercase](#1313-lowercase)
			- [1.3.1.4. whitespace](#1314-whitespace)
			- [1.3.1.5. uax_url_email](#1315-uax_url_email)
			- [1.3.1.6. classic](#1316-classic)
			- [1.3.1.7. thai](#1317-thai)
		- [1.3.2. Partial Word Tokenizers](#132-partial-word-tokenizers)
			- [1.3.2.1. ngram](#1321-ngram)
			- [1.3.2.2. edge_ngram](#1322-edge_ngram)
		- [1.3.3. Structured Text Tokenizers](#133-structured-text-tokenizers)
			- [1.3.3.1. keyword](#1331-keyword)
			- [1.3.3.2. pattern](#1332-pattern)
			- [1.3.3.3. char_group](#1333-char_group)
			- [1.3.3.4. simple_pattern](#1334-simple_pattern)
			- [1.3.3.5. simple_pattern_split](#1335-simple_pattern_split)
			- [1.3.3.6. path_hierarchy](#1336-path_hierarchy)
	- [1.4. Token Filters](#14-token-filters)
		- [1.4.1. asciifolding](#141-asciifolding)
		- [1.4.2. ngram](#142-ngram)
		- [1.4.3. edge_ngram](#143-edge_ngram)
		- [1.4.4. lowercase (uppercase)](#144-lowercase-uppercase)
		- [1.4.5. Fingerprint](#145-fingerprint)
		- [1.4.6. keep](#146-keep)
		- [1.4.7. keep_types](#147-keep_types)
		- [1.4.8. stemmer](#148-stemmer)
		- [1.4.9. stop](#149-stop)
		- [1.4.10. unique](#1410-unique)
		- [1.4.11. conditional](#1411-conditional)
		- [1.4.12. predicate_token_filter](#1412-predicate_token_filter)

<!-- /TOC -->

## 1.1. Workflow

- Index operation

  - Contents Processed by Analyzer
  - Generated tokens are used to build an inverted index

- Search operation
  - Query content is processed by Search Analyzer to Generate tokens for matching
  - Generated tokens are matched against inverted index

## 1.2. Analyzer Components

- Inverted Index
- Lists of Unique Words and Document Ids they Appear in
- List of Word Frequencies

### 1.2.1. Analyzer

- N `Character Filters`
  - Add/Remove Characters from Input String
- 1 `Tokenizer`
  - Split the Output of Character Filters into Unique Terms
- N `Token Filters`
  - Add/Remove Characters from Terms

### 1.2.2. Standard analyzer

`"<body>You'll love Elasticsearch 7.0.</body>".`

- `Standard` Tokenizer

  - Grammar based tokenization
  - `[body, You'll, love, Elasticsearch, 7.0, body]`

- `Lowercase` Token Filter
  - Normalize tokens to lowercase
  - `[body, you'll, love, elasticsearch, 7.0, body]`

## 1.3. Tokenizers

### 1.3.1. Word-Oriented Tokenizers

#### 1.3.1.1. standard

This is grammar-based tokenization. It supports the `max_token_length` parameter to divide the input text into segments.

- `"POST https://api.iextrading.com/1.0/stock/acwf/company /usr/local"` =>
- `[POST, https, "api.iextrading.com", "1.0", "stock", "acwf", "company", "usr", "local"]`

#### 1.3.1.2. letter

This uses non-letters as separators to split the character stream into terms.

- `"POST https://api.iextrading.com/1.0/stock/acwf/company /usr/local"` =>
- `["POST", "https", "api", "iextrading", "com", "stock", "acwf", "company", "usr", "local"]`

#### 1.3.1.3. lowercase

Similar to the letter tokenizer, it uses non-letters as separators to tokenize the input text. In addition, it also converts the lettersfrom uppercase to lowercase.

- `"POST https://api.iextrading.com/1.0/stock/acwf/company /usr/local"` =>
- `["post", "https", "api", "iextrading", "com", "stock", "acwf", "company", "usr", "local"]`

#### 1.3.1.4. whitespace

This uses whitespace characters as separators to split the character stream into terms.

- `"POST https://api.iextrading.com/1.0/stock/acwf/company /usr/local"` =>
- `["POST", "https://api.iextrading.com/1.0/stock/acwf/company", "/usr/local"]`

#### 1.3.1.5. uax_url_email

This splits character streams into URL format terms and email address format terms.

- `"POST https://api.iextrading.com/1.0/stock/acwf/company /usr/local"` =>
- `["POST", "https://api.iextrading.com/1.0/stock/acwf/company", "usr", "local"]`

#### 1.3.1.6. classic

This is grammar-based tokenization. Additionally, it uses punctuation as a separator but retains some special formatting, such as dots between the non-whitespace characters, hyphens between the numbers, email addresses, and internet hostnames.

- `"POST https://api.iextrading.com/1.0/stock/acwf/company 192.168.0.1 100-123"`=>
- `["POST", "https", "api.iextrading.com", "1.0/stock", "acwf", "company", "192.168.0.1", "100-123"]`

#### 1.3.1.7. thai

This is similar to the standard tokenizer, but uses Thai text.

- `"คุณจะรัก Elasticsearch 7.0"` =>
- `["คุณ, "จะ", "รัก", "Elasticsearch", "7.0"]`

### 1.3.2. Partial Word Tokenizers

#### 1.3.2.1. ngram

This slides along the input character stream to provide items in the specified length of the specified characters. It uses `min_gram` (this defaults to `1`) and `max_gram`(this defaults to `2`) to specify the length and `token_chars` to specify the `letters`, `digits`, `whitespace`, `punctuation`, and `symbol`.

```json
{
  "type": "ngram",
  "min_gram": 2,
  "max_gram": 2,
  "token_chars": ["punctuation", "digit"]
}
```

- `"Elasticsearch 7.0"` =>
- `["7.", ".0"]`

#### 1.3.2.2. edge_ngram

This is similar to the ngram tokenizer. The difference is that each item is anchored to the starting point of the candidate words.

```json
{
  "type": "edge_ngram",
  "min_gram": 2,
  "max_gram": 2,
  "token_chars": ["punctuation", "digit"]
}
```

- `"Elasticsearch 7.0"` =>
- `["7."]`

### 1.3.3. Structured Text Tokenizers

#### 1.3.3.1. keyword

This outputs the same text as the input character stream as a term.

- `"Elasticsearch 7.0"` =>
- `["Elasticsearch 7.0"]`

#### 1.3.3.2. pattern

This uses a regular expression to perform pattern matching to process the input character stream to obtain terms. The default pattern is `\W+`. Use `pattern` to specify the regular expression; use `flags` to specify the flag of the Java regular expression; and use `group` to specify the group matched.

- `"Elasticsearch 7.0"` =>
- `["Elasticsearch", "7", "0"]`

#### 1.3.3.3. char_group

You can define a set of separators to split the input character stream into terms. Use tokenize_on_chars to specify a list of separators.

```json
{ "type": "char_group", "tokenize_on_chars": ["whitespace", "punctuation"] }
```

- `"Elasticsearch 7.0"` =>
- `["Elasticsearch", "7", "0"]`

#### 1.3.3.4. simple_pattern

This is similar to the pattern tokenizer, but with Lucene regular expressions. The tokenization is usually faster (for more information, you can refer to https://lucene.apache.org/core/7_0_1/core/org/apache/lucene/util/automaton/RegExp.html). The following example matches words only made from letters.

```json
{ "type": "simple_pattern", "pattern": "[a-zA-Z]*" }
```

- `"Elasticsearch 7.0"` =>
- `["Elasticsearch"]`

#### 1.3.3.5. simple_pattern_split

You can define the pattern as a separator to split the input character stream into terms. Use pattern to specify the pattern of the separator.

```json
{ "type": "simple_pattern_split", "pattern": "[a-zA-Z.]*" }
```

- `"Elasticsearch 7.0"` =>
- `["7", "0"]`

#### 1.3.3.6. path_hierarchy

This uses the path separator to split the input character stream into terms. The following parameters can be set: `delimiter` (the separator), `replacement` (the character to replace the delimiter), `buffer_size` (the maximum length in one batch), `reverse` (this reverses the generated terms), and `skip` (the number of generated terms to skip).

```json
{ "type": "path_hierarchy", "replacement": "*" }
```

- `"/usr/local"` =>
- `["*user", "*usr*local"]`

## 1.4. Token Filters

### 1.4.1. asciifolding

This transforms the terms when letters, numbers, and unicode symbols are not in the first 127 ASCII characters to ASCII. The `preserve_original` parameter (this defaults to `false`) will retain the original terms if it is true.

```json
{ "type": "asciifolding", "preserve_original": true }
```

- `"Ÿőű'ľľ ľőνė Ȅľȁśťĩćŝėȁŕćĥ 7.0"` =>
- `["You'll", "Ÿőű'ľľ", "love", "ľőνė", "Elasticsearch", "Ȅľȁśťĩćŝėȁŕćĥ", "7.0"]`

### 1.4.2. ngram

This slides along the output term from the tokenizer to provide items in the specified length of the specified characters. Use `min_gram` (this defaults to `1`) and `max_gram` (this defaults to `2`) to specify the length.

```json
[{ "type": "ngram", "min_gram": 10, "max_gram": 10 }]
```

- `"You'll love Elasticsearch 7.0"` =>
- `["Elasticsea", "lasticsear", "asticsearc", "sticsearch"]`

### 1.4.3. edge_ngram

This is similar to the ngram token filter. The difference is that each item is anchored to the starting point of the candidate terms.

```json
[{ "type": "edge_ngram", "min_gram": 10, "max_gram": 10 }]
```

- `"You'll love Elasticsearch 7.0"` =>
- `["Elasticsea"]`

### 1.4.4. lowercase (uppercase)

This converts all the letters of the terms to lowercase (from uppercase).

```json
 ["lowercase"] (["uppercase"])
```

- `"You'll love Elasticsearch 7.0"` =>
- `["you'll", "love", "elasticsearch", "7.0"]`

### 1.4.5. Fingerprint

Sort, deduplicate, and concatenate the terms from the tokenizer into one term. The separator parameter (this defaults to the space character) can be set to another character. The max_output_size parameter (this defaults to 255) will restrict the emitting of the final concatenated term.

```json
["fingerprint"]
```

- `"You'll love Elasticsearch 7.0"` =>
- `["7.0 Elasticsearch You'll love"]`

### 1.4.6. keep

Only those terms defined in the list of specified words are kept. Three options are provided: the `keep_words` parameter allows you to specify a list of words in the filter; the `keep_words_path` parameter allows you to specify a list of words in the file path; and the `keep_words_case` parameter (this defaults to `false`) converts the terms to `lowercase`.

```json
[{ "type": "keep", "keep_words": ["Elasticsearch", "7.0"] }]
```

- `"You'll love Elasticsearch 7.0"` =>
- `["Elasticsearch", "7.0"]`

### 1.4.7. keep_types

Only those terms defined in the list of specified token types are kept. One option is provided: the `mode` parameter (this defaults to `include`) allows you to `include` or `exclude` specified types of terms.

```json
[{ "type": "keep_types", "types": ["<NUM>"] }]
```

- `"You'll love Elasticsearch 7.0"` =>
- `["7.0"]`

### 1.4.8. stemmer

This allows you to specify stemmer in different languages and apply it to the terms.

```json
[{ "type": "stemmer", "name": "english" }]
```

- `"love loves loved loving"`
- `["love", "love", "love", "love"]`

### 1.4.9. stop

This allows you to specify stop words to delete from the terms. Stop words in different languages are provided, such as `_english_`, and `_spanish_`. Use stopwords to specify a list of words to remove. The default value is `_english_`. Use `stopwords_path` to specify a file path relative to the config location that contains a list of words to remove. Use `ignore_case` to lowercase all the terms first. Use `remove_trailing` to ignore the last term.

```json
[{ "type": "stop", "stopwords": ["_english_"], "ignore_case": true }]
```

- `"A an The and Elasticsearch"` =>
- `["Elasticsearch"]`

### 1.4.10. unique

This allows you to produce unique terms. The custom token filters include stemmer and the unique tokenizer.

```json
[{ "type": "stemmer", "name": "english" }, "unique"]
```

- `"love loves loved loving"` =>
- `["love"]`

### 1.4.11. conditional

This allows you to specify a predicate script and a list of token filters. Apply the token filters to the term if the terms match. Use the `script` parameter to specify the predicate. Use the `filter` parameter to specify the list of token filters. In the following example, the predicate matches the alphanumeric token type and applies the `reverse` token filter to reverse the term.

```json
[
  {
    "type": "condition",
    "script": { "source": "token.getType()=='<ALPHANUM>'" },
    "filter": ["reverse"]
  }
]
```
- `"You'll love Elasticsearch 7.0"` =>
- `[""ll'uoY", "evol", "hcraescitsalE", "7.0"]`

### 1.4.12. predicate_token_filter

This allows you to specify a predicate script. Remove the term if the term does not match. Use the `script` parameter to specify the predicate. You can refer to the Elasticsearch Java documentation for more information (https://static.javadoc.io/org.elasticsearch/elasticsearch/7.0.0-beta1/org/elasticsearch/action/admin/indices/analyze/AnalyzeResponse.AnalyzeToken.html).

```json
 [{"type": "predicate_token_filter", "script":{"source":"token.getType()=='<NUM>'"}}]
```

- `"You'll love Elasticsearch 7.0"` =>
- `["7.0"]`
