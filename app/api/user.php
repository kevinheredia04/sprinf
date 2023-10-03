<?php

namespace API;

use App\usuario;
use App\controllers\controller;
use App\Traits\Utility;

use Firebase\JWT\JWT;

use Symfony\Component\HttpFoundation\Request;

class user extends controller
{

  use Utility;

  public $usuarios;

  function __construct()
  {
    $this->usuarios = new usuario();
  }

  function show(Request $credenciales): void
  {
    try {
      if ($user = $this->obtenerTokenJWT()) {

        $infoUsuario = $this->usuarios->find($user->data->id);

        echo json_encode($infoUsuario);
      }
    } catch (\Exception $th) {
      http_response_code(500);
      echo json_encode($th->getMessage());
    }
  }
}