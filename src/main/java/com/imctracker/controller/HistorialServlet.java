package com.imctracker.controller;

import com.imctracker.model.Medicion;
import com.imctracker.repository.MedicionRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/historial")
public class HistorialServlet extends HttpServlet {

    private final MedicionRepository medicionRepository =
            new MedicionRepository();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Recuperar la sesión del usuario.
        HttpSession sesion = request.getSession(false);

        if (sesion == null ||
                sesion.getAttribute("usuarioId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        // Obtener el identificador del usuario autenticado.
        int idUsuario = (Integer) sesion.getAttribute("usuarioId");

        try {
            // Consultar únicamente las mediciones de ese usuario.
            List<Medicion> mediciones =
                    medicionRepository.obtenerMedicionesPorUsuario(
                            idUsuario
                    );

            // Enviar los resultados a la vista.
            request.setAttribute("mediciones", mediciones);

            request.getRequestDispatcher("/WEB-INF/views/historial.jsp")
                    .forward(request, response);

        } catch (SQLException e) {

            getServletContext().log(
                    "Error al consultar el historial", e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "No fue posible consultar el historial."
            );
        }
    }
}
