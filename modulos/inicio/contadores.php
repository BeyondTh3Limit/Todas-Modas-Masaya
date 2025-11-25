<?php
session_start();
if (!isset($_SESSION['correo'])) {
    http_response_code(401);
    header('Content-Type: application/json');
    echo json_encode(['ok'=>false,'msg'=>'No autorizado']);
    exit;
}

require_once dirname(__DIR__, 2) . '/conexion.php';
;

try {
    // Total clientes
    $q = $conexion->query("SELECT COUNT(*) AS c FROM cliente");
    $clientes = (int)$q->fetch_assoc()['c'];

    // Total proveedores
    $q = $conexion->query("SELECT COUNT(*) AS c FROM proveedor");
    $proveedores = (int)$q->fetch_assoc()['c'];

    // Unidades existentes (stock)
    $q = $conexion->query("SELECT COALESCE(SUM(Cantidad),0) AS s FROM producto");
    $inventario = (int)$q->fetch_assoc()['s'];

    // Unidades vendidas e importe vendido
    $q = $conexion->query("
        SELECT 
            COALESCE(SUM(d.Cantidad),0)         AS unidades,
            COALESCE(SUM(d.Subtotal),0)         AS importe
        FROM detalle_de_salida d
        JOIN salida_de_stock s ON s.IdVenta = d.IdVenta
    ");
    $row = $q->fetch_assoc();
    $vendidas = (int)$row['unidades'];
    $importe  = (float)$row['importe'];

    echo json_encode([
        'ok'          => true,
        'Clientes'    => $clientes,
        'Proveedores' => $proveedores,
        'Inventario'  => $inventario,
        'Vendidas'    => $vendidas,
        'Importe'     => $importe
    ], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode(['ok'=>false,'msg'=>$e->getMessage()]);
}
