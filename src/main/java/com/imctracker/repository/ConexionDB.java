package com.imctracker.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {

    public static Connection getConnection() throws SQLException {

        String url = System.getenv("IMC_DB_URL");
        String user = System.getenv("IMC_DB_USER");
        String password = System.getenv("IMC_DB_PASSWORD");

        System.out.println("========== DIAGNOSTICO IMC TRACKER ==========");
        System.out.println("IMC_DB_URL: " + (url != null ? "CONFIGURADA" : "NO CONFIGURADA"));
        System.out.println("IMC_DB_USER: " + (user != null ? "CONFIGURADA" : "NO CONFIGURADA"));
        System.out.println("IMC_DB_PASSWORD: " + (password != null ? "CONFIGURADA" : "NO CONFIGURADA"));
        System.out.println("==============================================");

        if (url == null || user == null || password == null) {
            throw new SQLException("No se configuraron las variables de conexión.");
        }

        try {
            Connection conexion = DriverManager.getConnection(url, user, password);
            System.out.println("CONEXION MYSQL EXITOSA");
            return conexion;

        } catch (SQLException e) {
            System.err.println("ERROR JDBC: " + e.getMessage());
            throw e;
        }
    }
}