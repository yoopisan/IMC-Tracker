
package com.imctracker.controller;

import com.imctracker.model.CalculadoraIMC;
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

@WebServlet("/calcular")
public class IMCServlet extends HttpServlet {

    private final MedicionRepository medicionRepository =
            new MedicionRepository();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/calcular.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            HttpSession sesion = request.getSession(false);

            if (sesion == null ||
                    sesion.getAttribute("usuarioId") == null) {

                response.sendRedirect(
                        request.getContextPath() + "/login"
                );
                return;
            }

            int idUsuario = (Integer) sesion.getAttribute("usuarioId");

            String pesoTexto = request.getParameter("peso");
            String estaturaTexto = request.getParameter("estatura");

            if (pesoTexto == null || estaturaTexto == null ||
                    pesoTexto.isBlank() || estaturaTexto.isBlank()) {

                request.setAttribute("error",
                        "Debes ingresar tu peso y estatura.");

                request.getRequestDispatcher("/WEB-INF/views/calcular.jsp")
                        .forward(request, response);
                return;
            }

            double peso = Double.parseDouble(pesoTexto);
            double estatura = Double.parseDouble(estaturaTexto);

            if (!Double.isFinite(peso) ||
                    !Double.isFinite(estatura) ||
                    peso < 20 || peso > 500 ||
                    estatura < 1 || estatura > 2.5) {

                request.setAttribute("error",
                        "Ingresa un peso entre 20 y 500 kg y una estatura entre 1 y 2.5 metros.");

                request.getRequestDispatcher("/WEB-INF/views/calcular.jsp")
                        .forward(request, response);
                return;
            }

            double imc = CalculadoraIMC.calcular(peso, estatura);
            imc = Math.round(imc * 100.0) / 100.0;

            String clasificacion =
                    CalculadoraIMC.clasificar(imc);

            Medicion medicion = new Medicion(
                    idUsuario,
                    peso,
                    estatura,
                    imc,
                    clasificacion
            );

            medicionRepository.guardarMedicion(medicion);

            request.setAttribute("medicion", medicion);

            request.getRequestDispatcher("/WEB-INF/views/resultado.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            request.setAttribute("error",
                    "Ingresa valores numéricos válidos.");

            request.getRequestDispatcher("/WEB-INF/views/calcular.jsp")
                    .forward(request, response);

        } catch (SQLException e) {

            getServletContext().log(
                    "Error al guardar la medición", e
            );

            request.setAttribute("error",
                    "No fue posible guardar tu medición. Inténtalo nuevamente.");

            request.getRequestDispatcher("/WEB-INF/views/calcular.jsp")
                    .forward(request, response);
        }
    }
}
