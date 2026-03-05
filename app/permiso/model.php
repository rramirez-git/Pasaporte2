<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include_once __DIR__ . '/../../helpers/db.php';

class Permiso extends Model
{
    public function __construct(array $config = [])
    {
        parent::__construct('permiso', config: $config);
    }

    public function __tostring(): string
    {
        return $this->codename ?? "Permiso";
    }

    public function getAll(): array {
        $data = parent::getAll();
        uasort($data, function($a, $b) {
            $cmp = strcmp($a['tipo'], $b['tipo']);
            if ($cmp !== 0) return $cmp;
            $cmp = strcmp($a['codename'], $b['codename']);
            if ($cmp !== 0) return $cmp;
            return strcmp($a['nombre'], $b['nombre']);
        });
        return $data;
    }
}
