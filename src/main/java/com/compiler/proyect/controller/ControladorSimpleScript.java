package com.compiler.proyect.controller;

import com.compiler.proyect.model.CodigoFuente;
import com.compiler.proyect.model.ResultadoAnalisis;
import com.compiler.proyect.service.ServicioSimpleScript;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;


@RestController
@RequestMapping("/api/compilar")
public class ControladorSimpleScript {

    @Autowired
    private ServicioSimpleScript servicio;

    @PostMapping(consumes = "text/plain", produces = "application/json")
    public Map<String, Object> analizar(@RequestBody String codigo) {
        return servicio.analizarCodigo(codigo);
    }

    @PostMapping(path = "/archivo", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = "application/json")
    public Map<String, Object> analizarArchivo(@RequestParam("archivo") MultipartFile archivo) {
        try {
            String contenido = new String(archivo.getBytes());
            return servicio.analizarCodigo(contenido);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("status", "error");
            error.put("errorInterno", "No se pudo leer el archivo: " + e.getMessage());
            return error;
        }
    }

}

