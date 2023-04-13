#lang racket

(require racket/file)

;; Authors
;; - Daniel Hurtado (A01707774)
;; - Carlos Velasco (A01708634)

;; Definición de las expresiones regulares para las categorías léxicas en C#
(define keywords
  (list 
    "abstract" "as" "base" "bool" "byte"  "catch" "char" "checked" "class" "const" "decimal" "delegate" "double" "enum" "event" "explicit" "extern" "false" "finally" "fixed" "float" "implicit" "in" "int" "interface" "internal" "is" "lock" "long" "namespace" "new" "null" "object" "operator" "out" "override" "params" "private" "protected" "public" "readonly" "ref" "sbyte" "sealed" "short" "sizeof" "stackalloc" "static" "string" "struct" "this" "throw" "true" "try" "typeof" "uint" "ulong" "unchecked" "unsafe" "ushort" "using" "virtual" "void" "volatile" "#if" "#endif" "#else"
   )
)

(define loops-conditionals
  (list
   "while" "switch" "do" "foreach" "break" "continue" "default" "goto" "return" "if" "case" "else" "for" "endif"
   )
 )

(define operators
    (list
        "+" "-" "*" "/" "%" "^" "&" "|" "~" "!" "=" "<" ">" "?" ":" ";" "," "." "++" "--" "&&" "||" "==" "!=" "<=" ">=" "+=" "-=" "*=" "/=" "%=" "^=" "&=" "|=" "<<=" ">>=" "=>" "??"
    )
)

(define delimiters
    (list
        "(" ")" "{" "}" "[" "]"
    )
)
(define colors
    (hash 
    "keyword" "keyword"
    "operator" "operator"
    "delimiter" "delimiter"
    "comment" "comment"
    "string" "string"
    "loops-conditionals" "loops-conditionals"
    "float" "float"
    "number" "number"
    "integer" "integer"
    "identifier" "identifier"
    "block-comment-start" "comment" ; Agrega esta línea
    "block-comment-end" "comment" ; Agrega esta línea
    )
)
;;Función para clasificar un token según su tipo
(define (classify-token token)
  (cond
    [(member token keywords) 'reserved-word]
    [(member token operators) 'operator]
    [(member token delimiters) 'delimiter]
    [(member token loops-conditionals) 'loops-conditionals]
    [(regexp-match? #rx"^[a-zA-Z_][a-zA-Z0-9_]*$" token) 'identifier]
    [(regexp-match? #rx"^[0-9x]+$" token) 'integer]
    [(regexp-match? #rx"[+-]?([0-9]*[.])?[0-9]+" token) 'float]
    [(regexp-match? #rx"^\".*\"$" token) 'string]
    [(regexp-match? #rx"//.*" token) 'comment]
    [(regexp-match? #rx"/\\*.*" token) 'block-comment-start]
    [(regexp-match? #rx".*\\*/" token) 'block-comment-end]
    [else #f]))

;; Funcion para resaltar el token
(define (highlight-token token token-type)
  (cond
    [(equal? token-type 'reserved-word)
      (string-append "<span class=\""
        (hash-ref colors "keyword") "\">" token "</span>")]

    [(equal? token-type 'integer)
      (string-append "<span class=\""
      (hash-ref colors "integer") "\">" token "</span>")]

    [else
      (string-append "<span class=\""
      (hash-ref colors (symbol->string token-type)) "\">" token "</span>")])) 


;; Tokenize line
(define (tokenize-line line open-block-comment)
    (define tokenized-line '())

    (define tokens (regexp-match* #px"([a-zA-Z_][a-zA-Z0-9_]*|//.*|/\\*.*|.*?\\*/|\\d+\\.?\\d*|\".*?\"|\\S)" line))

    (for ([token tokens])
        (define token-type (classify-token token))
        (when open-block-comment (set! token-type "comment"))
        (if token-type
            (set! tokenized-line (append tokenized-line 
                                 (list (highlight-token token token-type))))
            (set! tokenized-line (append tokenized-line (list token)))
        )
        (when (equal? token-type 'block-comment-start) (set! open-block-comment #t))
        (when (equal? token-type 'block-comment-end) (set! open-block-comment #f))
    )

    ; Agrega un salto de línea al final de cada línea
    (append tokenized-line (list "<br>"))
)


;; Tokenize file
(define (tokenize-file file-name)
    (let ((in-port (read-file file-name)))
        (let loop ((tokens '()) (open-block-comment #f))

        (let ((line (read-line in-port)))
            (if (eof-object? line)
                (reverse (reverse tokens))
                ; Aquí es donde llamamos a tokenize-line con un valor para open-block-comment
                (begin
                  (let ((tokenized-line (tokenize-line line open-block-comment)))
                  (set! open-block-comment (and (not (and (not (empty? tokenized-line)) (equal? (last tokenized-line) "*/"))) open-block-comment))
                  (loop (append tokens tokenized-line) open-block-comment)
                  ))
                )))
            )
        )
;; Función para resaltar las categorías léxicas en un código fuente en C#
(define (tokenize-csharp input)
  (define tokens (tokenize-file input))
  (define tokenized-tokens (map (lambda (token)
                                  (let ((token-type (classify-token token)))
                                    (if token-type
                                        (highlight-token token token-type)
                                        token)))
                                tokens))
  (string-join tokenized-tokens))


;; Función para leer un archivo de texto
(define (read-file file-name)
    (open-input-file file-name)
)

;; Función para escribir un archivo HTML
(define (write-html-file file-name html-content)
  (with-output-to-file file-name
    (λ () (display html-content))
    #:exists 'replace))

;; Función para convertir un archivo en C# a un archivo HTML con resaltado de sintaxis
(define (csharp-to-html input-file-name output-file-name)
  (define highlighted-code (tokenize-csharp input-file-name))
  
  (define html-template
    "<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
  <title>C# Code Highlighting</title>
  <style>
    body { font-family: monospace; white-space: pre; }
    .keyword { color: blue; }
    .operator { color: white; }
    .delimiter { color: #FCE907; }
    .identifier { color: green; }
    .integer { color: #A8DC03; }
    .float { color: #A8DC03; }
    .string { color: #E39000; }
    .comment { color: green; }
    .loops-conditionals { color: magenta }
    html { background-color: black; }
  </style>
</head>
<body>
~a
</body>
</html>")
  
  (define html-content (format html-template highlighted-code))
  (write-html-file output-file-name html-content))


(csharp-to-html "input.cs" "output.html")