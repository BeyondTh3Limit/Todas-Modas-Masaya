<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';

try {
  $IdVenta = (int)($_POST['IdVenta'] ?? 0);
  if ($IdVenta<=0) { echo json_encode(['ok'=>false,'msg'=>'Id inválido']); exit; }

  $conexion->begin_transaction();

  // Regresar stock
  $rs = $conexion->query("SELECT IdProducto, Cantidad FROM detalle_de_salida WHERE IdVenta=$IdVenta FOR UPDATE");
  while ($row = $rs->fetch_assoc()) {
    $conexion->query("UPDATE producto SET Cantidad = Cantidad + ".(int)$row['Cantidad']." WHERE IdProducto=".(int)$row['IdProducto']);
  }

  $conexion->query("DELETE FROM detalle_de_salida WHERE IdVenta=$IdVenta");
  $conexion->query("DELETE FROM salida_de_stock WHERE IdVenta=$IdVenta");

  $conexion->commit();
  echo json_encode(['ok'=>true,'msg'=>'Salida eliminada']);
} catch (Exception $e) {
  $conexion->rollback();
  echo json_encode(['ok'=>false,'msg'=>$e->getMessage()]);
}