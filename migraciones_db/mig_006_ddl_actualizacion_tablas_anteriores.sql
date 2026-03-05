alter table usuario ADD
matricula VARCHAR(50) NULL;

insert into permiso (tipo, codename, nombre) values
('evento', 'add_evento', 'Agregar evento'),
('evento', 'change_evento', 'Cambiar evento'),
('evento', 'delete_evento', 'Eliminar evento'),
('evento', 'view_evento', 'Ver evento'),
('evento', 'list_evento', 'Listar eventos');

INSERT INTO
    `migraciones` (
        `tipo`,
        `nombre`,
        `descripcion`,
        `archivo`
    )
VALUES (
        'DDL',
        'actualizacion tablas anteriores',
        'Actualizacion de tablas anteriores con nueva columna matricula',
        'mig_006_ddl_actualizacion_tablas_anteriores.sql'
    );

-- FIN DE LA MIGRACION
