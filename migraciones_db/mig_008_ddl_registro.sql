-- Creacion de tabla para el pre-registro a eventos

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- INICIO DE LA MIGRACION

CREATE TABLE IF NOT EXISTS `registro` (
    `evento_id` BIGINT NOT NULL,
    `usuario_id` BIGINT NOT NULL,
    `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`evento_id`, `usuario_id`),
    INDEX `fk_registro_usuario_idx` (`usuario_id` ASC)  ,
    INDEX `fk_registro_evento_idx` (`evento_id` ASC)  ,
    CONSTRAINT `fk_registro_evento` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_registro_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

INSERT INTO `migraciones` (`tipo`, `nombre`, `descripcion`, `archivo`)
VALUES ('DDL', 'Create registro tbl', 'Tabla para la pre-inscripcion de usuarios a eventos', 'mig_008_ddl_registro.sql');

-- FIN DE LA MIGRACION

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
