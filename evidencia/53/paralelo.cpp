#include <fstream>
#include <sstream>
#include <vector>
#include <unordered_map>
#include <regex>
#include <algorithm>
#include <iostream>
#include <ctime>
// #include "utils.h"
#include <dirent.h>
#include <sys/stat.h>
#include <pthread.h>

#include <time.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>


// Definición de las categorías léxicas
std::vector<std::string> reserved_words = {"abstract", "as", "base", "bool", "byte", "catch", "char", "checked", "class", "const", "decimal", "delegate", "double", "enum", "event", "explicit", "extern", "false", "finally", "fixed", "float", "implicit", "in", "int", "interface", "internal", "is", "lock", "long", "namespace", "new", "null", "object", "operator", "out", "override", "params", "private", "protected", "public", "readonly", "ref", "sbyte", "sealed", "short", "sizeof", "stackalloc", "static", "string", "struct", "this", "throw", "true", "try", "typeof", "uint", "ulong", "unchecked", "unsafe", "ushort", "using", "virtual", "void", "volatile", "#if", "#endif", "#else"};
std::vector<std::string> operators = {"+", "-", "*", "/", "%", "^", "&", "|", "~", "!", "=", "<", ">", "?", ":", ";", ",", ".", "++", "--", "&&", "||", "==", "!=", "<=", ">=", "+=", "-=", "*=", "/=", "%=", "^=", "&=", "|=", "<<=", ">>=", "=>", "??"};
std::vector<std::string> delimiters = {"(", ")", "{", "}", "[", "]"};
std::vector<std::string> loops_conditionals = {"for", "foreach", "while", "do", "if", "else", "switch", "case", "default", "break", "continue", "return"};

// Función para clasificar un token según su tipo
std::string classify_token(std::string token) {
    if (std::find(reserved_words.begin(), reserved_words.end(), token) != reserved_words.end()) {
        return "reserved-word";
    } else if (std::find(operators.begin(), operators.end(), token) != operators.end()) {
        return "operator";
    } else if (std::find(delimiters.begin(), delimiters.end(), token) != delimiters.end()) {
        return "delimiter";
    } else if (std::find(loops_conditionals.begin(), loops_conditionals.end(), token) != loops_conditionals.end()) {
        return "loops-conditionals";
    } else if (std::regex_match(token, std::regex("^[a-zA-Z_][a-zA-Z0-9_]*$"))) {
        return "identifier";
    } else if (std::regex_match(token, std::regex("^[0-9]+$"))) {
        return "integer";
    } else if (std::regex_match(token, std::regex("[+-]?([0-9]*[.])?[0-9]+"))) {
        return "float";
    } else if (std::regex_match(token, std::regex("^\".*\"$"))) {
        return "string";
    } else if (std::regex_match(token, std::regex("//.*"))) {
        return "comment";
    } else if (std::regex_match(token, std::regex("/\\*.*"))) {
        return "block-comment-start";
    } else if (std::regex_match(token, std::regex(".*\\*/"))) {
        return "block-comment-end";
    } else {
        return "";
    }
}

// Función para resaltar el token
// Función para tokenizar una línea
std::vector<std::string> tokenize_line(std::string line) {
    std::vector<std::string> tokens;
    std::regex token_regex("([a-zA-Z_][a-zA-Z0-9_]*|//.*|/\\*.*|.*?\\*/|\\d+\\.?\\d*|\".*?\"|\\s+|\\S)");
    std::sregex_iterator it(line.begin(), line.end(), token_regex);
    std::sregex_iterator reg_end;
    for (; it != reg_end; ++it) {
        tokens.push_back(it->str());
    }
    tokens.push_back("\n"); // Añade un salto de línea al final de cada línea
    return tokens;
}

// Función para resaltar el token
std::string highlight_token(std::string token, std::string token_type) {
    if (token_type == "reserved-word") {
        return "<span class=\"reserved-word\">" + token + "</span>";
    } else if (token_type == "operator") {
        return "<span class=\"operator\">" + token + "</span>";
    } else if (token_type == "delimiter") {
        return "<span class=\"delimiter\">" + token + "</span>";
    } else if (token_type == "loops-conditionals"){
        return "<span class=\"loops-conditionals\">" + token + "</span>";
    } else if (token_type == "identifier") {
        return "<span class=\"identifier\">" + token + "</span>";
    } else if (token_type == "integer") {
        return "<span class=\"integer\">" + token + "</span>";
    } else if (token_type == "float") {
        return "<span class=\"float\">" + token + "</span>";
    } else if (token_type == "string") {
        return "<span class=\"string\">" + token + "</span>";
    } else if (token_type == "comment" || token_type == "block-comment-start" || token_type == "block-comment-end") {
        return "<span class=\"comment\">" + token + "</span>";
    } else if (token == "\n") {
        return "<br>";
    } else if (std::regex_match(token, std::regex("\\s+"))) {
        return "<span class=\"whitespace\">" + token + "</span>";
    } else {
        return token;
    }
}

// Función para tokenizar un archivo
std::vector<std::string> tokenize_file(std::string filename) {
    std::ifstream file(filename);
    std::string line;
    std::vector<std::string> tokens;
    while (std::getline(file, line)) {
        std::vector<std::string> line_tokens = tokenize_line(line);
        tokens.insert(tokens.end(), line_tokens.begin(), line_tokens.end());
    }
    return tokens;
}

// Función para resaltar las categorías léxicas en un código fuente en C#
std::string tokenize_csharp(std::string input) {
    std::vector<std::string> tokens = tokenize_file(input);
    std::string highlighted_code;
    for (std::string token : tokens) {
        std::string token_type = classify_token(token);
        highlighted_code += highlight_token(token, token_type);
    }
    return highlighted_code;
}

// Función para convertir un archivo en C# a un archivo HTML con resaltado de sintaxis
void csharp_to_html(std::string input_file_name, std::string output_file_name) {
    std::string highlighted_code = tokenize_csharp(input_file_name);
    std::ofstream output_file(output_file_name);
    output_file << "<!DOCTYPE html>\n<html>\n<head>\n<style>\n";
    output_file << "body { font-family: monospace; white-space: pre;}\n";
    output_file << ".reserved-word { color: blue; }\n";
    output_file << ".operator { color: white; }\n";
    output_file << ".delimiter { color: #FCE907; }\n";
    output_file << ".identifier { color: green; }\n";
    output_file << ".integer { color: #A8DC03; }\n";
    output_file << ".float { color: #A8DC03; }\n";
    output_file << ".string { color: #E39000; }\n";
    output_file << ".comment { color: rgb(96, 96, 96); }\n";
    output_file << ".loops-conditionals { color: magenta; }\n";
    output_file << "html { background-color: rgb(36, 36, 36); }\n";
    output_file << "</style>\n</head>\n<body>\n<pre>\n";
    output_file << highlighted_code;
    output_file << "\n</pre>\n</body>\n</html>";
}

const int NUM_THREADS = 8; // El número de hilos a usar. Esto debe ser ajustado de acuerdo a tus necesidades.

struct ThreadData {
    std::string input_file_name;
    std::string output_file_name;
};

void* process_file(void* thread_data) {
    ThreadData* data = static_cast<ThreadData*>(thread_data);
    csharp_to_html(data->input_file_name, data->output_file_name);
    pthread_exit(NULL);
}

int main() {
    struct stat st = {0};
    if (stat("./output_paralelo", &st) == -1) {
        mkdir("./output_paralelo");
    }
    std::clock_t inicio = std::clock();
    DIR* dirp = opendir("./csharp_examples");
    struct dirent * dp;
    pthread_t threads[NUM_THREADS];
    ThreadData thread_data[NUM_THREADS];
    int thread_count = 0;


    while ((dp = readdir(dirp)) != NULL) {
        std::string filename = dp->d_name;
        if (filename.length() >= 3 && filename.substr(filename.length() - 3) == ".cs") {
            thread_data[thread_count].input_file_name = "./csharp_examples/" + filename;
            thread_data[thread_count].output_file_name = "./output_paralelo/" + filename + ".html";
            pthread_create(&threads[thread_count], NULL, process_file, static_cast<void*>(&thread_data[thread_count]));
            thread_count++;

            if (thread_count >= NUM_THREADS) {
                for (int i = 0; i < NUM_THREADS; i++) {
                    pthread_join(threads[i], NULL);
                }
                thread_count = 0;
            }
        }
    }
    
    // Si hay hilos restantes por unir después de salir del bucle
    for (int i = 0; i < thread_count; i++) {
        pthread_join(threads[i], NULL);
    }

    closedir(dirp);

    std::clock_t fin = std::clock();
    double tiempo_paralelo = double(fin - inicio) / CLOCKS_PER_SEC;
    std::cout << "Tiempo paralelo: " << tiempo_paralelo << " segundos" << std::endl;

    return 0;
}