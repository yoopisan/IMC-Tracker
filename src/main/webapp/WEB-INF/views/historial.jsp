<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.imctracker.model.Medicion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>

<%
    List<Medicion> mediciones =
            (List<Medicion>) request.getAttribute("mediciones");

    DateTimeFormatter formatoFecha =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Historial | IMC Tracker</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0f7f7;
            color: #263238;
        }

        header {
            background: #087f8c;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .contenedor {
            max-width: 1100px;
            margin: 40px auto;
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        h2 {
            color: #087f8c;
        }

        .tabla-contenedor {
            overflow-x: auto;
            margin-top: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #087f8c;
            color: white;
        }

        tr:hover {
            background: #f0f7f7;
        }

        .vacio {
            padding: 25px;
            text-align: center;
            background: #f0f7f7;
            border-radius: 8px;
            margin-top: 20px;
        }

        .boton {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 20px;
            background: #087f8c;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .boton:hover {
            background: #066570;
        }

        .acciones {
            text-align: center;
        }

        @media (max-width: 600px) {
            .contenedor {
                margin: 20px 10px;
                padding: 15px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>IMC Tracker</h1>
    <p>Historial de mediciones</p>
</header>

<div class="contenedor">

    <h2>Mis mediciones anteriores</h2>

    <% if (mediciones == null || mediciones.isEmpty()) { %>

        <div class="vacio">
            <h3>Aún no tienes mediciones registradas.</h3>
            <p>Registra tu primera medición para comenzar a consultar tu progreso.</p>
        </div>

    <% } else { %>

        <div class="tabla-contenedor">

            <table>
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Peso (kg)</th>
                        <th>Estatura (m)</th>
                        <th>IMC</th>
                        <th>Clasificación</th>
                    </tr>
                </thead>

                <tbody>

                    <% for (Medicion medicion : mediciones) { %>

                        <tr>
                            <td>
                                <%= medicion.getFechaMedicion() != null
                                    ? medicion.getFechaMedicion().format(formatoFecha)
                                    : "No disponible" %>
                            </td>

                            <td>
                                <%= String.format(Locale.US, "%.2f",
                                    medicion.getPeso()) %>
                            </td>

                            <td>
                                <%= String.format(Locale.US, "%.2f",
                                    medicion.getEstatura()) %>
                            </td>

                            <td>
                                <strong>
                                    <%= String.format(Locale.US, "%.2f",
                                        medicion.getImc()) %>
                                </strong>
                            </td>

                            <td>
                                <%= medicion.getClasificacion() %>
                            </td>
                        </tr>

                    <% } %>

                </tbody>
            </table>

        </div>

    <% } %>

    <div class="acciones">

        <a class="boton"
           href="${pageContext.request.contextPath}/calcular">
            Registrar nueva medición
        </a>

        <a class="boton"
           href="${pageContext.request.contextPath}/dashboard">
            Volver al dashboard
        </a>

    </div>

</div>

</body>
</html>