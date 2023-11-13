<?php

namespace Controllers;

use Symfony\Component\HttpFoundation\Request;

use Model\estudiante;
use Model\usuario;
use Model\persona;
use Traits\Utility;
use Exception;
use Utils\DateValidator;
use Utils\Sanitizer;
use Dompdf\Dompdf;

use PHPUnit\Framework\MockObject\DuplicateMethodException;

use function PHPUnit\Framework\isEmpty;

class estudianteController extends controller
{

  use Utility;

  private $estudiante;
  private $usuario;
  private $persona;

  function __construct()
  {
    $this->tokenExist();
    $this->estudiante = new estudiante();
    $this->usuario = new usuario();
    $this->persona = new persona();
  }

  public function index()
  {

    $estudiantes = $this->estudiante->all();

    return $this->view('estudiantes/gestionar', [
      'estudiante' => $estudiantes,
    ]);
  }

  public function store(Request $newestudiante)
  {
    try {
      // DateValidator::checkPeriodDates($newestudiante->get('fecha_inicio'), $newestudiante->get('fecha_cierre'));

      // creación de usuario
      $email = $newestudiante->request->get('email');
      $contrasena = $newestudiante->request->get('cedula');
     // var_dump($contrasena);

      // encriptar contraseña de usuario
      $contrasena = password_hash($contrasena, PASSWORD_DEFAULT);

      $this->usuario->setUsuario([
        'rol_id' => 4, // estudiantes
        'email' => $email,
        'contrasena' => $contrasena
      ]);

      $idUsuario = $this->usuario->save();

      // creacion de persona

      $cedula = $newestudiante->request->get('cedula');
      $usuario_id = $idUsuario;
      $nombre = $newestudiante->request->get('nombre');
      $apellido = $newestudiante->request->get('apellido');
      $direccion = $newestudiante->request->get('direccion');
      $telefono = $newestudiante->request->get('telefono');


      $this->persona->setPersona([
        'cedula' => $cedula,
        'usuario_id' => $usuario_id,
        'nombre' => $nombre,
        'apellido' => $apellido,
        'direccion' => $direccion,
        'telefono' => $telefono,
      ]);

      $idPersona = $this->persona->save();

      $this->estudiante->setestudiante(['persona_id' => $idPersona]);
      $this->estudiante->setestudianteId();
      $idestudiante = $this->estudiante->save();


      http_response_code(200);
      echo json_encode($idestudiante);
    } catch (Exception $e) {
      http_response_code(500);
      echo json_encode($e->getMessage());
    }
  }

  function showDetails(Request $estudiante): void
  {
    try {
      // verificar datos de usuario
      $idUsuario = $_SESSION['usuario_id'];
      $usuario = $this->usuario->find($idUsuario);
      if ($usuario['rol_id'] != 1) {
        throw new Exception('No cuenta con los permisos necesarios');
      }

      $codigoestudiante = $estudiante->request->get('codigo');

      $estudiante = $this->estudiante->find($codigoestudiante);
      $telefono = $this->desencriptar($estudiante['telefono']);
      $direccion = $this->desencriptar($estudiante['direccion']);

      http_response_code(200);
      echo json_encode([
        'telefono' => $telefono,
        'direccion' => $direccion
      ]);
    } catch (Exception $e) {
      http_response_code(500);
      echo json_encode($e->getMessage());
    }
  }

  public function notePDF(Request $request, $id)
  {
    try {
      $date = date('d-m-Y');
      $estudiante =  $this->estudiante->findNotesByStudents($id);
      if (isEmpty($estudiante)) {
        echo json_encode('No hay notas de estudiantes');
        exit();
      }
      $fase = $estudiante[0]["fase_id"];
      $nombre_fase = $estudiante[0]["nombre_fase"];
      $cedula = $estudiante[0]["cedula"];
      $nombre = $estudiante[0]["nombre"];
      $apellido = $estudiante[0]["apellido"];
      $proyecto_nombre = $estudiante[0]["proyecto_nombre"];
      $ponderado = $estudiante[0]["ponderado"];
      $calificacion = $estudiante[0]["calificacion"];
      $url =  "data:image/png;base64," . APP_URL . 'assets/img/illustrations/logoUptaeb.png';
      $imagen = '<img src="' . $url . '" height="60">';
      $name_comprobante = 'Calificacion';
      $dompdf = new Dompdf();
      $html = '<!DOCTYPE html>
      <html lang="es">
      
      <head>
          <meta charset="UTF-8">
      
          <title>Reporte de Ventas</title>
          <link rel="stylesheet" href="{{link_css}}">
      </head>
      
      <body>
          <div class="container">
              <table style="padding-bottom: 12px; padding-top: 10px;">
                  <thead>
                      <tr>
                      ' . $imagen . '
                          <th align="left">PNFI</th>
                          <th align="center" style="font-size: 18px;">Notas del estudiante : ' . $nombre . ' ' . $apellido . '</th>
                          <th align="right">' . $date . '</th>
                      </tr>
                  </thead>
              </table>
      
              <table class="tablepe">
                  <thead>
                      <tr class="body">
                          <th class="center th" width="5%">Fase</th>
                          <th class="center th" width="6%">Nombre fase</th>
                          <th class="center th" width="8%">Proyecto</th>
                          <th class="center th" width="5%">Cedula</th>
                          <th class="center th" width="10%">Nombre</th>
                          <th class="center th" width="8%">Puntos</th>
                      </tr>
                  </thead>
                    <tbody>
                      <tr>
                         <td class="center" style="font-size: 14px;">' . $fase . '</td>
                         <td class="center" style="font-size: 14px;">' . $nombre_fase . '</td>
                         <td class="center" style="font-size: 14px;">' . $proyecto_nombre . '</td>
                         <td class="center" style="font-size: 14px;">' . $cedula . '</td>
                         <td class="center" style="font-size: 14px;">' . $nombre . ' ' . $apellido . '</td>
                         <td class="center" style="font-size: 14px;">' . $ponderado . '/' . $calificacion . '</td>
                       </tr>
                    </tbody>
                /table>
      
          </div>
      
      </body>
      <style>
          html {
              margin-left: 22px;
              margin-right: 22px;
              margin-top: 28px;
              margin-bottom: 28px;
          }
      
          *,
          ::before,
          ::after {
              margin: 0px;
              padding: 0px;
              box-sizing: border-box;
          }
      
          body {
              font-size: 12px;
              font-weight: 400;
              color: #212529;
          }
      
          body,
          html {
              font-family: sans-serif;
          }
      
          table {
              width: 100%;
          }
      
          /* table {
              display: table;
              border-collapse: collapse;
              border-color: grey;
            } */
      
          .th {
              font-size: 14px;
              color: #fff;
              line-height: 1.4;
              background-color: #005abd;
              /*#6c7ae0 */
              padding-top: 10px;
              padding-bottom: 10px;
          }
      
          .head {
              /* padding-top: 12px;
          padding-bottom: 12px; */
          }
      
          .center {
              text-align: center;
          }
      
          p {
              margin-top: 0;
              margin-bottom: 0;
          }
      
          ul {
              list-style-type: none;
          }
      
          .tablepe>tr:nth-child(even) {
              background-color: #f8f6ff;
          }
      
          .tablepe {
              /* border: 1px solid black;*/
              border-collapse: collapse;
          }
      
          .body>th {
              /*  border: 1px solid rgb(49, 49, 49);*/
              border: 1px solid rgb(29, 29, 29);
              /*#6c7ae0*/
          }
      
          .body>td {
              border: 1px solid rgb(29, 29, 29);
          }
      </style>
      
      </html>';
      $dompdf->loadHtml(utf8_decode($html));
      $dompdf->render();
      $dompdf->stream($name_comprobante, array("Attachment" => false));
      http_response_code(200);
      echo json_encode($id);
    } catch (Exception $e) {
      http_response_code(500);
      echo json_encode($e->getMessage());
    }
  }

  
    /**
     * Obtiene la informacion necesaria para crear
     * formulario de update retornado en formato JSON
     *
     * @param [type] $request
     * @return void
     */
    function edit($request): void
    {
        try {
            $data = [];
            $cedula = $request->get('cedula');
            $estudiante = $this->estudiante->findByCedulaQuery($cedula);
            $data['estudiante'] = $estudiante->fillable;
            http_response_code(200);
            echo json_encode($data);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    public function update($request)
    {
        try {

            $cedula = $request->get('cedula');
            $nombre = $request->get('nombre');
            $apellido = $request->get('apellido');
            $email = $request->get('email');
            $direccion = $request->get('direccion');
            $telefono = $request->get('telefono');
            if (!$estudiante = $this->estudiante->findByCedulaQuery($cedula)) {
                return $this->page('errors/404');
            };
            // asignar valores de seccion
            $estudiante->updateStudent($nombre,$apellido,$email,$direccion,$telefono,$cedula);
            if (empty($cedula)) throw new Exception('Error inesperado al actualizar el estudiante.');
            http_response_code(200);
            echo json_encode($cedula);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }
  function ssp(Request $query): void
  {
    try {
      http_response_code(200);
      echo json_encode($this->estudiante->generarSSP());
    } catch (Exception $e) {
      http_response_code(500);
      echo json_encode($e->getMessage());
    }
  }

  public function E501()
  {

    return $this->page('errors/501');
  }
}
