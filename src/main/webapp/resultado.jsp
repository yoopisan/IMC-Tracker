<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.imctracker.model.Medicion" %>
<%
    Medicion medicion = (Medicion) request.getAttribute("medicion");

    if (medicion == null) {
        response.sendRedirect(request.getContextPath() + "/calcular");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado | IMC Tracker</title>

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
            max-width: 500px;
            margin: 45px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            text-align: center;
        }

        .resultado {
            font-size: 55px;
            font-weight: bold;
            color: #087f8c;
            margin: 20px 0;
        }

        .clasificacion {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .dato {
            padding: 12px;
            margin: 8px 0;
            background: #f0f7f7;
            border-radius: 6px;
        }

        a {
            display: block;
            margin-top: 18px;
            padding: 13px;
            border-radius: 6px;
            background: #087f8c;
            color: white;
            text-decoration: none;
        }

        a:hover {
            background: #066570;
        }

        .nota {
            color: #667;
            font-size: 12px;
            margin-top: 20px;
        }
    </style>
</head>

<body>

<header>
    <h1>IMC Tracker</h1>
    <p>Resultado de tu medición</p>
</header>

<div class="contenedor">

    <h2>Tu índice de masa corporal</h2>

    <div class="resultado">
        <%= String.format(java.util.Locale.US, "%.2f", medicion.getImc()) %>
    </div>

    <div class="clasificacion">
        <%= medicion.getClasificacion() %>
    </div>

    <div class="dato">
        <strong>Peso:</strong>
        <%= medicion.getPeso() %> kg
    </div>

    <div class="dato">
        <strong>Estatura:</strong>
        <%= medicion.getEstatura() %> m
    </div>

    <p class="nota">
        El IMC es un indicador general y no constituye por sí solo
        una evaluación completa del estado de salud.
    </p>

    <a href="${pageContext.request.contextPath}/calcular">
        Registrar otra medición
    </a>

    <a href="${pageContext.request.contextPath}/dashboard">
        Volver al dashboard
    </a>

</div>

</body>
</html>