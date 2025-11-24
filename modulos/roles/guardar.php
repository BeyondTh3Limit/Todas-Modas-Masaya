<?php
session_start();
if (!isset($_SESSION['correo'])) {
    http_response_code(401);
    header('Content-Type: application/json');
    echo json_encode(['ok' => false, 'msg' => 'No autorizado']);
    exit;
}

require_once dirname(__DIR__, 2) . '/conexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['ok' => false, 'msg' => 'Método no permitido']);
    exit;
}

try {
    $IdRol       = isset($_POST['IdRol']) ? (int)$_POST['IdRol'] : 0;
    $Descripcion = trim($_POST['Descripcion'] ?? '');

    if ($Descripcion === '') {
        echo json_encode(['ok' => false, 'msg' => 'La descripción del rol es obligatoria']);
        exit;
    }

    // lista de módulos seleccionados
    $modulos = $_POST['modulos'] ?? [];
    if (!is_array($modulos)) {
        $modulos = [];
    }
    $modulos = array_map('intval', $modulos);

    $conexion->begin_transaction();

    if ($IdRol > 0) {
        // actualizar
        $st = $conexion->prepare("UPDATE Rol SET Descripcion = ? WHERE IdRol = ?");
        $st->bind_param("si", $Descripcion, $IdRol);
        $st->execute();

    } else {
        // insertar
        $st = $conexion->prepare("INSERT INTO Rol (Descripcion) VALUES (?)");
        $st->bind_param("s", $Descripcion);
        $st->execute();
        $IdRol = $conexion->insert_id;
    }

    // borrar permisos actuales
    $stDel = $conexion->prepare("DELETE FROM RolModulo WHERE IdRol = ?");
    $stDel->bind_param("i", $IdRol);
    $stDel->execute();

    // insertar permisos nuevos
    if (!empty($modulos)) {
        $stIns = $conexion->prepare("INSERT INTO RolModulo (IdRol, IdModulo) VALUES (?, ?)");
        foreach ($modulos as $idMod) {
            if ($idMod <= 0) continue;
            $stIns->bind_param("ii", $IdRol, $idMod);
            $stIns->execute();
        }
    }

    $conexion->commit();

    echo json_encode(['ok' => true, 'msg' => 'Rol guardado correctamente']);

} catch (Exception $e) {
    $conexion->rollback();
    echo json_encode(['ok' => false, 'msg' => 'Error: '.$e->getMessage()]);
}
