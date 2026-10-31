package com.imctracker.repository;

import com.imctracker.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioRepository {

    // Comprueba si el nombre de usuario ya está registrado
    public boolean existeNombreUsuario(String nombreUsuario)
            throws SQLException {

        String sql = "SELECT id_usuario FROM usuarios WHERE nombre_usuario = ?";

        try (Connection conexion = ConexionDB.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, nombreUsuario);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Registra un nuevo usuario
    public boolean registrarUsuario(Usuario usuario)
            throws SQLException {

        String sql = """
                INSERT INTO usuarios
                (nombre_completo, nombre_usuario, password_hash,
                 edad, sexo, estatura)
                VALUES (?, ?, ?, ?, ?, ?)
                """;

        try (Connection conexion = ConexionDB.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombreCompleto());
            ps.setString(2, usuario.getNombreUsuario());
            ps.setString(3, usuario.getPasswordHash());
            ps.setInt(4, usuario.getEdad());
            ps.setString(5, usuario.getSexo());
            ps.setDouble(6, usuario.getEstatura());

            return ps.executeUpdate() == 1;
        }
    }
}
