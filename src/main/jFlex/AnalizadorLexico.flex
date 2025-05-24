package com.compiler;
import java_cup.runtime.Symbol;

%%
%class AnalizadorLexico
%public
%cup
%unicode
%char
%line
%column

%{
    import java.util.List;
    import java.util.ArrayList;

    private List<String> errores = new ArrayList<>();

    public List<String> getErrores() {
        return errores;
    }

    private void reportarError(String mensaje, int linea, int columna) {
        errores.add("Error léxico: " + mensaje + " en línea " + linea + ", columna " + columna);
    }


    private Symbol symbol(int type) {
        return new Symbol(type, yyline + 1, yycolumn + 1);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline + 1, yycolumn + 1, value);
    }
%}

%eofval{
    return symbol(sym.EOF);
%eofval}

// Palabras clave
DEFINE      = "DEFINE"
PRINT       = "PRINT"
IF          = "IF"
ELSE        = "ELSE"
ELSEIF      = "ELSEIF"
THEN        = "THEN"
WHILE       = "WHILE"
DO          = "DO"
LOOP        = "LOOP"
FUNCTION    = "FUNCTION"
RETURN      = "RETURN"
END         = "END"
TRUE        = "true"
FALSE       = "false"

// Operadores
AND         = "AND"
OR          = "OR"
NOT         = "NOT"

// Literales
ID          = [a-zA-Z_][a-zA-Z0-9_]*
NUMERO      = [0-9]+
DECIMAL     = [0-9]+"."[0-9]+
CADENA      = \"([^\"\n\r])*\"  // string entre comillas dobles

// Operadores
EQ          = "="
EQEQ        = "=="
NEQ         = "!="
LT          = "<"
GT          = ">"
LTE         = "<="
GTE         = ">="
PLUS        = "+"
MINUS       = "-"
MULT        = "*"
DIV         = "/"
LPAR        = "("
RPAR        = ")"
SEMICOLON   = ";"
COMMA       = ","

// Espacios
WHITESPACE  = [ \t\r\n]+

%%

<YYINITIAL> {

{DEFINE}        { return symbol(sym.DEFINE); }
{PRINT}         { return symbol(sym.PRINT); }
{IF}            { return symbol(sym.IF); }
{ELSE}          { return symbol(sym.ELSE); }
{ELSEIF}        { return symbol(sym.ELSEIF); }
{THEN}          { return symbol(sym.THEN); }
{WHILE}         { return symbol(sym.WHILE); }
{DO}            { return symbol(sym.DO); }
{LOOP}          { return symbol(sym.LOOP); }
{FUNCTION}      { return symbol(sym.FUNCTION); }
{RETURN}        { return symbol(sym.RETURN); }
{END}           { return symbol(sym.END); }
{TRUE}          { return symbol(sym.TRUE, true); }
{FALSE}         { return symbol(sym.FALSE, false); }

{AND}           { return symbol(sym.AND); }
{OR}            { return symbol(sym.OR); }
{NOT}           { return symbol(sym.NOT); }

{DECIMAL}       { return symbol(sym.DECIMAL, Double.parseDouble(yytext())); }
{NUMERO}        { return symbol(sym.NUMERO, Integer.parseInt(yytext())); }
{CADENA} {
    String texto = yytext();
    return symbol(sym.CADENA, texto.substring(1, texto.length() - 1));
}
{ID}            { return symbol(sym.ID, yytext()); }

{EQEQ}          { return symbol(sym.EQEQ); }
{NEQ}           { return symbol(sym.NEQ); }
{LTE}           { return symbol(sym.LTE); }
{GTE}           { return symbol(sym.GTE); }
{EQ}            { return symbol(sym.EQ); }
{LT}            { return symbol(sym.LT); }
{GT}            { return symbol(sym.GT); }

{PLUS}          { return symbol(sym.PLUS); }
{MINUS}         { return symbol(sym.MINUS); }
{MULT}          { return symbol(sym.MULT); }
{DIV}           { return symbol(sym.DIV); }

{LPAR}          { return symbol(sym.LPAR); }
{RPAR}          { return symbol(sym.RPAR); }
{SEMICOLON}     { return symbol(sym.SEMICOLON); }
{COMMA}         { return symbol(sym.COMMA); }

{WHITESPACE}    { /* ignorar espacios */ }

. {
    reportarError("Símbolo no reconocido: '" + yytext() + "'", yyline + 1, yycolumn + 1);
}

}
