<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

session_start();
include("conexion.php");

$error = "";
if (isset($_SESSION['login_error'])) {
    $error = $_SESSION['login_error'];
    unset($_SESSION['login_error']);
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $correo     = isset($_POST['correo']) ? trim($_POST['correo']) : '';
    $contrasena = isset($_POST['contrasena']) ? $_POST['contrasena'] : '';

    if ($correo !== '' && $contrasena !== '') {

        $hash = md5($contrasena);
        $stmt = $conexion->prepare("
            SELECT IdUsuario, Nombre_de_Usuario, Correo, IdRol
            FROM usuario
            WHERE Correo = ? AND Contrasena = ?
        ");

        if ($stmt) {
            $stmt->bind_param("ss", $correo, $hash);
            $stmt->execute();
            $res = $stmt->get_result();

            if ($res && $res->num_rows === 1) {
                $row = $res->fetch_assoc();

                //   Cargar módulos por rol
                $idRol = (int)$row['IdRol'];
                $mods  = [];

                $sqlPerm = "
                    SELECT m.Clave
                    FROM rolmodulo rm
                    INNER JOIN modulo m ON m.IdModulo = rm.IdModulo
                    WHERE rm.IdRol = ?
                ";

                $stPerm = $conexion->prepare($sqlPerm);
                if ($stPerm) {
                    $stPerm->bind_param("i", $idRol);
                    $stPerm->execute();
                    $resPerm = $stPerm->get_result();

                    while ($perm = $resPerm->fetch_assoc()) {
                
                        $mods[] = $perm['Clave'];
                    }
                }

          
                //   Guardar sesión
         
                session_regenerate_id(true);
                $_SESSION['id']         = $row['IdUsuario'];
                $_SESSION['id_usuario'] = $row['IdUsuario'];
                $_SESSION['nombre']     = $row['Nombre_de_Usuario'];
                $_SESSION['correo']     = $row['Correo'];
                $_SESSION['id_rol']     = $idRol;
                $_SESSION['modulos']    = $mods;   

                header("Location: menu.php");
                exit();
            } else {
                $_SESSION['login_error'] = "Correo o contraseña incorrectos.";
                header("Location: index.php");
                exit();
            }
        } else {
            $error = "Error en la consulta: " . $conexion->error;
        }
    } else {
        $error = "Debe completar ambos campos.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio de Sesión - TodaModaMasayaWeb</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</head>
<body>
    <div class="login-container">
        <div class="logo-container">
            <img src="img/logo.jpg" alt="Logo de la tienda" class="logo">
        </div>
        <h2>Iniciar Sesión</h2>
        <form method="POST" id="loginForm" novalidate>
            <div class="input-group">
                <ion-icon name="mail-outline"></ion-icon>
                <input type="email" name="correo" placeholder="Correo" required>
            </div>
            <div class="input-group">
                <ion-icon name="lock-closed-outline"></ion-icon>
                <input type="password" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                <ion-icon name="eye-outline" id="togglePassword" class="eye-icon"></ionicon>
            </div>
            <button type="submit">Entrar</button>
        </form>
    </div>

    <?php if (!empty($error)): ?>
        <div class="toast" id="toast">
            <p><?php echo htmlspecialchars($error, ENT_QUOTES, 'UTF-8'); ?></p>
            <button id="closeToast" type="button">Aceptar</button>
        </div>
    <?php endif; ?>

    <script src="js/script.js"></script>
</body>
</html>
