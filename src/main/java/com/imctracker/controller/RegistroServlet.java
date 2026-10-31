package com.imctracker.controller;

import com.imctracker.model.Usuario;
import com.imctracker.repository.UsuarioRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private final UsuarioRepository usuarioRepository =
            new UsuarioRepository();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/registro.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombreCompleto = request.getParameter("nombreCompleto");
        String nombreUsuario = request.getParameter("nombreUsuario");
        String password = request.getParameter("password");
        String edadTexto = request.getParameter("edad");
        String sexo = request.getParameter("sexo");
        String estaturaTexto = request.getParameter("estatura");

        // Validación de campos obligatorios
        if (nombreCompleto == null || nombreUsuario == null
                || password == null || edadTexto == null
                || sexo == null || estaturaTexto == null
                || nombreCompleto.isBlank()
                || nombreUsuario.isBlank()
                || password.isBlank()
                || edadTexto.isBlank()
                || sexo.isBlank()
                || estaturaTexto.isBlank()) {

            mostrarError(request, response,
                    "Todos los campos son obligatorios.");
            return;
        }

        try {

            int edad = Integer.parseInt(edadTexto);
            double estatura = Double.parseDouble(estaturaTexto);

            // Validación de edad
            if (edad < 15 || edad > 120) {
                mostrarError(request, response,
                        "La edad debe estar entre 15 y 120 años.");
                return;
            }

            // Validación de estatura
            if (estatura < 1.0 || estatura > 2.5) {
                mostrarError(request, response,
                        "La estatura debe estar entre 1.00 y 2.50 metros.");
                return;
            }

            // Validación de contraseña
            if (password.length() < 8 || password.length() > 72) {
                mostrarError(request, response,
                        "La contraseña debe tener entre 8 y 72 caracteres.");
                return;
            }

            // Validación de sexo
            if (!sexo.equals("Masculino")
                    && !sexo.equals("Femenino")
                    && !sexo.equals("Otro")) {

                mostrarError(request, response,
                        "Selecciona una opción de sexo válida.");
                return;
            }

            // Comprobar nombre de usuario duplicado
            if (usuarioRepository.existeNombreUsuario(nombreUsuario)) {
                mostrarError(request, response,
                        "Ese nombre de usuario ya está registrado.");
                return;
            }

            // Generar hash BCrypt
            String passwordHash = BCrypt.hashpw(
                    password, BCrypt.gensalt(12));

            // Crear objeto Usuario
            Usuario usuario = new Usuario(
                    nombreCompleto.trim(),
                    nombreUsuario.trim(),
                    passwordHash,
                    edad,
                    sexo,
                    estatura
            );

            // Guardar usuario en MySQL
            boolean registrado =
                    usuarioRepository.registrarUsuario(usuario);

            if (registrado) {

                response.sendRedirect(
                        request.getContextPath() + "/registro?exito=true");

            } else {
                mostrarError(request, response,
                        "No fue posible completar el registro.");
            }

        } catch (NumberFormatException e) {

            mostrarError(request, response,
                    "La edad y la estatura deben ser valores numéricos.");

        } catch (SQLException e) {

            getServletContext().log(
                    "Error al registrar usuario", e);

            mostrarError(request, response,
                    "Ocurrió un error al guardar el usuario.");
        }
    }

    private void mostrarError(HttpServletRequest request,
                              HttpServletResponse response,
                              String mensaje)
            throws ServletException, IOException {

        request.setAttribute("error", mensaje);

        request.getRequestDispatcher("/registro.jsp")
               .forward(request, response);
    }
}
