-- Actualizacion de restricciones de FK de tabla de usuarios y perfiles

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;

SET
    @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
    FOREIGN_KEY_CHECKS = 0;

SET
    @OLD_SQL_MODE = @@SQL_MODE,
    SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- INICIO DE LA MIGRACIONALTER TABLE nombre_tabla_hija DROP FOREIGN KEY nombre_fk;ALTER TABLE nombre_tabla_hija DROP FOREIGN KEY nombre_fk;

ALTER TABLE perfil_tiene_permiso DROP FOREIGN KEY fk_perfil_tiene_permiso_permiso1;
ALTER TABLE perfil_tiene_permiso
ADD CONSTRAINT fk_perfil_tiene_permiso_permiso1 FOREIGN KEY (permiso_id) REFERENCES permiso (id) ON DELETE RESTRICT;

ALTER TABLE usuario_tiene_perfil DROP FOREIGN KEY fk_usuario_tiene_perfil_perfil1;
ALTER TABLE usuario_tiene_perfil
ADD CONSTRAINT fk_usuario_tiene_perfil_perfil1 FOREIGN KEY (perfil_id) REFERENCES perfil (id) ON DELETE RESTRICT;

ALTER TABLE usuario_tiene_permiso DROP FOREIGN KEY fk_usuario_tiene_permiso_permiso1;

ALTER TABLE usuario_tiene_permiso
ADD CONSTRAINT fk_usuario_tiene_permiso_permiso1 FOREIGN KEY (permiso_id) REFERENCES permiso (id) ON DELETE RESTRICT;

INSERT INTO
    `migraciones` (
        `tipo`,
        `nombre`,
        `descripcion`,
        `archivo`
    )
VALUES (
        'DDL',
        'Alter FKs de usuario y perfil',
        'Re4stricciones FK de usuario y perfil',
        'mig_011_ddl_constraints_fk_perfiles_usuarios.sql'
    );

-- FIN DE LA MIGRACION

SET SQL_MODE = @OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
