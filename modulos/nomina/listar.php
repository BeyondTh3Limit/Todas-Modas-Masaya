<?php
session_start();
if (!isset($_SESSION['correo'])) { http_response_code(401); exit; }
require_once dirname(__DIR__, 2) . '/conexion.php';

try {
    $sql = "SELECT
              n.IdNomina,
              n.Cedula,
              e.Nombre,
              e.Apellido,
              c.Nombre   AS Cargo,
              n.SalarioBasico,
              n.SalarioBruto,
              n.DeduccionTotal,
              n.SalarioNeto,
              n.FechaRegistro
            FROM nomina n
            JOIN empleado e ON e.Cedula = n.Cedula
            JOIN cargo    c ON c.IdCargo = e.IdCargo
            ORDER BY n.FechaRegistro DESC, n.IdNomina DESC";

    $res = $conexion->query($sql);

    $data = [];
    while ($row = $res->fetch_assoc()) {
        $row['NombreCompleto'] = $row['Nombre'] . ' ' . $row['Apellido'];
        $data[] = $row;
    }

    echo json_encode(['ok' => true, 'data' => $data], JSON_UNESCAPED_UNICODE);
} catch (Exception $e) {
    echo json_encode(['ok' => false, 'msg' => $e->getMessage()]);
}
