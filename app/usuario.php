<?php

namespace App;

use App\model;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Bcrypt\Bcrypt;

use Exception;

class usuario extends model
{

    public $fillable = [
        'email',
        'contrasena',
        'rol_id',
        'nombre',
        'apellido',
        'cedula',
        'direccion',
        'telefono',
        'nacimiento',
        'estatus',
    ];

    public function all()
    {
        try {
            $usuarios = $this->select('usuarios');
            return $usuarios ? $usuarios : null;
        } catch (Exception $th) {
            return $th;
        }
    }

    public function new_session(Request $request)
    {
        $email = $request->request->get('email');
        $contrasena = $request->request->get('contrasena');

        $credenciales = $this->select('usuarios', [
            ['email', '=', '"' . $email . '"'],
            ['contrasena', '=', '"' . md5($contrasena)  . '"']
        ]);


        if (isset($credenciales[0])) {

            $usuariopersona = $this->select('persona', [['usuarios_id', '=', $credenciales[0]['id']]])[0];

            $_SESSION = $usuariopersona;

            if (!$usuariopersona['estatus']) {
                return [
                    'estatus' => '2',
                ];
            } else {
                $_SESSION = $usuariopersona;

                $token = bin2hex(openssl_random_pseudo_bytes(32));

                $this->update('usuarios', ['token' => "'" . $token . "'"], [['id', '=', $usuariopersona['id']]]);
                $_SESSION['token'] = $token;

                $navegador = $_SERVER['HTTP_USER_AGENT'] . "\n\n";
                $hora = new \DateTimeZone("America/Caracas");
                $guardar_hora = new \DateTime("now", $hora);
                $this->set('bitacora', [
                    'fecha' => '"' . Date('Y-m-d') . '"',
                    'navegador' => '"' . $navegador . '"',
                    'hora_inicio' => '"' . $guardar_hora->format("H:i:s") . '"',
                    'nombre' => '"' . $_SESSION['nombre']  . '"',
                    'apellido' => '"' . $_SESSION['apellido'] . '"',
                    'token' => '"' . $_SESSION['token'] . '"',
                    'usuario_id' => '"' . $_SESSION['usuarios_id'] . '"',
                ]);

                return [
                    'estatus' => '1',
                ];
            }
        } else {
            return [
                'estatus' => '0',
            ];
        }
    }

    public function end_session()
    {
        $hora = new \DateTimeZone("America/Caracas");
        $guardar_hora = new \DateTime("now", $hora);
        $hora_cierre  = $guardar_hora->format("H:i:s");
        $idusuario = $_SESSION['usuarios_id'];
        $bitacora = $this->query(
            'UPDATE bitacora SET 
            bitacora.hora_cierre="' . $hora_cierre . '"  
            WHERE 
            bitacora.usuario_id  = "' . $idusuario  . '" AND bitacora.fecha  = "' . Date('Y-m-d') . '"  AND bitacora.token= "' . $_SESSION['token'] . '"'
        );

        foreach ($bitacora as $key => $value) {
            $this->fillable[$key] = $value;
        }
        return $this;
    }
    // ======================== G E T S =======================

    public function profesor()
    {
        $profesor = $this->querys(
            'SELECT
                persona.*,
                usuarios.email
            FROM
                `usuarios`,
                `persona`
            WHERE
                usuarios.id = persona.usuarios_id AND usuarios.rol_id = 2'
        );
        return $profesor;
    }


    public function users_activos()
    {
        $users_activos = $this->querys(
            'SELECT
                persona.*,
                usuarios.email
            FROM
                `usuarios`,
                `persona`
            WHERE
                usuarios.id = persona.usuarios_id AND persona.estatus = 1'
        );

        return $users_activos;
    }

    public function users_inactivos()
    {
        $users_activos = $this->querys(
            'SELECT
                persona.*,
                usuarios.email
            FROM
                `usuarios`,
                `persona`
            WHERE
                usuarios.id = persona.usuarios_id AND persona.estatus = 0'
        );

        return $users_activos;
    }


    // ======================== / G E T S =====================

    //=========================FIND==========================
    public function find($id)
    {
        try {
            $usuarios = $this->querys(
                'SELECT
                        persona.*,
                        usuarios.email,
                        usuarios.rol_id
                    FROM
                        `usuarios`,
                        `persona`
                    WHERE
                        usuarios.id = persona.usuarios_id AND usuarios.id = ' . $id . ';'
            );
            if ($usuarios) {
                foreach ($usuarios[0] as $key => $value) {
                    $this->fillable[$key] = $value;
                }
                return $this;
            } else {
                return null;
            }
        } catch (\PDOException $th) {
            return $th;
        }
    }

    //=========================/FIND==========================

    // ======================== S E T S =======================

    public function create($usuario)
    {
        foreach ($usuario as $key => $value) {
            $this->fillable[$key] = $value;
        }
        return $this;
    }

    public function save()
    {
        try {

            $this->set('usuarios', [
                'email' => '"' . $this->fillable['email'] . '"',
                'contrasena' => '"' . $this->fillable['contrasena'] . '"',
                'rol_id' => '"' . $this->fillable['rol_id'] . '"',
            ]);

            $usuario = $this->select('usuarios', [['email', '=', "'" . $this->fillable['email'] . "'"]])[0]['id'];

            if ($this->fillable['rol_id'] == 2) {
                $this->set('persona', [
                    'usuarios_id' => $usuario,
                    'nombre' => '"' . $this->fillable['nombre'] . '"',
                    'apellido' => '"' . $this->fillable['apellido'] . '"',
                    'cedula' => '"' . $this->fillable['cedula'] . '"',
                    'telefono' => '"' . $this->fillable['telefono'] . '"',
                    'nacimiento' => '"' . $this->fillable['nacimiento'] . '"',
                    'direccion' => '"' . $this->fillable['direccion'] . '"',
                    'estatus' => '"' . $this->fillable['estatus'] . '"',
                ]);

                $persona_id = $this->lastInsertId();

                $this->set('profesor', [
                    'persona_id' => $persona_id,
                ]);
            } else {
                $this->set('persona', [
                    'usuarios_id' => $usuario,
                    'rol_id' => '"' . $this->fillable['rol_id'] . '"',
                    'procedencia_id' => '"' . $this->fillable['procedencia_id'] . '"',
                    'nombre' => '"' . $this->fillable['nombre'] . '"',
                    'apellido' => '"' . $this->fillable['apellido'] . '"',
                    'cedula' => '"' . $this->fillable['cedula'] . '"',
                    'telefono' => '"' . $this->fillable['telefono'] . '"',
                    'nacimiento' => '"' . $this->fillable['nacimiento'] . '"',
                    'direccion' => '"' . $this->fillable['direccion'] . '"',
                    'estatus' => '"' . $this->fillable['estatus'] . '"',
                ]);
            }

            // return $this->fillable;

        } catch (\PDOException $th) {
            return $th;
        }
    }


    // ======================== / S E T S =====================

    public function eliminarAgente()
    {

        try {
            $analista = $this->query(
                '
            DELETE usuarios.* FROM usuarios INNER JOIN persona ON usuarios.id = persona.usuarios_id INNER JOIN agentes ON agentes.persona_id = persona.id WHERE usuarios.id = "' . $this->fillable['usuarios_id'] . '" AND persona.rol_id = 2'
            );

            return $this;
        } catch (\PDOException $th) {
            return $th;
        }
    }


    public function eliminar()
    {

        try {

            $this->delete('usuarios', [['id', '=',  $this->fillable['usuarios_id']]]);
            $this->delete('persona', [['usuarios_id', '=', $this->fillable['usuarios_id']]]);
            return $this;
        } catch (\PDOException $th) {
            return $th;
        }
    }



    // ======================== / UPDATE=========================
    public function actualizar($usuario)
    {

        $this->update('persona', [
            'nombre' => '"' . $usuario->get('nombre') . '"',
            'apellido' => '"' . $usuario->get('apellido') . '"',
            'cedula' => '"' .  $usuario->get('cedula') . '"',
            'telefono' => '"' .  $usuario->get('telefono'). '"',
            'nacimiento' => '"' . $usuario->get('nacimiento') . '"',
            'direccion' => '"' . $usuario->get('direccion') . '"',
            'estatus' => '"' . $usuario->get('estatus') . '"',
        ], [['id', '=', $this->fillable['id']]]);

        $this->create($usuario);
        return $this;
    }


    public function usersname()
    {
        try {
            $usuarios = $this->query('SELECT persona.nombre, persona.apellido, usuarios.id, usuarios.email FROM persona INNER JOIN usuarios ON persona.usuarios_id = usuarios.id WHERE persona.estatus = 1');
            return $usuarios ? $usuarios : null;
        } catch (\PDOException $th) {
            return $th;
        }
    }
}
