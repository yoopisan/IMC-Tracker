<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calcular IMC | IMC Tracker</title>

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
        }

        h2 {
            text-align: center;
            color: #087f8c;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #087f8c;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #066570;
        }

        .error {
            background: #ffe5e5;
            color: #a00000;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 15px;
        }

        .enlace {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #087f8c;
            text-decoration: none;
        }

        .nota {
            color: #667;
            font-size: 13px;
            margin-top: 6px;
        }
    </style>
</head>

<body>

<header>
    <h1>IMC Tracker</h1>
    <p>Registro de nueva medición</p>
</header>

<div class="contenedor">

    <h2>Calcular mi IMC</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/calcular"
          method="POST">

        <label for="peso">Peso actual (kg)</label>
        <input type="number"
               id="peso"
               name="peso"
               min="20"
               max="500"
               step="0.01"
               placeholder="Ej. 66.5"
               required>

        <label for="estatura">Estatura (metros)</label>
        <input type="number"
               id="estatura"
               name="estatura"
               min="1"
               max="2.5"
               step="0.01"
               placeholder="Ej. 1.68"
               required>

        <p class="nota">
            Ingresa tu estatura en metros, no en centímetros.
        </p>

        <button type="submit">Calcular y guardar medición</button>

    </form>

    <a class="enlace"
       href="${pageContext.request.contextPath}/dashboard">
        Volver al dashboard
    </a>

</div>

</body>
</html>