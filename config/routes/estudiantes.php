<?php

use Symfony\Component\Routing\Route;
use Controllers\estudianteController;

$listaDeRutas['estudiante_manage'] =  new Route(

  '/estudiantes',
  [
    'controller' => estudianteController::class,
    'method' => 'index',
  ]
);

$listaDeRutas['estudiante_edit'] =  new Route(

  '/estudiantes/edit/{id}',
  [
    'controller' => estudianteController::class,
    'method' => 'edit',
  ]
);

$listaDeRutas['/estudiantes/guardar'] =  new Route(

  '/estudiantes/guardar',
  [
    'controller' => estudianteController::class,
    'method' => 'store',
  ]
);

$listaDeRutas['estudiante_ssp'] =  new Route(

  '/estudiantes/ssp',
  [
    'controller' => estudianteController::class,
    'method' => 'ssp',
  ]
);

$listaDeRutas['notas_estudiante'] =  new Route(

  '/notes/pdf/{id}',
  [
    'controller' => estudianteController::class,
    'method' => 'notePDF',
  ]
);
