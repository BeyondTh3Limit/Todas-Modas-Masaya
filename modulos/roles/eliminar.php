<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';




if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['ok' => false, 'msg' => 'Método no permitido']);
    exit;
}

try {
    $IdRol = isset($_POST['IdRol']) ? (int)$_POST['IdRol'] : 0;
    if ($IdRol <= 0) {
        echo json_encode(['ok' => false, 'msg' => 'Id de rol inválido']);
        exit;
    }


    $conexion->begin_transaction();

    // borrar permisos
    $stDelPerm = $conexion->prepare("DELETE FROM rolmodulo WHERE IdRol = ?");
    $stDelPerm->bind_param("i", $IdRol);
    $stDelPerm->execute();

    // borrar rol
    $stDelRol = $conexion->prepare("DELETE FROM rol WHERE IdRol = ?");
    $stDelRol->bind_param("i", $IdRol);
    $stDelRol->execute();

    $conexion->commit();

    echo json_encode(['ok' => true, 'msg' => 'Rol eliminado correctamente']);

} catch (mysqli_sql_exception $e) {
    $conexion->rollback();

    // si hay usuarios con ese rol, dará error por FK
    if ($e->getCode() == 1451) {
        echo json_encode([
          'ok' => false,
          'msg' => 'No se puede eliminar el rol porque está asignado a uno o más usuarios.'
        ]);
    } else {
        echo json_encode(['ok' => false, 'msg' => 'Error: '.$e->getMessage()]);
    }

} catch (Exception $e) {
    $conexion->rollback();
    echo json_encode(['ok' => false, 'msg' => 'Error: '.$e->getMessage()]);
}
