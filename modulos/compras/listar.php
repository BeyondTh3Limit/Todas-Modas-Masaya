<?php
session_start();
if (!isset($_SESSION['correo'])) {
    http_response_code(401);
    echo json_encode(['ok' => false, 'msg' => 'No autorizado']);
    exit;
}

require_once dirname(__DIR__, 2) . '/conexion.php';


try {

    $sql = "SELECT c.IdCompra,
                   u.Nombre_de_Usuario   AS Comprador,
                   p.Nombre   AS Proveedor,
                   c.Fecha
            FROM compra c
            JOIN usuario   u ON u.IdUsuario   = c.IdUsuario
            JOIN proveedor p ON p.IdProveedor = c.IdProveedor
            ORDER BY c.IdCompra DESC";

    $res = $conexion->query($sql);

    $data = [];
    while ($row = $res->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode([
        'ok'   => true,
        'data' => $data
    ], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode([
        'ok'  => false,
        'msg' => 'Error al listar compras: ' . $e->getMessage()
    ]);
}
