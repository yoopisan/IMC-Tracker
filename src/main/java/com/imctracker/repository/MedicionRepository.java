package com.imctracker.repository;

import com.imctracker.model.Medicion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class MedicionRepository {

    public void guardarMedicion(Medicion medicion) throws SQLException {

        String sql = """
                INSERT INTO mediciones
                (id_usuario, peso, estatura, imc, clasificacion)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection conexion = ConexionDB.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, medicion.getIdUsuario());
            ps.setDouble(2, medicion.getPeso());
            ps.setDouble(3, medicion.getEstatura());
            ps.setDouble(4, medicion.getImc());
            ps.setString(5, medicion.getClasificacion());

            ps.executeUpdate();
        }
    }

    public List<Medicion> obtenerMedicionesPorUsuario(int idUsuario)
            throws SQLException {

        List<Medicion> mediciones = new ArrayList<>();

        String sql = """
                SELECT id_medicion, id_usuario, peso, estatura,
                       imc, clasificacion, fecha_medicion
                FROM mediciones
                WHERE id_usuario = ?
                ORDER BY fecha_medicion DESC
                """;

        try (Connection conexion = ConexionDB.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Medicion medicion = new Medicion();

                    medicion.setIdMedicion(rs.getInt("id_medicion"));
                    medicion.setIdUsuario(rs.getInt("id_usuario"));
                    medicion.setPeso(rs.getDouble("peso"));
                    medicion.setEstatura(rs.getDouble("estatura"));
                    medicion.setImc(rs.getDouble("imc"));
                    medicion.setClasificacion(
                            rs.getString("clasificacion")
                    );

                    Timestamp fecha = rs.getTimestamp("fecha_medicion");

                    if (fecha != null) {
                        medicion.setFechaMedicion(
                                fecha.toLocalDateTime()
                        );
                    }

                    mediciones.add(medicion);
                }
            }
        }

        return mediciones;
    }
}
