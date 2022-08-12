# Analyzers

## Workflow
- Index operation
  - Contents Processed by Analyzer
  - Generated tokens are used to build an inverted index

- Search operation
  - Query content is processed by Search Analyzer to Generate tokens for matching
  - Generated tokens are matched against inverted index

## Analyzer Components

- Inverted Index
 - Lists of Unique Words and Document Ids they Appear in
 - List of Word Frequencies

### Analyzer
- N `Character Filters`
	- Add/Remove Characters from Input String
- 1 `Tokenizer`
	- Split the Output of Character Filters into Unique Terms
- N `Token Filters`
	- Add/Remove Characters from Terms

### Standard analyzer

`"<body>You'll love Elasticsearch 7.0.</body>".`
- `Standard` Tokenizer
	- Grammar based tokenization
	- `[body, You'll, love, Elasticsearch, 7.0, body]`  

- `Lowercase` Token Filter
	- Normalize tokens to lowercase
	- `[body, you'll, love, elasticsearch, 7.0, body]`