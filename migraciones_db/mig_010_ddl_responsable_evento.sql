-- Creacion de tabla para designar responsables de eventos

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- INICIO DE LA MIGRACION

CREATE TABLE IF NOT EXISTS `responsable_evento` (
    `evento_id` BIGINT NOT NULL,
    `usuario_id` BIGINT NOT NULL,
    PRIMARY KEY (`evento_id`, `usuario_id`),
    INDEX `fk_responsable_evento_usuario_idx` (`usuario_id` ASC)  ,
    INDEX `fk_responsable_evento_evento_idx` (`evento_id` ASC)  ,
    CONSTRAINT `fk_responsable_evento_evento` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_responsable_evento_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

INSERT INTO `migraciones` (`tipo`, `nombre`, `descripcion`, `archivo`)
VALUES ('DDL', 'Create responsable_evento tbl', 'Tabla puente para organizar que usuarios gestionan eventos', 'mig_010_ddl_responsable_evento.sql');

-- FIN DE LA MIGRACION

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
