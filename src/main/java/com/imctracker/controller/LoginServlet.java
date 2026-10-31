package com.imctracker.controller;

import com.imctracker.model.Usuario;
import com.imctracker.repository.UsuarioRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UsuarioRepository usuarioRepository =
            new UsuarioRepository();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombreUsuario = request.getParameter("nombreUsuario");
        String password = request.getParameter("password");

        if (nombreUsuario == null || password == null
                || nombreUsuario.isBlank() || password.isBlank()) {

            mostrarError(request, response,
                    "Ingresa tu nombre de usuario y contraseña.");
            return;
        }

        try {
            nombreUsuario = nombreUsuario.trim();

            Usuario usuario = usuarioRepository.buscarPorNombreUsuario(
                    nombreUsuario
            );

            if (usuario == null ||
                    !BCrypt.checkpw(password, usuario.getPasswordHash())) {

                mostrarError(request, response,
                        "Usuario o contraseña incorrectos.");
                return;
            }

            HttpSession sesionAnterior = request.getSession(false);

            if (sesionAnterior != null) {
                sesionAnterior.invalidate();
            }

            HttpSession sesion = request.getSession(true);

            sesion.setAttribute("usuarioId", usuario.getIdUsuario());
            sesion.setAttribute("nombreUsuario", usuario.getNombreUsuario());
            sesion.setMaxInactiveInterval(30 * 60);
            
            response.sendRedirect(
                    request.getContextPath() + "/dashboard"
            );

        } catch (SQLException e) {
            getServletContext().log("Error al iniciar sesión", e);

            mostrarError(request, response,
                    "Ocurrió un error al intentar iniciar sesión.");
        }
    }

    private void mostrarError(HttpServletRequest request,
                              HttpServletResponse response,
                              String mensaje)
            throws ServletException, IOException {

        request.setAttribute("error", mensaje);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
