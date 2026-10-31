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

@WebServlet("/editar-perfil")
public class EditarPerfilServlet extends HttpServlet {

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

            request.getRequestDispatcher("/WEB-INF/views/editar-perfil.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al consultar el perfil.", e
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

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
            String nombre = request.getParameter("nombreCompleto");
            String edadTexto = request.getParameter("edad");
            String sexo = request.getParameter("sexo");
            String estaturaTexto = request.getParameter("estatura");

            if (nombre == null || nombre.trim().isEmpty()
                    || edadTexto == null
                    || sexo == null
                    || estaturaTexto == null) {
                request.setAttribute(
                        "error", "Todos los campos son obligatorios."
                );
                doGet(request, response);
                return;
            }

            int edad = Integer.parseInt(edadTexto);
            double estatura = Double.parseDouble(estaturaTexto);

            if (edad < 15 || edad > 120) {
                request.setAttribute(
                        "error", "La edad debe estar entre 15 y 120 años."
                );
                doGet(request, response);
                return;
            }

            if (!Double.isFinite(estatura)
                    || estatura < 1.0 || estatura > 2.5) {
                request.setAttribute(
                        "error", "La estatura debe estar entre 1 y 2.5 metros."
                );
                doGet(request, response);
                return;
            }

            if (!sexo.equals("Masculino")
                    && !sexo.equals("Femenino")
                    && !sexo.equals("Otro")) {
                request.setAttribute(
                        "error", "Selecciona una opción de sexo válida."
                );
                doGet(request, response);
                return;
            }

            Usuario usuario = new Usuario();
            usuario.setIdUsuario(idUsuario);
            usuario.setNombreCompleto(nombre.trim());
            usuario.setEdad(edad);
            usuario.setSexo(sexo);
            usuario.setEstatura(estatura);

            boolean actualizado =
                    usuarioRepository.actualizarUsuario(usuario);

            if (actualizado) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/perfil?actualizado=true"
                );
            } else {
                request.setAttribute(
                        "error", "No fue posible actualizar el perfil."
                );
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute(
                    "error", "Verifica que la edad y estatura sean números válidos."
            );
            doGet(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Error al actualizar el perfil.", e
            );
        }
    }
}
