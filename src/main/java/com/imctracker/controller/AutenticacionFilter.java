package com.imctracker.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
    "/dashboard",
    "/calcular",
    "/resultado",
    "/historial",
    "/perfil"
})
public class AutenticacionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession sesion = req.getSession(false);

        // Comprobar que el usuario haya iniciado sesión.
        if (sesion == null ||
                sesion.getAttribute("usuarioId") == null) {

            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Si existe una sesión válida, permitir continuar.
        chain.doFilter(request, response);
    }
}
