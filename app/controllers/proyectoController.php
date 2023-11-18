<?php

namespace Controllers;

use Symfony\Component\HttpFoundation\Request;
use Model\proyectoHistorico;
use Model\proyecto;
use Model\profesor;
use Model\periodo;
use Model\consejoComunal;
use Model\estudiante;
use Model\inscripcion;
use Model\baremos;
use Model\fase;
use Model\dimension;
use Model\tutor;
use Model\parroquia;
use Model\trayectos;
use Dompdf\Dompdf;

use Traits\Excel;

use Exception;
use PDOException;

class proyectoController extends controller
{
    use Excel;

    public $proyectoHistorico;
    public $proyecto;
    private $estudiantes;
    private $dimension;
    private $tutores;
    private $profesores;
    private $baremos;
    private $fase;
    private $periodo;
    private $trayectos;
    private $inscripcion;
    private $parroquia;
    private $consejoComunal;

    function __construct()
    {
        $this->proyectoHistorico = new proyectoHistorico();

        $this->tokenExist();
        $this->proyecto = new proyecto();
        $this->estudiantes = new estudiante();
        $this->parroquia = new parroquia();
        $this->consejoComunal = new consejoComunal();
        $this->dimension = new dimension();
        $this->tutores = new tutor();
        $this->profesores = new profesor();
        $this->trayectos = new trayectos();
        $this->baremos = new baremos();
        $this->fase = new fase();
        $this->periodo = new periodo();
        $this->inscripcion = new inscripcion();
    }

    public function index()
    {

        $proyectos = $this->proyecto->all();
        $pendientes = $this->proyecto->pendientesACerrar();
        $tutores = $this->tutores->all();
        $profesores = $this->profesores->all();
        $trayectos = $this->trayectos->all();
        $parroquias = $this->parroquia->allDetalles();
        $consejosComunales = $this->consejoComunal->allDetalles();

        $fases = $this->fase->getPrimerFaseDeTrayectos();

        $periodo = $this->periodo->get();

        $historicoEstudiantes = $this->historicoEstudiantes();
        $historicoProyectos = $this->historicoProyecto();

        $listaEstudiantes = $this->estudiantes->pendientesAProyecto();

        $dataEstudiantes = [];
        if (isset($listaEstudiantes)) {

            foreach ($listaEstudiantes as $estudiante) {
                $info = [
                    'nombre' => $estudiante['cedula'] . ' - ' . $estudiante['nombre'] . ' ' . $estudiante['apellido'],
                    'value' => $estudiante['cedula']
                ];
                array_push($dataEstudiantes, $info);
            }
        }

        // echo json_encode($listaEstudiantes);
        // exit();

        return $this->view('proyectos/gestionar', [
            'proyectos' => $proyectos,
            'parroquias' => $parroquias,
            'consejosComunales' => $consejosComunales,
            'periodo' => $periodo,
            'profesores' => $profesores,
            'fases' => $fases,
            'cerrarFase' => empty($pendientes) && !empty($proyectos),
            'tutores' => $tutores,
            'trayectos' => $trayectos,
            'historicoProyectos' => $historicoProyectos,
            'historicoEstudiantes' => $historicoEstudiantes,
            'listaEstudiantes' => $listaEstudiantes,
            'estudiantes' => $dataEstudiantes,
        ]);
    }

    function historicoProyecto(): array
    {

        $historico = $this->proyectoHistorico->obtenerPendienteReingreso();

        if (!$historico) return [];

        $group = [];
        foreach ($historico as $item) {

            if (!isset($group[$item['id_proyecto']])) {
                if (!isset($group[$item['id_proyecto']])) {
                    $group[$item['id_proyecto']] = [];
                    $group[$item['id_proyecto']]['id'] = $item['id_proyecto'];
                    $group[$item['id_proyecto']]['display'] = '<b>' . $item['periodo_inicio'] . '</b> - ' . $item['nombre_proyecto'];
                    $group[$item['id_proyecto']]['nombre'] = $item['nombre_proyecto'];
                    $group[$item['id_proyecto']]['comunidad'] = $item['comunidad'];
                    $group[$item['id_proyecto']]['nombre_trayecto'] = $item['nombre_trayecto'];
                    $group[$item['id_proyecto']]['tutor_in'] = $item['tutor_in'];
                    $group[$item['id_proyecto']]['tutor_ex'] = $item['tutor_ex'];
                    $group[$item['id_proyecto']]['tlf_tex'] = $item['tlf_tex'];
                    $group[$item['id_proyecto']]['resumen'] = $item['resumen'];
                    $group[$item['id_proyecto']]['motor_productivo'] = $item['motor_productivo'];
                    $group[$item['id_proyecto']]['direccion'] = $item['direccion'];
                    $group[$item['id_proyecto']]['consejo_comunal_id'] = $item['consejo_comunal_id'];
                    $group[$item['id_proyecto']]['parroquia_id'] = $item['parroquia_id'];
                    $group[$item['id_proyecto']]['codigo_trayecto'] = $item['codigo_trayecto'];
                    $group[$item['id_proyecto']]['codigo_siguiente_trayecto'] = $item['codigo_siguiente_trayecto'];
                }
            }
        }

        return $group;
    }

    function historicoEstudiantes(): array
    {
        try {
            $historico = $this->proyectoHistorico->obtenerPendienteReingreso();

            $group = [];
            if (!$historico) return [];
            foreach ($historico as $item) {
                if (!isset($group[$item['id_proyecto']])) {
                    $group[$item['id_proyecto']] = [];
                    $group[$item['id_proyecto']]['id'] = $item['id_proyecto'];
                    $group[$item['id_proyecto']]['nombre'] = $item['nombre_proyecto'];
                    $group[$item['id_proyecto']]['nombre_trayecto'] = $item['nombre_trayecto'];
                    $group[$item['id_proyecto']]['periodo_inicio'] = $item['periodo_inicio'];
                }
                foreach ($item as $key => $value) {
                    if ($key == 'id_proyecto') continue;
                    $group[$item['id_proyecto']]['integrantes'][$item['cedula_estudiante']][$key] = $value;
                }
            }

            $response = [];

            foreach ($group as $key => $proyecto) {
                $integrantes = [];
                foreach ($proyecto['integrantes'] as $key => $value) {
                    $info = ['nombre' => $value['nombre_estudiante'] . ' - ' . $value['cedula_estudiante'], 'value' => $value['cedula_estudiante']];
                    $integrantes[] = (object)$info;
                    # code...
                }
                $informacionProyecto = [
                    'nombre' =>  '<b>' . $proyecto['periodo_inicio'] . ' - ' . $proyecto['nombre_trayecto'] . '</b>' . ' - ' . $proyecto['nombre'],
                    'integrantes' => $integrantes
                ];
                $response[] = (object)$informacionProyecto;
            }

            return $response;
        } catch (Exception $e) {
            return [];
        }
    }


    public function create()
    {
        $tutores = $this->tutores->all();
        $trayectos = $this->trayectos->all();

        return $this->view('proyectos/crear', [
            'tutores' => $tutores,
            'trayectos' => $trayectos
        ]);
    }

    public function store(Request $nuevoProyecto)
    {
        try {
            if (!array_key_exists('integrantes', $nuevoProyecto->request->all())) throw new Exception('No puede crear proyecto sin integrantes');
            $integrantes = $nuevoProyecto->request->all()['integrantes'];
            $fase = $nuevoProyecto->get('fase_id');
            $trayecto = $this->trayectos->findByFase($fase);
            // VALIDACIONES 

            $idEstudiantes = [];

            foreach ($integrantes as $cedula) {
                $dataEstudiante = $this->estudiantes->findByCedula($cedula);
                if (empty($dataEstudiante)) throw new Exception("Estudiante $cedula no existe");
                // VERIFICAR QUE UN ESTUDIANTE NO PERTENEZCA A OTRO GRUPO DE PROYECTO
                if ($dataEstudiante['proyecto_id'] != null) {
                    throw new Exception("Estudiante " . $dataEstudiante['nombre'] . " " . $dataEstudiante['apellido'] . " ya pertenece a un proyecto");
                }
                // VERIFICAR QUE UN ESTUDIANTE PERTENEZCA A LA FASE ESPECIFICADA EN LA CREACION DEL PROYECTO
                if (!is_null($dataEstudiante['trayecto_id']) && $dataEstudiante['trayecto_id'] != $trayecto['codigo_trayecto']) {
                    throw new Exception("Estudiante " . $dataEstudiante['nombre'] . " " . $dataEstudiante['apellido'] . " No pertenece al trayecto especificado en la creación del proyecto");
                }

                array_push($idEstudiantes, $dataEstudiante['id']);
            }

            $nombre = $nuevoProyecto->request->get('nombre');
            $comunidad = $nuevoProyecto->request->get('comunidad');
            $fase_id = $nuevoProyecto->request->get('fase_id');
            $estatus = $nuevoProyecto->request->get('estatus');
            $resumen = $nuevoProyecto->request->get('resumen');
            $direccion = $nuevoProyecto->request->get('direccion');
            $motor_productivo = $nuevoProyecto->request->get('motor_productivo');
            $consejo_comunal_id = $nuevoProyecto->request->get('consejo_comunal_id');
            $tutor_in = $nuevoProyecto->request->get('tutor_in');
            $tutor_ex = $nuevoProyecto->request->get('tutor_ex');
            $tlf_tex = $nuevoProyecto->request->get('tlf_tex');
            $observaciones = $nuevoProyecto->request->get('observaciones');
            $id = $nuevoProyecto->request->get('id');


            $comunidadAutonoma = $nuevoProyecto->request->get('comunidad_autonoma');

            $parroquia_id = $nuevoProyecto->request->get('parroquia_id');

            $proyectData = [
                'nombre' => $nombre,
                'comunidad' => $comunidad,
                'fase_id' => $fase_id,
                'estatus' => $estatus,
                'direccion' => $direccion,
                'resumen' => $resumen,
                'motor_productivo' => $motor_productivo,
                'consejo_comunal_id' => ($comunidadAutonoma == 1) ? null : $consejo_comunal_id,
                'tutor_in' => $tutor_in,
                'tutor_ex' => $tutor_ex,
                'parroquia_id' => $parroquia_id,
                'tlf_tex' => $tlf_tex,
                'observaciones' => $observaciones,
                'integrantes' => $idEstudiantes
            ];

            if (isset($id)) {
                $proyectData['id'] = $id;
            }

            $this->proyecto->setProyectData($proyectData);
            $result = $this->proyecto->insertTransaction();


            if (!$result) throw new Exception('Ha ocurrido un error al crear proyecto');

            http_response_code(200);
            echo json_encode('Proyecto creado exitosamente');
        } catch (Exception $e) {
            http_response_code(500);


            echo json_encode(['error' => [
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
                'stackTrace' => $e->getTraceAsString(),
                (isset($this->proyecto->error)) ? ['errorDetails' =>  $this->proyecto->error] : null
            ]]);
        }
    }

    function obtener(Request $request, $id): void
    {
        try {

            $idProyecto = trim($id);
            $proyecto = $this->proyecto->find($idProyecto);

            $integrantes = $this->proyecto->obtenerIntegrantes($idProyecto);

            http_response_code(200);
            echo json_encode([
                'proyecto' => $proyecto,
                'integrantes' => $integrantes
            ]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function update(Request $proyecto): void
    {
        try {
            if (!array_key_exists('integrantes', $proyecto->request->all())) throw new Exception('No puede crear proyecto sin integrantes');

            $id = $proyecto->request->get('id');
            $nombre = $proyecto->request->get('nombre');
            $comunidad = $proyecto->request->get('comunidad');
            $fase_id = $proyecto->request->get('fase_id');
            $estatus = $proyecto->request->get('estatus');
            $resumen = $proyecto->request->get('resumen');
            $direccion = $proyecto->request->get('direccion');
            $motor_productivo = $proyecto->request->get('motor_productivo');
            $consejo_comunal_id = $proyecto->request->get('consejo_comunal_id');
            $parroquia_id = $proyecto->request->get('parroquia_id');
            $tutor_in = $proyecto->request->get('tutor_in');
            $tutor_ex = $proyecto->request->get('tutor_ex');
            $tlf_tex = $proyecto->request->get('tlf_tex');

            $observaciones = $proyecto->request->get('observaciones');
            $cerrado = $proyecto->request->get('cerrado');


            $integrantes = $proyecto->request->all()['integrantes'];
            $idEstudiantes = [];

            foreach ($integrantes as $cedula) {
                $dataEstudiante = $this->estudiantes->findByCedula($cedula);
                array_push($idEstudiantes, $dataEstudiante['id']);
            }

            $comunidadAutonoma = $proyecto->request->get('comunidad_autonoma');

            $this->proyecto->setProyectData([
                'id' => $id,
                'nombre' => $nombre,
                'comunidad' => $comunidad,
                'fase_id' => $fase_id,
                'estatus' => $estatus,
                'direccion' => $direccion,
                'resumen' => $resumen,
                'motor_productivo' => $motor_productivo,
                'parroquia_id' => $parroquia_id,
                'consejo_comunal_id' => ($comunidadAutonoma == 1) ? null : $consejo_comunal_id,
                'tutor_in' => $tutor_in,
                'tlf_tex' => $tlf_tex,
                'tutor_ex' => $tutor_ex,
                'observaciones' => $observaciones,
                'cerrado' => $cerrado,
                'integrantes' => $idEstudiantes
            ]);
            $integrantes = $proyecto->request->all()['integrantes'];
            $this->proyecto->actualizar();


            $resultadoTransaccion = $this->proyecto->actualizarIntegrantes();

            if (!$resultadoTransaccion) {
                throw new Exception('No se pueden actualizar los integrantes a este proyecto', $this->proyecto->error['code']);
            }

            $informacionActualizada = $this->proyecto->find($id);
            $integrantesActualizados = $this->proyecto->obtenerIntegrantes($id);

            http_response_code(200);
            echo json_encode(['data' => ['proyecto' => $informacionActualizada, 'integrantes' => $integrantesActualizados]]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => [
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
                'stackTrace' => $e->getTraceAsString()
            ]]);
        }
    }

    function delete(Request $proyecto): void
    {
        try {
            $idProyecto = $proyecto->request->get('id');

            $verificarProyecto = $this->proyecto->find($idProyecto);

            if (!$verificarProyecto) throw new Exception('Proyecto no encontrado', 404);

            $resultado = $this->proyecto->remover($idProyecto);

            if (!$resultado) {
                throw new PDOException($this->proyecto->error['message'], $this->proyecto->error['code']);
            }

            http_response_code(200);
            echo json_encode(true);
        } catch (Exception $e) {
            http_response_code($e->getCode() ?? 500);
            echo json_encode(['error' => [
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
                'stackTrace' => $e->getTraceAsString()
            ]]);
        }
    }

    function pendingStudents(): void
    {
        try {
            $resultado = $this->estudiantes->pendientesAProyecto();

            if (!$resultado) {
                throw new PDOException($this->proyecto->error['message'], $this->proyecto->error['code']);
            }

            http_response_code(200);
            echo json_encode($resultado);
        } catch (Exception $e) {
            http_response_code($e->getCode() ?? 500);
            echo json_encode(['error' => [
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
                'stackTrace' => $e->getTraceAsString()
            ]]);
        }
    }

    function assessment(Request $request, $id)
    {

        // verificacion de datos de usuario
        $errors = [];
        try {
            $proyecto = $this->proyecto->find($id);
            $integrantes = $this->proyecto->findIntegrantes($id);

            if (empty($proyecto)) {
                throw new Exception('Proyecto no existe');
            }
            if (empty($integrantes)) {
                throw new Exception('Proyecto no cuenta con estudiantes');
            }

            $fase = $this->fase->find($proyecto['codigo_fase']);
            $materiasDeDimension = $this->dimension->materiasDeBaremos($proyecto['codigo_fase']);
            $baremos = [];
            $nuevoBaremos = [];

            if (empty($materiasDeDimension)) {
                throw new Exception('Baremos no cuenta con dimensiones');
            }

            foreach ($integrantes as $key => $integrante) {
                foreach ($materiasDeDimension as $key => $materia) {
                    $inscripcion = $this->inscripcion->usuarioCursaMateria($integrante['id'], $materia['codigo']);

                    if (empty($inscripcion)) {
                        if (!str_contains($materia['codigo'], 'ASESOR')) {
                            $errors['warning'][] = "Integrante " . $integrante['nombre'] . ' ' . $integrante['apellido'] . ' - ' . $integrante['cedula'] . " no está cursando la materia " . $materia['nombre'] . "";
                        } else {
                            // do nothing
                        }
                    } else {

                        if ($inscripcion['calificacion'] == null) {
                            // usuario no cuenta con calificación suficiente como para ser evaluado
                            $errors['danger'][] = "Integrante " . $integrante['nombre'] . ' ' . $integrante['apellido'] . ' - ' . $integrante['cedula'] . " no ha sido evaluado en la unidad curricular: " . $materia['nombre'] . "";
                        }
                    }
                }
            }


            foreach ($materiasDeDimension as $key => $materia) {
                $dimensiones = $this->dimension->findBySubject($materia['codigo']);

                $baremos[$materia['codigo']]['nombre'] = $materia['nombre'];

                $baremos[$materia['codigo']]['individual'] = [];
                $totalPonderado = 0;
                foreach ($dimensiones as $key => $dimension) {

                    $indicadores = $this->dimension->obtenerIndicadores($dimension['id']);

                    if (empty($indicadores)) {
                        $errors['danger'][] = 'Dimension ' . $dimension['nombre_materia'] . ' - ' . $dimension['nombre'] . ' no cuenta con indicadores!';
                    } else {
                        // configurar informacion de indicador
                        if ($dimension['grupal'] == 1) {
                            $baremos[$materia['codigo']]['grupal'][$dimension['id']]['nombre'] = $dimension['nombre'];
                            foreach ($indicadores as $key => $indicador) {
                                $totalPonderado += $indicador['ponderacion'];

                                $itemEstudiante = $this->baremos->findStudentItem($indicador['id'], $integrantes[0]['id']);
                                if (!empty($itemEstudiante)) $indicadores[$key]['calificacion'] = $itemEstudiante['calificacion'];
                            }
                            $baremos[$materia['codigo']]['grupal'][$dimension['id']]['indicadores'] = $indicadores;
                        } else {


                            // $baremos[$materia['codigo']]['dimension']['individual'][$dimension['id']]['nombre'] = $dimension['nombre'];
                            $dimension['indicadores'] = [];
                            foreach ($indicadores as $key => $indicador) {
                                $indicador['calificacion'] = [];
                                $totalPonderado += $indicador['ponderacion'];
                                foreach ($integrantes as $key => $integrante) {

                                    $itemEstudiante = $this->baremos->findStudentItem($indicador['id'], $integrante['id']);
                                    if (!empty($itemEstudiante)) $indicador['calificacion'][$integrante['id']] = $itemEstudiante['calificacion'];
                                }
                                array_push($dimension['indicadores'], $indicador);
                            }

                            array_push($baremos[$materia['codigo']]['individual'], $dimension);
                        }
                    }

                    // TODO CALCULAR TOTAL PONDERADO POR DIMENSION
                }
                $baremos[$materia['codigo']]['ponderado'] = $totalPonderado;
            }


            $infoProyecto = $this->proyecto->find($id);
            $infoIntegrantes = $this->proyecto->findIntegrantes($id);
            // echo json_encode($baremos);
            // exit();

            return $this->view('proyectos/assessment', [
                'proyecto_id' => $id,
                'infoProyecto' => $infoProyecto,
                'infoIntegrantes' => $infoIntegrantes,
                'fase' => $fase,
                'integrantes' => $integrantes,
                'baremos' => $baremos,
                'errors' => $errors,
            ]);
        } catch (Exception $e) {

            return $this->view('errors/501', [
                'message' => $e->getMessage() . ' ' . $e->getTraceAsString(),
            ]);
        }
    }

    function obtenerBaremos(Request $request, $codigo): void
    {
        $errors = [];
        try {
            $fases = $this->fase->getByTrayecto($codigo);
            $baremos = [];
            foreach ($fases as $fase) {

                $materiasDeDimension = $this->dimension->materiasDeBaremos($fase['codigo_fase']);

                if (empty($materiasDeDimension)) {
                    throw new Exception('Baremos no cuenta con dimensiones');
                }

                foreach ($materiasDeDimension as $materia) {
                    $dimensiones = $this->dimension->findBySubject($materia['codigo']);

                    $fase['materias'] = [];
                    $materia['infoDimensiones'] = [];

                    foreach ($dimensiones as $dimension) {

                        $indicadores = $this->dimension->obtenerIndicadores($dimension['id']);

                        if (empty($indicadores)) {
                            $errors['danger'][] = 'Dimension ' . $dimension['nombre_materia'] . ' - ' . $dimension['nombre'] . ' no cuenta con indicadores!';
                        } else {
                            // configurar informacion de indicador
                            $dimension['indicadores'] = $indicadores;
                            array_push($materia['infoDimensiones'], $dimension);
                        }
                    }
                    array_push($fase['materias'], $materia);
                }
                array_push($baremos, $fase);
            }

            echo json_encode($baremos);
        } catch (Exception $e) {

            http_response_code(500);
            echo json_encode(['error' => [
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
                'stackTrace' => $e->getTraceAsString()
            ]]);
        }
    }




    function evaluar(Request $request): void
    {
        try {
            // como gestionar las fases
            $proyectoId = $request->get('proyecto_id');
            $proyecto = $this->proyecto->find($proyectoId);
            $baremos = $this->baremos->findByFase($proyecto['fase_id']);

            $integrantes = $this->proyecto->obtenerIntegrantes($proyectoId);

            // verifica que todos los estudiantes hayan sido evaluados
            foreach ($integrantes as $integrante) {
                foreach ($baremos as $indicador) {
                    $calificacion = $this->baremos->findStudentItem($indicador['id'], $integrante['integrante_id']);
                    if (empty($calificacion)) throw new Exception("El integrante " . $integrante['nombre'] . " C.I. " . $integrante['cedula'] . " No ha sido evaluado en el item " . $indicador['nombre_indicador'] . " que pertenece a la dimension " . $indicador['nombre_dimension'] . " de la materia " . $indicador['nombre_materia']);
                }
            }

            // verificar si existe una siguiente fase

            $fase = $this->fase->find($proyecto['fase_id']);

            $msg = '';
            if ($fase['siguiente_fase']) {
                $infoSiguienteFase = $this->fase->find($fase['siguiente_fase']);
                $calificacionPorEvaluar = $infoSiguienteFase['ponderado_baremos'];

                foreach ($integrantes as $integrante) {

                    // verificar que el valor restante por evaluar sea el suficiente como para continuar

                    // obtener calificacion actual
                    $infoNotas = $this->baremos->findStudentBaremosGrades($integrante['integrante_id']);
                    $calificacionActual = $infoNotas['calificacion'];
                    // obtener calificacion por evaluar

                    // obtener calificacion minima de trayecto
                    $minimaTrayecto = $infoNotas['calificacion_minima_trayecto'];

                    // calcular si la sumatoria de los dos es igual o mayor a la minima por trayecto
                    $calculo = $calificacionActual + $calificacionPorEvaluar;
                    if ($calculo >= $minimaTrayecto) {
                        // estudiante ha aprobado
                        $this->proyecto->actualizarEstatusIntegrante($integrante['integrante_id'], 1);
                    } else {
                        // estudiante ha reprobado
                        $this->proyecto->actualizarEstatusIntegrante($integrante['integrante_id'], 0);
                    }
                }

                // actualizar proyecto
                $this->proyecto->actualizarFase($proyecto['id'], $fase['siguiente_fase']);
                $msg = 'Fase actualizada';
            } else {
                foreach ($integrantes as $integrante) {

                    $infoIntegrante = $this->proyecto->findIntegrante($integrante['integrante_id']);

                    $calificacionActual = $infoIntegrante['calificacion'];
                    $calificacionMinima = $infoIntegrante['calificacion_minima_trayecto'];

                    if ($calificacionActual >= $calificacionMinima) {
                        // estudiante aprobado|
                        $this->proyecto->actualizarEstatusIntegrante($integrante['integrante_id'], 1);
                    } else {
                        // estudiante reprobado
                        $this->proyecto->actualizarEstatusIntegrante($integrante['integrante_id'], 0);
                    }
                }
                $this->proyecto->cerrar($proyecto['id']);
                $msg = 'Proyecto cerrado';
            }

            http_response_code(200);
            echo json_encode($msg);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function subirNotas(Request $request): void
    {
        try {
            $proyectoId = $request->get('proyecto_id');
            // se recorreran todos los integrantes del proyecto
            $integrantes = $this->proyecto->obtenerIntegrantes($proyectoId);

            $indicadoresGrupales = $request->get('indicador_grupal');
            $indicadoresIndividuales = $request->get('indicador_individual');



            foreach ($integrantes as $integrante) {

                // indicadores grupales
                if (!empty($indicadoresGrupales)) {
                    foreach ($indicadoresGrupales as $id => $value) {
                        $value = floatval($value);
                        $this->baremos->evaluarIndicador($id, $integrante['integrante_id'], $value);
                    }
                }
                if (!empty($indicadoresIndividuales)) {
                    foreach ($indicadoresIndividuales[$integrante['integrante_id']] as $id => $value) {
                        $value = floatval($value);
                        print("Evaluar " . $integrante['integrante_id'] . ' VALUE: ' . $value);
                        $this->baremos->evaluarIndicador($id, $integrante['integrante_id'], $value);
                    }
                }
            }

            http_response_code(200);
            echo json_encode(true);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function reprobados(Request $query, $idProyecto): void
    {
        try {
            http_response_code(200);
            echo json_encode($this->proyecto->findIntegrantesReprobados($idProyecto));
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function aprobar(Request $integrantes): void
    {
        try {
            $integrantes = $integrantes->request->all()['integrantes'];
            foreach ($integrantes as $integrante) {
                if (isset($integrante['aprueba'])) {
                    $this->proyecto->actualizarEstatusIntegrante($integrante['id'], $integrante['aprueba']);
                }
            }
            http_response_code(200);
            echo json_encode(true);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => [
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
                'stackTrace' => $e->getTraceAsString()
            ]]);
        }
    }

    function ssp(Request $query): void
    {
        try {
            http_response_code(200);
            echo json_encode($this->proyecto->generarSSP());
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function exportExcel(Request $request): void
    {
        try {
            $trayectoId = $request->get('trayecto_id');

            $proyectos = $this->proyecto->all();


            foreach ($proyectos as $key => $proyecto) {
                $integrantes = $this->proyecto->obtenerIntegrantes($proyecto['id']);

                $proyectos[$key]['integrantes'] = $integrantes;
                # code...
            }

            if (!$integrantes) throw new Exception('No hay integrantes en el trayecto seleccionado', 400);

            $this->reporteProyectos($proyectos);
            http_response_code(200);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    public function E501()
    {

        return $this->page('errors/501');
    }

    public function noteProyectPDF(Request $request, $id)
    {
        try {
            $date = date('d-m-Y');
            $notas = $this->proyecto->NotasIntegrastesProyecto($id);

            $url =  "data:image/png;base64," . APP_URL . 'assets/img/illustrations/logoUptaeb.png';
            $imagen = '<img src="' . $url . '" height="60">';
            $name_comprobante = 'Calificacion grupal';
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
                    <thead class="thead-dark">
                        <tr>
                            <th align="left">PNFI</th>
                            <th align="center" style="font-size: 18px;">Notas por equipo </th>
                            <th align="right">' . $date . '</th>
                        </tr>
                    </thead>
                </table>
        
                <table class="tablepe">
                    <thead class="thead-dark">
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
                        <tr>';


            $concat = '';

            foreach ($notas as $student) {

                //Concatenamos las tablas en una variable, también podriamos hacer el "echo" directamente
                $concat .= '<tr>';

                $concat .= '<td  class="center" style="font-size: 14px;">' . $student['fase_id'] . '</td>';
                $concat .= '<td  class="center" style="font-size: 14px;">' . $student['nombre_fase'] . '</td>';
                $concat .= '<td  class="center" style="font-size: 14px;">' . $student['proyecto_nombre'] . '</td>';
                $concat .= '<td  class="center" style="font-size: 14px;">' . $student['cedula'] . '</td>';
                $concat .= '<td  class="center" style="font-size: 14px;">' . $student['nombre'] . ' ' . $student['apellido'] . '</td>';
                $concat .= '<td  class="center" style="font-size: 14px;">' . $student['ponderado'] . '/' . $student['calificacion'] . '</td>';
                $concat .= '</tr>';
            }

            $concat;

            $html2 = '</tr>
                      </tbody>
                      </table>
        
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
            $render = iconv('UTF-8', 'ISO-8859-1//TRANSLIT', $html . $concat . $html2);
            //var_dump($render);exit();
            $dompdf->loadHtml($render);
            $dompdf->render();
            $dompdf->stream($name_comprobante, array("Attachment" => false));
            http_response_code(200);
            echo json_encode($id);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }
}
