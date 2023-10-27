<?php

namespace Model;

use Model\model;
use Utils\Sanitizer;

use Exception;

class proyectoHistorico extends model
{

  public $fillable = [
    'id_proyecto',
    'consejo_comunal_id',
    'codigo_trayecto',
    'codigo_siguiente_trayecto',
    'nombre_estudiante',
    'cedula_estudiante',
    'nombre_proyecto',
    'nombre_trayecto',
    'resumen',
    'direccion',
    'comunidad',
    'motor_productivo',
    'nombre_consejo_comunal',
    'nombre_vocero_consejo_comunal',
    'telefono_consejo_comunal',
    'sector_consejo_comunal',
    'municipio',
    'parroquia',
    'observaciones',
    'tutor_in',
    'tutor_ex',
    'tlf_tex',
    'nota_fase_1',
    'nota_fase_2',
    'estatus',
    'periodo_inicio',
    'periodo_final',
  ];
  private int $id_proyecto;
  public int $consejo_comunal_id;
  public string $codigo_trayecto;
  public string $codigo_siguiente_trayecto;
  public string $nombre_estudiante;
  public int $cedula_estudiante;
  public string $nombre_trayecto;
  public string $nombre_proyecto;
  public string $resumen;
  public string $direccion;
  public string $comunidad;
  public string $motor_productivo;
  public string $nombre_consejo_comunal;
  public string $nombre_vocero_consejo_comunal;
  public string $telefono_consejo_comunal;
  public string $sector_consejo_comunal;
  public string $municipio;
  public string $parroquia;
  public string $observaciones;
  public string $tutor_in;
  public int $tlf_tex;
  public string $tutor_ex;
  public float $nota_fase_1;
  public float $nota_fase_2;
  public int $estatus;
  public string $periodo_inicio;
  public string $periodo_final;

  public array $error;

  public function all()
  {
    try {
      $proyectos = $this->select("detalles_historico_proyecto");
      return $proyectos ? $proyectos : null;
    } catch (Exception $th) {
      return $th;
    }
  }

  function allActive(): array
  {
    $proyectos = $this->select("detalles_proyecto");
    return $proyectos ? $proyectos : null;
  }

  function historicalTransaction(): string
  {
    try {
      parent::beginTransaction();
      $proyectos = $this->allActive();


      foreach ($proyectos as $proyecto) {
        $this->codigo_trayecto = $proyecto['codigo_trayecto'];
        $this->id_proyecto = $proyecto['id'];
        $this->nombre_proyecto = $proyecto['nombre'];
        $this->comunidad = $proyecto['comunidad'];
        $this->nombre_trayecto = $proyecto['nombre_trayecto'];
        $this->resumen = $proyecto['resumen'];
        $this->direccion = $proyecto['direccion'];
        $this->parroquia_id = $proyecto['parroquia_id'];
        $this->codigo_siguiente_trayecto = $proyecto['codigo_siguiente_trayecto'];
        $this->tutor_in = $proyecto['tutor_in'];
        $this->tutor_ex = $proyecto['tutor_ex'];
        $this->tlf_tex = $proyecto['tlf_tex'];
        $this->periodo_inicio = $proyecto['fecha_inicio'];
        $this->periodo_final = $proyecto['fecha_cierre'];

        // obtener integrantes
        $integrantes =  $this->obtenerIntegrantes($proyecto['id']);

        foreach ($integrantes as $integrante) {

          $this->cedula_estudiante = $integrante['cedula'];
          $this->nombre_estudiante = $integrante['nombre'];

          $calificacionFases = $this->findStudentGrades($integrante['cedula']);

          foreach ($calificacionFases as $calificacionFase) {
            if (str_contains($calificacionFase['fase_id'], '_1')) {
              $this->nota_fase_1 = $calificacionFase['calificacion'];
            } else {
              $this->nota_fase_2 = $calificacionFase['calificacion'];
            }
          }
          $this->save();
        }
      }

      // remove data from inscripcion
      $this->delete('inscripcion');
      // remove data from notas_integrante_proyecto
      $this->delete('notas_integrante_proyecto');
      // remove data from integrante_proyecto
      $this->delete('integrante_proyecto');
      // remove data from proyecto
      $this->delete('proyecto');

      parent::commit();
      return '';
    } catch (Exception $e) {
      parent::rollBack();
      $this->error = [
        'code' => $e->getCode(),
        'message' => $e->getMessage(),
        'stackTrace' => $e->getTraceAsString()
      ];
      return '';
    }
  }

  /**
   * Obtiene los integrantes de un proyecto
   *
   * @param [int] $id - ID de proyecto
   * @return array retorna vacio si no tiene integrantes
   */
  function obtenerIntegrantes(int $id): array
  {
    $integrantes = $this->select('detalles_integrantes', [['proyecto_id', '=', $id]]);
    return !$integrantes ? [] : $integrantes;
  }

  public function save()
  {
    $data = [];

    foreach ($this->fillable as $key => $value) {
      if (isset($this->{$value})) {
        if (is_string($this->{$value})) {
          $data[$value] = '"' . $this->{$value} . '"';
        } else {
          $data[$value] =  $this->{$value};
        }
      }
    }

    $this->set('proyecto_historico', $data);
    return true;
  }

  function findStudentGrades(int $cedula): array
  {
    $notas = $this->select('detalles_notas_baremos', [['cedula', '=', $cedula]]);
    return !$notas ? [] : $notas;
  }
}
