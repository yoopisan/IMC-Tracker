<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.imctracker.model.Usuario" %>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/perfil");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi perfil - IMC Tracker</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #f0f7f7;
            padding: 40px 20px;
            color: #263238;
        }

        .container {
            max-width: 650px;
            margin: auto;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #087e8b;
            margin-bottom: 10px;
        }

        .header p {
            color: #607d8b;
        }

        .card {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
        }

        .profile-icon {
            width: 85px;
            height: 85px;
            margin: 0 auto 25px;
            border-radius: 50%;
            background: #d9f1f1;
            color: #087e8b;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
        }

        .info {
            padding: 15px 0;
            border-bottom: 1px solid #e5eeee;
        }

        .info:last-child {
            border-bottom: none;
        }

        .label {
            display: block;
            font-size: 13px;
            color: #78909c;
            margin-bottom: 6px;
        }

        .value {
            font-size: 17px;
            font-weight: bold;
            color: #263238;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 13px;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
        }

        .primary {
            background: #087e8b;
            color: white;
        }

        .secondary {
            background: #e8f1f2;
            color: #087e8b;
        }

        .btn:hover {
            opacity: 0.9;
        }

        @media (max-width: 480px) {
            .card {
                padding: 25px 20px;
            }

            .buttons {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Mi perfil</h1>
        <p>Consulta tu información personal registrada.</p>
    </div>

    <div class="card">

        <div class="profile-icon">👤</div>

        <div class="info">
            <span class="label">Nombre completo</span>
            <span class="value"><%= usuario.getNombreCompleto() %></span>
        </div>

        <div class="info">
            <span class="label">Nombre de usuario</span>
            <span class="value"><%= usuario.getNombreUsuario() %></span>
        </div>

        <div class="info">
            <span class="label">Edad</span>
            <span class="value"><%= usuario.getEdad() %> años</span>
        </div>

        <div class="info">
            <span class="label">Sexo</span>
            <span class="value"><%= usuario.getSexo() %></span>
        </div>

        <div class="info">
            <span class="label">Estatura</span>
            <span class="value"><%= usuario.getEstatura() %> m</span>
        </div>

        <div class="buttons">
            <a href="<%= request.getContextPath() %>/dashboard"
               class="btn secondary">Volver al inicio</a>

            <a href="<%= request.getContextPath() %>/logout"
               class="btn primary">Cerrar sesión</a>
        </div>

    </div>
</div>

</body>
</html>