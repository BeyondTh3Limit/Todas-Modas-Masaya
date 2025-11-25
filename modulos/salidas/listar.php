<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';

$q      = trim($_GET['q'] ?? '');
$desde  = $_GET['desde'] ?? '';
$hasta  = $_GET['hasta'] ?? '';

$sql = "SELECT s.IdVenta, s.Fecha, s.Metodo_de_pago,
               u.Nombre_de_Usuario AS Vendedor,
               CONCAT(c.Nombre,' ',c.Apellido) AS Cliente
        FROM salida_de_stock s
        JOIN usuario u ON u.IdUsuario = s.IdUsuario
        JOIN cliente c ON c.IdCliente = s.IdCliente
        WHERE 1=1";
$par = [];

if ($q !== '') {
  $sql .= " AND (CONCAT(c.Nombre,' ',c.Apellido) LIKE ?)";
  $par[] = "%$q%";
}
if ($desde !== '') { $sql .= " AND s.Fecha >= ?"; $par[] = $desde; }
if ($hasta !== '') { $sql .= " AND s.Fecha <= ?"; $par[] = $hasta; }

$sql .= " ORDER BY s.IdVenta DESC";

$stmt = $conexion->prepare($sql);
if ($par) {
  $types = str_repeat('s', count($par));
  $stmt->bind_param($types, ...$par);
}
$stmt->execute();
$res = $stmt->get_result();

$data = [];
while ($row = $res->fetch_assoc()) $data[] = $row;

echo json_encode(['ok'=>true,'data'=>$data], JSON_UNESCAPED_UNICODE);