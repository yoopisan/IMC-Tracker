
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro | IMC Tracker</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px 15px;
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            color: #263445;
        }

        .contenedor {
            width: 100%;
            max-width: 520px;
            margin: 30px auto;
            padding: 35px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        h1 {
            margin: 0 0 10px;
            text-align: center;
            color: #176b87;
        }

        .descripcion {
            text-align: center;
            color: #64748b;
            margin-bottom: 28px;
        }

        .campo {
            margin-bottom: 17px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 15px;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #176b87;
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            border: none;
            border-radius: 7px;
            background: #176b87;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #12546b;
        }

        .mensaje {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 7px;
            font-size: 14px;
        }

        .error {
            color: #991b1b;
            background: #fee2e2;
        }

        .exito {
            color: #166534;
            background: #dcfce7;
        }

        .nota {
            margin-top: 20px;
            text-align: center;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 480px) {
            .contenedor {
                padding: 25px 20px;
            }
        }
    </style>
</head>

<body>

<div class="contenedor">

    <h1>IMC Tracker</h1>

    <p class="descripcion">
        Crea tu cuenta para comenzar a monitorear tu índice de masa corporal.
    </p>

    <% if (request.getAttribute("error") != null) { %>
        <div class="mensaje error">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <% if ("true".equals(request.getParameter("exito"))) { %>
        <div class="mensaje exito">
            ¡Tu registro se completó correctamente!
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/registro"
          method="POST">

        <div class="campo">
            <label for="nombreCompleto">Nombre completo</label>
            <input type="text"
                   id="nombreCompleto"
                   name="nombreCompleto"
                   maxlength="120"
                   autocomplete="name"
                   required>
        </div>

        <div class="campo">
            <label for="nombreUsuario">Nombre de usuario</label>
            <input type="text"
                   id="nombreUsuario"
                   name="nombreUsuario"
                   maxlength="50"
                   autocomplete="username"
                   required>
        </div>

        <div class="campo">
            <label for="password">Contraseña</label>
            <input type="password"
                   id="password"
                   name="password"
                   minlength="8"
                   maxlength="72"
                   autocomplete="new-password"
                   required>
        </div>

        <div class="campo">
            <label for="edad">Edad</label>
            <input type="number"
                   id="edad"
                   name="edad"
                   min="15"
                   max="120"
                   required>
        </div>

        <div class="campo">
            <label for="sexo">Sexo</label>
            <select id="sexo" name="sexo" required>
                <option value="">Selecciona una opción</option>
                <option value="Masculino">Masculino</option>
                <option value="Femenino">Femenino</option>
                <option value="Otro">Otro</option>
            </select>
        </div>

        <div class="campo">
            <label for="estatura">Estatura (metros)</label>
            <input type="number"
                   id="estatura"
                   name="estatura"
                   min="1.00"
                   max="2.50"
                   step="0.01"
                   placeholder="Ej. 1.68"
                   required>
        </div>

        <button type="submit">Crear cuenta</button>

    </form>

    <p class="nota">
        IMC Tracker | Monitorea tu salud y progreso.
    </p>

</div>

</body>
</html>
