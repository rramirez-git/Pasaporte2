<!DOCTYPE html>
<html lang="es-MX">

<head>
    <?php
    include_once 'helpers/vars.php';
    include 'templates/head.php';
    ?>
</head>

<body>
    <?php include 'templates/header.php'; ?>

    <main class="container">
        <h1>Usuarios</h1>

        <?php
        $accion = getvar('accion');
        var_dump($accion);
        if($accion === '' || $accion === 'listar') {
            include 'app/usuario/listar.php';
        } elseif($accion === 'actualizar') {
            include 'app/usuario/actualizar.php';
        } elseif ($accion === 'crear') {
            include 'app/usuario/crear.php';
        } elseif ($accion === 'mostrar') {
            include 'app/usuario/mostrar.php';
        }
        ?>

    </main>

    <?php include 'templates/footer.php'; ?>
</body>

</html>
