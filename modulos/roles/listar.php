<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';

try {
    $sql = "
      SELECT r.IdRol, r.Descripcion, COUNT(rm.IdModulo) AS NumModulos
      FROM rol r
      LEFT JOIN rolmodulo rm ON rm.IdRol = r.IdRol
      GROUP BY r.IdRol, r.Descripcion
      ORDER BY r.IdRol ASC
    ";

    $res = $conexion->query($sql);
    $data = [];
    while ($row = $res->fetch_assoc()) {
        $data[] = [
            'IdRol'      => (int)$row['IdRol'],
            'Descripcion'=> $row['Descripcion'],
            'NumModulos' => (int)$row['NumModulos'],
        ];
    }

    echo json_encode(['ok' => true, 'data' => $data], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode(['ok' => false, 'msg' => 'Error: '.$e->getMessage()]);
}
