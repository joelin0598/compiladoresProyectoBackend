package com.compiler.proyect.service;

import com.compiler.AnalizadorLexico;
import com.compiler.parser;
import org.springframework.stereotype.Service;

import java.io.StringReader;
import java.util.*;

@Service
public class ServicioSimpleScript {

    public Map<String, Object> analizarCodigo(String codigo) {
        Map<String, Object> respuesta = new HashMap<>();

        try {
            StringReader reader = new StringReader(codigo);
            AnalizadorLexico lexer = new AnalizadorLexico(reader);
            parser parser = new parser(lexer);

            parser.parse(); // Ejecuta análisis

            List<String> erroresLexicos = lexer.getErrores();       // ← JFlex
            List<String> erroresSintacticos = parser.getErrores();  // ← CUP

            if (!erroresLexicos.isEmpty() || !erroresSintacticos.isEmpty()) {
                respuesta.put("status", "error");
                respuesta.put("erroresLexicos", erroresLexicos);
                respuesta.put("erroresSintacticos", erroresSintacticos);
            } else {
                respuesta.put("status", "ok");
                respuesta.put("mensaje", "Análisis completado sin errores.");
            }

        } catch (Exception e) {
            respuesta.put("status", "error");
            respuesta.put("errorInterno", e.getMessage());
        }

        return respuesta;
    }
}