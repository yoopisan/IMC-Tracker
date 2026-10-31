package com.imctracker.controller;

import com.imctracker.repository.ConexionDB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/hola")
public class HolaServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (Connection conexion = ConexionDB.getConnection();
             PreparedStatement consulta =
                 conexion.prepareStatement("SELECT DATABASE()");
             ResultSet resultado = consulta.executeQuery()) {

            resultado.next();

            String baseDatos = resultado.getString(1);

            response.getWriter().println(
                "<!DOCTYPE html>" +
                "<html lang='es'>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>IMC Tracker</title>" +
                "</head>" +
                "<body style='font-family:Arial;text-align:center;" +
                "margin-top:100px;background:#f4f7fb'>" +
                "<h1 style='color:#198754'>¡IMC Tracker funciona!</h1>" +
                "<p>La aplicación se ejecuta correctamente en WildFly.</p>" +
                "<p>Conexión con MySQL establecida correctamente.</p>" +
                "<p>Base de datos: " + baseDatos + "</p>" +
                "</body></html>"
            );

        } catch (SQLException e) {

            getServletContext().log(
                "Error al conectar con MySQL", e
            );

            response.setStatus(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().println(
                "<h1>Error de conexión</h1>" +
                "<p>No fue posible conectar con MySQL.</p>"
            );
        }
    }
}
