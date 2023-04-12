#lang racket

;; Authors
;; - Daniel Hurtado (A01707774)
;; - Charly ()

;; Definición de las expresiones regulares para las categorías léxicas en C#
(define reserved-words-regexp (regexp "(abstract|as|base|bool|break|byte|case|catch|char|checked|class|const|continue|decimal|default|delegate|do|double|else|enum|event|explicit|extern|false|finally|fixed|float|for|foreach|goto|if|implicit|in|int|interface|internal|is|lock|long|namespace|new|null|object|operator|out|override|params|private|protected|public|readonly|ref|return|sbyte|sealed|short|sizeof|stackalloc|static|string|struct|switch|this|throw|true|try|typeof|uint|ulong|unchecked|unsafe|ushort|using|virtual|void|volatile|while|add|alias|ascending|async|await|descending|dynamic|from|get|global|group|into|join|let|orderby|partial|remove|select|set|value|var|where|yield)\\b"))

(define operators-regexp (regexp "(\\+\\+|--|->|==|!=|<=|>=|&&|\\|\\||<<|>>|\\+=|-=|\\*=|/=|%=|&=|\\|=|\\^=|<<=|>>=|=>|\\?|:|\\||&|!|~|\\^|\\*|\\/|%|\\+|-|<|>|=|\\.|,|;|\\{|\\}|\\[|\\]|\\(|\\))"))

(define identifiers-regexp (regexp "\\b[a-zA-Z_]\\w*\\b"))

(define integers-regexp (regexp "\\b\\d+\\b"))

(define floats-regexp (regexp "\\b\\d+\\.\\d+f?\\b"))

(define strings-regexp (regexp "\"[^\"]*\""))

(define single-line-comments-regexp (regexp "//[^\n]*"))

(define multi-line-comments-regexp (regexp "/\\*[^\\*]*\\*+([^/][^\\*]*\\*+)*/"))

;; Función para resaltar las categorías léxicas en un código fuente en C#
(define (highlight-lexemes input)
  (define (highlight-token token)
    (cond
     ((regexp-match? reserved-words-regexp token) (format "<span class=\"reserved-word\">~a</span>" token))
     ((regexp-match? operators-regexp token) (format "<span class=\"operator\">~a</span>" token))
     ((regexp-match? identifiers-regexp token) (format "<span class=\"identifier\">~a</span>" token))
     ((regexp-match? integers-regexp token) (format "<span class=\"integer\">~a</span>" token))
     ((regexp-match? floats-regexp token) (format "<span class=\"float\">~a</span>" token))
     ((regexp-match? strings-regexp token) (format "<span class=\"string\">~a</span>" token))
     ((regexp-match? single-line-comments-regexp token) (format "<span class=\"comment\">~a</span>" token))
     ((regexp-match? multi-line-comments-regexp token) (format "<span class=\"comment\">~a</span>" token))
     (else token)))

  (define tokens (regexp-split #rx"[ \t\n]+" input))
  (string-join (map highlight-token tokens) " "))
