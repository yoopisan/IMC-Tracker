<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard | IMC Tracker</title>

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
            padding: 25px;
            text-align: center;
        }

        .contenedor {
            max-width: 1000px;
            margin: 45px auto;
            padding: 25px;
        }

        .bienvenida {
            text-align: center;
            margin-bottom: 35px;
        }

        .bienvenida h2 {
            color: #087f8c;
            font-size: 28px;
        }

        .tarjetas {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 20px;
        }

        .tarjeta {
            background: white;
            padding: 30px 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }

        .tarjeta:hover {
            transform: translateY(-5px);
        }

        .tarjeta h3 {
            color: #087f8c;
            font-size: 21px;
        }

        .tarjeta p {
            color: #667;
            min-height: 40px;
        }

        .boton {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 20px;
            background: #087f8c;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .boton:hover {
            background: #066570;
        }

        .cerrar {
            display: block;
            width: fit-content;
            margin: 40px auto 0;
            padding: 12px 25px;
            background: #d9534f;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .cerrar:hover {
            background: #b52b27;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #667;
        }
    </style>
</head>

<body>

<header>
    <h1>IMC Tracker</h1>
    <p>Seguimiento de tu índice de masa corporal</p>
</header>

<div class="contenedor">

    <div class="bienvenida">
        <h2>
            ¡Bienvenido, <%= request.getAttribute("nombreUsuario") %>!
        </h2>

        <p>
            Administra tus mediciones y consulta tu progreso
            desde un solo lugar.
        </p>
    </div>

    <div class="tarjetas">

        <div class="tarjeta">
            <h3>Calcular IMC</h3>

            <p>
                Registra tu peso y estatura para obtener
                tu índice de masa corporal.
            </p>

            <a class="boton"
               href="${pageContext.request.contextPath}/calcular">
                Nueva medición
            </a>
        </div>

        <div class="tarjeta">
            <h3>Mi historial</h3>

            <p>
                Consulta tus mediciones anteriores y
                revisa cómo han cambiado tus resultados.
            </p>

            <a class="boton"
               href="${pageContext.request.contextPath}/historial">
                Ver historial
            </a>
        </div>

        <div class="tarjeta">
            <a href="<%= request.getContextPath() %>/perfil">
                Mi cuenta
            </a>

            <p>
                Consulta las opciones disponibles
                para administrar tu sesión.
            </p>

            <a class="boton"
               href="${pageContext.request.contextPath}/logout">
                Cerrar sesión
            </a>
        </div>

    </div>

    <a class="cerrar"
       href="${pageContext.request.contextPath}/logout">
        Salir de IMC Tracker
    </a>

</div>

<footer>
    IMC Tracker - Proyecto académico de desarrollo web
</footer>

</body>
</html>