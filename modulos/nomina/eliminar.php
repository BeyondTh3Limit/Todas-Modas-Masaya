<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';

try {
    $IdNomina = (int)($_POST['IdNomina'] ?? 0);
    if ($IdNomina <= 0) {
        echo json_encode(['ok'=>false,'msg'=>'IdNomina inválido']);
        exit;
    }

    $stmt = $conexion->prepare("DELETE FROM nomina WHERE IdNomina=?");
    $stmt->bind_param("i", $IdNomina);
    $stmt->execute();

    echo json_encode(['ok'=>true,'msg'=>'Nómina eliminada']);

} catch (Exception $e) {
    echo json_encode(['ok'=>false,'msg'=>'Error: '.$e->getMessage()]);
}
