<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';

try {
    $sql = "SELECT IdModulo, Clave, Titulo FROM modulo ORDER BY Titulo ASC";
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
