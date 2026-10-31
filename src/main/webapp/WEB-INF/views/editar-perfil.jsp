<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.imctracker.model.Usuario" %>
<%@ page import="com.imctracker.util.HtmlUtil" %>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/perfil");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar perfil - IMC Tracker</title>

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
            max-width: 550px;
            margin: auto;
        }

        .header {
            text-align: center;
            margin-bottom: 25px;
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

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 13px;
            border: 1px solid #cfd8dc;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        input:focus, select:focus {
            border-color: #087e8b;
            box-shadow: 0 0 0 2px rgba(8,126,139,0.12);
        }

        .error {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        button, .cancel {
            flex: 1;
            padding: 13px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 15px;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
        }

        button {
            background: #087e8b;
            color: white;
        }

        .cancel {
            background: #e8f1f2;
            color: #087e8b;
        }

        button:hover, .cancel:hover {
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
        <h1>Editar mi perfil</h1>
        <p>Actualiza tu información personal.</p>
    </div>

    <div class="card">

        <% if (error != null) { %>
            <div class="error"><%= HtmlUtil.escapar(error) %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/editar-perfil"
              method="POST">

            <div class="form-group">
                <label for="nombreCompleto">Nombre completo</label>
                <input type="text"
                       id="nombreCompleto"
                       name="nombreCompleto"
                       maxlength="120"
                       value="<%= HtmlUtil.escapar(usuario.getNombreCompleto()) %>"
                       required>
            </div>

            <div class="form-group">
                <label for="edad">Edad</label>
                <input type="number"
                       id="edad"
                       name="edad"
                       min="15"
                       max="120"
                       value="<%= usuario.getEdad() %>"
                       required>
            </div>

            <div class="form-group">
                <label for="sexo">Sexo</label>
                <select id="sexo" name="sexo" required>
                    <option value="Masculino"
                        <%= "Masculino".equals(usuario.getSexo()) ? "selected" : "" %>>
                        Masculino
                    </option>

                    <option value="Femenino"
                        <%= "Femenino".equals(usuario.getSexo()) ? "selected" : "" %>>
                        Femenino
                    </option>

                    <option value="Otro"
                        <%= "Otro".equals(usuario.getSexo()) ? "selected" : "" %>>
                        Otro
                    </option>
                </select>
            </div>

            <div class="form-group">
                <label for="estatura">Estatura (metros)</label>
                <input type="number"
                       id="estatura"
                       name="estatura"
                       min="1"
                       max="2.5"
                       step="0.01"
                       value="<%= usuario.getEstatura() %>"
                       required>
            </div>

            <div class="buttons">
                <a href="<%= request.getContextPath() %>/perfil"
                   class="cancel">Cancelar</a>

                <button type="submit">Guardar cambios</button>
            </div>

        </form>

    </div>
</div>

</body>
</html>