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

try {
    $IdRol = isset($_GET['IdRol']) ? (int)$_GET['IdRol'] : 0;
    if ($IdRol <= 0) {
        echo json_encode(['ok' => false, 'msg' => 'Id de rol inválido']);
        exit;
    }

    // Datos del rol
    $st = $conexion->prepare("SELECT IdRol, Descripcion FROM Rol WHERE IdRol = ?");
    $st->bind_param("i", $IdRol);
    $st->execute();
    $res = $st->get_result();
    $rol = $res->fetch_assoc();
    if (!$rol) {
        echo json_encode(['ok' => false, 'msg' => 'Rol no encontrado']);
        exit;
    }

    // Módulos asignados
    $st2 = $conexion->prepare("SELECT IdModulo FROM RolModulo WHERE IdRol = ?");
    $st2->bind_param("i", $IdRol);
    $st2->execute();
    $res2 = $st2->get_result();
    $modIds = [];
    while ($r = $res2->fetch_assoc()) {
        $modIds[] = (int)$r['IdModulo'];
    }

    echo json_encode([
        'ok'  => true,
        'rol' => [
            'IdRol'       => (int)$rol['IdRol'],
            'Descripcion' => $rol['Descripcion'],
        ],
        'modulos' => $modIds
    ], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode(['ok' => false, 'msg' => 'Error: '.$e->getMessage()]);
}
