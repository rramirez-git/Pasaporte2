<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include_once __DIR__ . '/app/usuario/model.php';
session_start();

date_default_timezone_set('America/Mexico_City');
include_once __DIR__ . '/helpers/db.php';

/**
 * Devuelve todos los eventos que todavía no han ocurrido y que requieren registro.
 *
 * @return array Lista de filas asociativas (cada evento tiene sus columnas)
 */
function obtenerEventosPendientes(): array {
    $tbl = new Table('evento');
    $now = date('Y-m-d H:i:s');
    try {
        // sólo eventos futuros y que requieran inscripción
        return $tbl->selectAll('fecha_hora >= ? AND requiere_registro = 1 ORDER BY fecha_hora ASC', [$now]);
    } catch (Exception $e) {
        // en caso de error devolvemos arreglo vacío
        return [];
    }
}

/**
 * Indica si el usuario ya está inscrito en el evento.
 */
function estaRegistrado(int $usuarioId, int $eventoId): bool {
    $tbl = new Table('registro');
    $row = $tbl->select('usuario_id = ? AND evento_id = ?', [$usuarioId, $eventoId]);
    return $row !== null;
}

/**
 * Añade una tupla a la tabla `registro`.
 * Devuelve true si se insertó correctamente.
 * Lanza excepción si hay un error de base de datos.
 */
function registrarUsuarioAEvento(int $usuarioId, int $eventoId): bool {
    $tbl = new Table('registro');
    // el método insert devuelve el id_insertado, pero en este
    // caso la tabla no tiene PK autoincremental (clave compuesta),
    // así que sólo comprobamos que no devuelva false.
    $res = $tbl->insert(['usuario_id' => $usuarioId, 'evento_id' => $eventoId]);
    return $res !== false;
}

/**
 * Muestra la interfaz de autoregistro y procesa cualquier envío.
 */
function manejarAutoregistro(): void {
    // requiere usuario autenticado para asociar la inscripción
    if (!isset($_SESSION['current_user']) || !$_SESSION['current_user']) {
        echo '<div class="alert alert-warning">Debe iniciar sesión para registrarse a un evento.</div>';
        return;
    }

    $userId = $_SESSION['current_user']->id;

    // aceptamos tanto POST como GET para facilitar el enlace directo desde la lista
    $eventoId = null;
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($_POST['evento_id'])) {
        $eventoId = (int)$_POST['evento_id'];
    } elseif (isset($_GET['evento_id']) && is_numeric($_GET['evento_id'])) {
        $eventoId = (int)$_GET['evento_id'];
    }

    if ($eventoId !== null) {
        if (estaRegistrado($userId, $eventoId)) {
            echo '<div class="alert alert-info">Ya estás registrado en este evento.</div>';
        } else {
            try {
                if (registrarUsuarioAEvento($userId, $eventoId)) {
                    echo '<div class="alert alert-success">Tu registro se guardó correctamente.</div>';
                } else {
                    echo '<div class="alert alert-danger">No se pudo completar el registro.</div>';
                }
            } catch (Exception $e) {
                echo '<div class="alert alert-danger">Error al registrar: ' . htmlspecialchars($e->getMessage()) . '</div>';
            }
        }
    }

    $eventos = obtenerEventosPendientes();
    if (empty($eventos)) {
        echo '<p>No hay eventos pendientes disponibles para registro.</p>';
        return;
    }

    echo '<table class="table table-hover"><thead><tr>' .
         '<th>Nombre</th><th>Fecha</th><th>Lugar</th><th></th>' .
         '</tr></thead><tbody>';
    foreach ($eventos as $ev) {
        echo '<tr>';
        echo '<td>' . htmlspecialchars($ev['nombre']) . '</td>';
        echo '<td>' . htmlspecialchars($ev['fecha_hora']) . '</td>';
        echo '<td>' . htmlspecialchars($ev['lugar']) . '</td>';
        echo '<td><form method="post" style="margin:0;display:inline;">' .
             '<input type="hidden" name="evento_id" value="' . htmlspecialchars($ev['id']) . '">' .
             '<button type="submit" class="btn btn-primary btn-sm">Registrar</button>' .
             '</form></td>';
        echo '</tr>';
    }
    echo '</tbody></table>';
}
?>

<!DOCTYPE html>
<html lang="es-MX">
<head>
    <?php include 'templates/head.php'; ?>
    <title>Autoregistro</title>
</head>
<body class="d-flex flex-column vh-100">
    <?php include 'templates/header.php'; ?>

    <main class="container flex-grow-1">
        <h1>Autoregistro</h1>
        <?php manejarAutoregistro(); ?>
    </main>

    <?php include 'templates/footer.php'; ?>
</body>
</html>