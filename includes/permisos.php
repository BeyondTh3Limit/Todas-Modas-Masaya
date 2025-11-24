<?php
function tieneModulo(string $clave): bool {
    if (!isset($_SESSION)) {
        session_start();
    }
    $mods = $_SESSION['modulos'] ?? [];
    return in_array($clave, $mods, true);
}
