package com.compiler.proyect.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultadoAnalisis {

    private boolean success;
    private String message;
    private List<String> errors;
}
