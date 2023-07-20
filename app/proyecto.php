<?php

namespace App;

use App\model;


use Exception;

class proyecto extends model
{

    public $fillable = [
        'tutor_id',
        'trayecto_id',
        'nombre',
        'descripcion',
        'municipio',
        'area',
        'repositorio_codigo',
        'repositorio_documentacion',
        'url',
        'estatus',
    ];
    private int $id;
    public int $tutor_id;
    public int $trayecto_id;
    public string $nombre;
    public string $descripcion;
    public string $municipio;
    public string $area;
    public string $repositorio_codigo;
    public string $repositorio_documentacion;
    public string $url;
    public string $estatus;

    public function all()
    {
        try {
            $proyectos = $this->select('proyecto');
            return $proyectos ? $proyectos : null;
        } catch (Exception $th) {
            return $th;
        }
    }


    public function setProyectData(array $data)
    {
        foreach ($data as $prop => $value) {

            if (property_exists($this, $prop) && in_array($prop, $this->fillable)) {
                $this->{$prop} = $value;
            }
        }
    }

    public function saveTeam(int $periodo_id, array $participantes)
    {
        foreach ($participantes as $value) {

            $this->set('estudiante_proyecto', [
                'proyecto_id' => $this->id,
                'periodo_id' => $periodo_id,
                'estudiante_id' => $value
            ]);
        }
    }

    public function save()
    {
        $insertData = [];

        foreach ($this->fillable as $key => $value) {
            if (isset($this->{$value})) {
                if (is_string($this->{$value})) {
                    $insertData[$value] = '"' . $this->{$value} . '"';
                } else {
                    $insertData[$value] =  $this->{$value};
                }
            }
        }
        try {
            $this->set('proyecto', $insertData);
            $this->id = $this->lastInsertId();
            return $this->id;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
}
