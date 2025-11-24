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
    $sql = "SELECT IdModulo, Clave, Titulo FROM Modulo ORDER BY Titulo ASC";
    $res = $conexion->query($sql);
    $mods = [];
    while ($row = $res->fetch_assoc()) {
        $mods[] = [
            'IdModulo' => (int)$row['IdModulo'],
            'Clave'    => $row['Clave'],
            'Titulo'   => $row['Titulo'],
        ];
    }

    echo json_encode(['ok' => true, 'modulos' => $mods], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode(['ok' => false, 'msg' => 'Error: '.$e->getMessage()]);
}
