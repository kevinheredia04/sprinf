<?php

namespace Model;

use Model\model;

use Exception;
use Utils\Sanitizer;

class periodo extends model
{

  public $fillable = [
    'fecha_inicio',
    'fecha_cierre',
  ];
  private $id;
  private $fecha_inicio;
  private $fecha_cierre;

  public function all()
  {
    try {
      $periodos = $this->select('periodo');
      return $periodos ? $periodos : null;
    } catch (Exception $th) {
      return $th;
    }
  }

  function get(): array
  {
    $periodo = $this->selectOne('periodo');
    return $periodo ? $periodo : [];
  }



  /**
   * setData
   * 
   * Se encarga de asignar los valores en los campos
   * definidos en la variable "fillable", tambien se 
   * encarga de sanitizar cada uno de estos valores
   *
   * @param array $data
   * @return void
   */
  public function setData(array $data)
  {
    foreach ($data as $prop => $value) {

      if (property_exists($this, $prop) && in_array($prop, $this->fillable)) {
        $this->{$prop} = $value;
      }
    }
  }

  /**
   * save
   * 
   * Se encarga de tomar los valores que fueron asignados al modelo
   * previamente y realizar la consulta SQL
   *
   * @param [type] $id
   * @return integer ID de elemento creado o actualizado
   */
  public function save($id = null): int
  {
    $data = [];

    foreach ($this->fillable as $key => $value) {
      if (isset($this->{$value})) {
        if (is_string($this->{$value})) {
          $data[$value] = '"' . Sanitizer::sanitize($this->{$value}) . '"';
        } else {
          $data[$value] =  $this->{$value};
        }
      }
    }
    if ($id) {
      $this->update('periodo', $data, [['id', '=', $id]]);
      return $id;
    } else {
      $this->set('periodo', $data);
      $this->id = $this->lastInsertId();
      return $this->id;
    }
  }



  /**
   * generarSSP
   * 
   * Generar SSP proveniente de la función de data table
   *
   * @return array
   */
  public function generarSSP(): array
  {
    $columns = array(
      array(
        'db'        => 'id',
        'dt'        => 0
      ),
      array(
        'db'        => 'fecha_inicio',
        'dt'        => 1,
        'formatter' => function ($d, $row) {
          return date('d/m/Y', strtotime($d));
        }
      ),
      array(
        'db'        => 'fecha_cierre',
        'dt'        => 2,
        'formatter' => function ($d, $row) {
          return date('d/m/Y', strtotime($d));
        }
      )
    );
    return $this->getSSP('periodo', 'id', $columns);
  }
}