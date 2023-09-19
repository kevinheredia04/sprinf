<?php

namespace App\controllers;

use App\permisos;
use App\periodo;
use App\proyectoHistorico;
use App\materias;
use App\trayectos;
use App\proyecto;
use App\controllers\controller;
use Exception;
use Symfony\Component\HttpFoundation\Request;

class configuracionController extends controller
{
  public $materias;
  public $proyectoHistorico;
  public $permisos;
  public $trayecto;
  public $proyectos;
  public $periodo;

  function __construct()
  {
    $this->proyectoHistorico = new proyectoHistorico();
    $this->materias = new materias();
    $this->periodo = new periodo();
    $this->permisos = new permisos();
    $this->proyectos = new proyecto();
    $this->trayecto = new trayectos();
  }

  function periodo()
  {
    $pendientes = $this->proyectos->pendientesACerrar();
    return $this->view('configuracion/periodo', [
      'cerrarFase' => empty($pendientes),
    ]);
  }

  function cerrarPeriodo(Request $nuevoPeriodo): void
  {
    try {
      // verificar que no haya proyectos por evaluar
      $pendientes = $this->proyectos->pendientesACerrar();

      if (!empty($pendientes)) throw new Exception('Hay proyectos pendientes por cerrar');

      $fecha_inicio = $nuevoPeriodo->get('fecha_inicio');
      $fecha_cierre = $nuevoPeriodo->get('fecha_cierre');

      // iniciar transaccion que envia información al historico
      $this->proyectoHistorico->historicalTransaction();

      // actualizar periodo de trayecto
      $this->periodo->setData($nuevoPeriodo->request->all());
      $this->periodo->save(1); // update first record

      http_response_code(200);
      echo json_encode(true);
    } catch (Exception $e) {
      http_response_code(500);
      echo json_encode(false);
    }
  }
}
