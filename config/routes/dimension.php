<?php

use Symfony\Component\Routing\Route;
use Controllers\dimensionController;


$listaDeRutas['dimension_edit'] = new Route(

  '/dimensiones/obtener/{id}',
  [
    'controller' => dimensionController::class,
    'method' => 'obtener',
  ]
);

$listaDeRutas['dimension_delete'] = new Route(

  '/dimensiones/borrar',
  [
    'controller' => dimensionController::class,
    'method' => 'borrar',
  ]
);

$listaDeRutas['/dimensiones/guardar'] = new Route(

  '/dimensiones/guardar',
  [
    'controller' => dimensionController::class,
    'method' => 'store',
  ]
);
$listaDeRutas['/dimensiones/actualizar'] = new Route(

  '/dimensiones/actualizar',
  [
    'controller' => dimensionController::class,
    'method' => 'update',
  ]
);

$listaDeRutas['dimensiones/ssp/{codigoMateria}'] = new Route(

  '/dimensiones/ssp/{codigoMateria}',
  [
    'controller' => dimensionController::class,
    'method' => 'ssp',
  ]
);

$listaDeRutas['dimension_manage'] = new Route(

  '/dimensiones/{codigoMateria}',
  [
    'controller' => dimensionController::class,
    'method' => 'index',
  ]
);
