# 1. Analyzers

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

### Partial Word Tokenizers

#### ngram

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

#### edge_ngram

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
