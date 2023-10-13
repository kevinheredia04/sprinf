<?php

namespace App;

use App\model;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Bcrypt\Bcrypt;

use Exception;

class estudiante extends model
{

    public $fillable = [
        'nombre',
        'apellido',
        'cedula',
        'direccion',
        'telefono',
        'nacimiento',
        'estatus'
    ];

    public function all()
    {
        try {
            $estudiantes = $this->select('detalles_estudiantes');
            return $estudiantes ? $estudiantes : null;
        } catch (Exception $th) {
            return $th;
        }
    }

    /**
     * Obtener información del estudiante
     *
     * @param string $id
     * @return array
     */
    function find(string $id): array
    {
        $proyectos = $this->selectOne("detalles_estudiantes", [['id', '=', "'" . $id . "'"]]);
        return !$proyectos ? [] : $proyectos;
    }

    public function listPendingForProject(string $codigoTrayecto)
    {
        try {
            $estudiantes = $this->select('detalles_estudiantes', [['id', 'NOT IN', '(SELECT estudiante_id FROM integrante_proyecto)'], ['trayecto_id', '=', '"' . $codigoTrayecto . '"']]);
            return $estudiantes ? $estudiantes : null;
        } catch (Exception $th) {
            return $th;
        }
    }


    public function byProject($id)
    {
        try {
            $estudiantes = $this->querys("SELECT estudiante_proyecto.id, estudiante_proyecto.estudiante_id, persona.nombre, persona.apellido, persona.cedula FROM estudiante_proyecto LEFT JOIN estudiante ON estudiante.id = estudiante_proyecto.estudiante_id LEFT JOIN persona ON persona.cedula = estudiante.persona_id WHERE estudiante_proyecto.proyecto_id = $id");
            return $estudiantes ? $estudiantes : null;
        } catch (Exception $th) {
            return $th;
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
                'db'        => 'cedula',
                'dt'        => 0
            ),
            array(
                'db'        => 'nombre',
                'dt'        => 1
            ),
            array(
                'db'        => 'apellido',
                'dt'        => 2
            ),
            array(
                'db'        => 'email',
                'dt'        => 3
            ),
            array(
                'db'        => 'telefono',
                'dt'        => 4
            )
        );
        return $this->getSSP('detalles_estudiantes', 'cedula', $columns);
    }

       /**
     * Obtener información del las notas del estudiante
     *
     * @param string $id
     * @return array
     */
    function findNotesByStudents(string $cedula): array
    {
        try {
            $notas = $this->querys("SELECT detalles_notas_baremos.fase_id,detalles_notas_baremos.nombre_fase, detalles_notas_baremos.cedula,detalles_notas_baremos.ponderado,detalles_notas_baremos.calificacion,
            persona.nombre, persona.apellido, proyecto.nombre as proyecto_nombre 
            FROM detalles_notas_baremos LEFT JOIN persona ON persona.cedula = detalles_notas_baremos.cedula LEFT JOIN proyecto ON proyecto.id = detalles_notas_baremos.proyecto_id WHERE detalles_notas_baremos.cedula = $cedula");
            return $notas ? $notas : null;
        } catch (Exception $th) {
            return $th;
        }
       /*  $notas = $this->selectOne("detalles_notas_baremos", [['cedula', '=', "'" . $cedula . "'"]]);
        return !$notas ? [] : $notas; */
    }

}
