package com.imctracker.controller;

import com.imctracker.model.Usuario;
import com.imctracker.repository.UsuarioRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/perfil")
public class PerfilServlet extends HttpServlet {

    private final UsuarioRepository usuarioRepository =
            new UsuarioRepository();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion == null ||
                sesion.getAttribute("usuarioId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        int idUsuario = (Integer) sesion.getAttribute("usuarioId");

        try {
            Usuario usuario =
                    usuarioRepository.buscarPorId(idUsuario);

            if (usuario == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "No se encontró el usuario."
                );
                return;
            }

            request.setAttribute("usuario", usuario);
            request.getRequestDispatcher("/WEB-INF/views/perfil.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al consultar el perfil.", e
            );
        }
    }
}