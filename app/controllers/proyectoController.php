<?php

namespace App\controllers;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Bcrypt\Bcrypt;

use App\proyecto;
use App\estudiante;
use App\inscripcion;
use App\fase;
use App\dimension;
use App\tutor;
use App\trayectos;
use Exception;
use PDOException;

class proyectoController extends controller
{

    public $proyecto;
    private $estudiantes;
    private $dimension;
    private $tutores;
    private $fase;
    private $trayectos;
    private $inscripcion;

    function __construct()
    {
        $this->proyecto = new proyecto();
        $this->estudiantes = new estudiante();
        $this->dimension = new dimension();
        $this->tutores = new tutor();
        $this->trayectos = new trayectos();
        $this->fase = new fase();
        $this->inscripcion = new inscripcion();
    }

    public function index()
    {

        $proyectos = $this->proyecto->all();

        $tutores = $this->tutores->all();

        $fases = $this->fase->getPrimerFaseDeTrayectos();



        return $this->view('proyectos/gestionar', [
            'proyectos' => $proyectos,
            'fases' => $fases,
            'tutores' => $tutores
        ]);
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

            foreach ($integrantes as $codigoEstudiante) {
                $dataEstudiante = $this->estudiantes->find($codigoEstudiante);
                // VERIFICAR QUE UN ESTUDIANTE NO PERTENEZCA A OTRO GRUPO DE PROYECTO
                if ($dataEstudiante['proyecto_id'] != null) {
                    throw new Exception("Estudiante " . $dataEstudiante['nombre'] . " " . $dataEstudiante['apellido'] . " ya pertenece a un proyecto");
                }
                // VERIFICAR QUE UN ESTUDIANTE PERTENEZCA A LA FASE ESPECIFICADA EN LA CREACION DEL PROYECTO
                if (!is_null($dataEstudiante['trayecto_id']) && $dataEstudiante['trayecto_id'] != $trayecto['codigo_trayecto']) {
                    throw new Exception("Estudiante " . $dataEstudiante['nombre'] . " " . $dataEstudiante['apellido'] . " No pertenece al trayecto especificado en la creación del proyecto");
                }
            }

            $this->proyecto->setProyectData($nuevoProyecto->request->all());
            $this->proyecto->insertTransaction();

            http_response_code(200);
            echo json_encode($this->proyecto);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function pendingStudents(Request $request): void
    {
        try {
            $idFase = $request->get('idFase');
            $trayecto = $this->trayectos->findByFase($idFase);

            $estudiantes = $this->estudiantes->listPendingForProject($trayecto['codigo_trayecto']);

            http_response_code(200);
            echo json_encode($estudiantes);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    public function show(Request $request, $id)
    {
        try {
            $proyecto = $this->proyecto->find($id);
            $estudiantes = $this->estudiantes->byProject($id);

            return $this->view('proyectos/show', [
                'proyecto' => $proyecto,
                'estudiantes' => $estudiantes
            ]);
        } catch (PDOException $pdoe) {
            return $this->view('errors/501', [
                'message' => 'Error inesperado',
            ]);
        } catch (Exception $e) {
            return $this->view('errors/501', [
                'message' => $e->getMessage(),
            ]);
        }
    }

    public function edit(Request $request, $id)
    {
        try {

            $proyecto = $this->proyecto->find($id);
            $estudiantesPendientes = $this->estudiantes->listPendingForProject();
            $estudiantes = $this->estudiantes->byProject($id);
            $tutores = $this->tutores->all();
            $trayectos = $this->trayectos->all();


            return $this->view('proyectos/edit', [
                'proyecto' => $proyecto,
                'estudiantes' => $estudiantes,
                'estudiantesPendientes' => $estudiantesPendientes ?? [],
                'tutores' => $tutores,
                'trayectos' => $trayectos
            ]);
        } catch (PDOException $pdoe) {
            return $this->view('errors/501', [
                'message' => 'Error inesperado',
            ]);
        } catch (Exception $e) {
            return $this->view('errors/501', [
                'message' => $e->getMessage(),
            ]);
        }
    }

    function update(Request $proyecto): void
    {
        try {
            if (!array_key_exists('estudiantes', $proyecto->request->all())) throw new Exception('No puede crear proyecto sin integrantes');

            $estudiantes = $proyecto->request->all()['estudiantes'];
            $idProyecto = $proyecto->request->get('id');

            $this->proyecto->setProyectData($proyecto->request->all());
            $this->proyecto->save($idProyecto);

            $estudiantes = $proyecto->request->all()['estudiantes'];
            $this->proyecto->updateTeam($idProyecto, $estudiantes);

            http_response_code(200);
            echo json_encode($this->proyecto);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function delete(Request $proyecto): void
    {
        try {

            $idProyecto = $proyecto->request->get('id');

            $this->proyecto->remove($idProyecto);

            http_response_code(200);
            echo json_encode($this->proyecto);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode($e->getMessage());
        }
    }

    function assessment(Request $request, $id)
    {
        // verificacion de datos de usuario
        $errors = [];
        try {
            $proyecto = $this->proyecto->find($id);
            $integrantes = $this->proyecto->obtenerIntegrantes($id);

            if (empty($proyecto)) {
                throw new Exception('Proyecto no existe');
            }
            if (empty($integrantes)) {
                throw new Exception('Proyecto no cuenta con estudiantes');
            }

            $fase = $this->fase->find($proyecto['codigo_fase']);
            $materiasDeDimension = $this->dimension->materiasDeBaremos($proyecto['codigo_fase']);
            $baremos = [];
            $indicadoresIndividuales = [];

            if (empty($materiasDeDimension)) {
                throw new Exception('Baremos no cuenta con dimensiones');
            }

            foreach ($integrantes as $key => $integrante) {
                foreach ($materiasDeDimension as $key => $materia) {
                    $inscripcion = $this->inscripcion->usuarioCursaMateria($integrante['estudiante_id'], $materia['codigo']);

                    if (empty($inscripcion)) {
                        $errors['warning'][] = "Integrante " . $integrante['nombre'] . ' - ' . $integrante['cedula'] . " no está cursando la materia " . $materia['nombre'] . "";
                    } else {

                        if ($inscripcion['calificacion'] == null) {
                            // usuario no cuenta con calificación suficiente como para ser evaluado
                            $errors['danger'][] = "Integrante " . $integrante['nombre'] . ' - ' . $integrante['cedula'] . " no ha sido evaluado en la unidad curricular: " . $materia['nombre'] . "";
                        }
                    }
                }
            }

            foreach ($materiasDeDimension as $key => $materia) {
                $dimensiones = $this->dimension->findBySubject($materia['codigo']);

                $baremos[$materia['codigo']]['nombre'] = $materia['nombre'];

                foreach ($dimensiones as $key => $dimension) {

                    $indicadores = $this->dimension->obtenerIndicadores($dimension['id']);

                    if (empty($indicadores)) {
                        $errors['danger'][] = 'Dimension ' . $dimension['nombre_materia'] . ' - ' . $dimension['nombre'] . ' no cuenta con indicadores!';
                    } else {
                        // configurar informacion de indicador
                        if ($dimension['grupal'] == 1) {
                            $baremos[$materia['codigo']]['dimension']['grupal'][$dimension['id']]['nombre'] = $dimension['nombre'];
                            $baremos[$materia['codigo']]['dimension']['grupal'][$dimension['id']]['indicadores'] = $indicadores;
                        } else {
                            $baremos[$materia['codigo']]['dimension']['individual'][$dimension['id']]['nombre'] = $dimension['nombre'];
                            $baremos[$materia['codigo']]['dimension']['individual'][$dimension['id']]['indicadores'] = $indicadores;
                        }
                    }
                }
            }


            return $this->view('proyectos/assessment', [
                'fase' => $fase,
                'integrantes' => $integrantes,
                'baremos' => $baremos,
                'errors' => $errors,
            ]);
        } catch (Exception $e) {
            return $this->view('errors/501', [
                'message' => $e->getMessage(),
            ]);
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

    public function E501()
    {

        return $this->page('errors/501');
    }
}
