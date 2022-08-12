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
