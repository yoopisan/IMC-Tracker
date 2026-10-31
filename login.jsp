<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión | IMC Tracker</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #263238;
        }

        .login-container {
            width: 90%;
            max-width: 420px;
            padding: 40px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
            text-align: center;
            color: #198f88;
        }

        .subtitle {
            text-align: center;
            color: #687780;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccd5dc;
            border-radius: 7px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #198f88;
        }

        button {
            width: 100%;
            padding: 13px;
            background: #198f88;
            color: white;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #14736e;
        }

        .error {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 7px;
            background: #fdeaea;
            color: #b42318;
            font-size: 14px;
            text-align: center;
        }

        .register-link {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
        }

        a {
            color: #198f88;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="login-container">

        <h1>IMC Tracker</h1>

        <p class="subtitle">
            Inicia sesión para consultar tu información.
        </p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="POST">

            <label for="nombreUsuario">Nombre de usuario</label>
            <input
                type="text"
                id="nombreUsuario"
                name="nombreUsuario"
                required
                autocomplete="username"
            >

            <label for="password">Contraseña</label>
            <input
                type="password"
                id="password"
                name="password"
                required
                autocomplete="current-password"
            >

            <button type="submit">Iniciar sesión</button>

        </form>

        <div class="register-link">
            ¿Todavía no tienes una cuenta?
            <a href="<%= request.getContextPath() %>/registro">
                Regístrate aquí
            </a>
        </div>

    </div>

</body>
</html>