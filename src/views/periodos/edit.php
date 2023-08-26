<h4 class="font-weight-bold py-3 mb-4">
  <span class="text-muted font-weight-light">Proyecto /</span> Detalles
</h4>

<div class="card">
  <h5 class="card-header bg-primary text-white">
    Detalles de Proyecto
  </h5>
  <div class="card-body">
    <form action="<?= APP_URL . $this->Route("proyectos/update") ?>" method="POST" id="proyectoActualizar">
      <input type="hidden" name="estatus" value="1">
      <input type="hidden" name="id" value="<?= $proyecto->id ?>">
      <div class="container-fluid">
        <div class="row pb-2">
          <div class="col-12">
            <div class="row form-group">
              <div class="col-lg-6">
                <label class="form-label" for="nombre">Nombre *</label>
                <input type="text" class="form-control mb-1" placeholder="..." name="nombre" value="<?= $proyecto->nombre ?>">
              </div>

              <div class="col-lg-3">
                <label class="form-label" for="trayecto_id">Trayecto *</label>
                <select class="form-select" name="trayecto_id">

                  <?php foreach ($trayectos as $trayecto) : ?>
                    <option value="<?= $trayecto->id ?>" <?= ($trayecto->id == $proyecto->trayecto_id ? 'selected' : '') ?>><?= $trayecto->nombre ?></option>
                  <?php endforeach; ?>
                </select>
              </div>

              <div class="col-lg-3">

                <label class="form-label" for="tutor_id">Tutor *</label>
                <select class="form-select" name="tutor_id">
                  <?php foreach ($tutores as $tutor) : ?>
                    <option value="<?= $tutor->id ?>" <?= ($tutor->id == $proyecto->tutor_id ? 'selected' : '') ?>><?= "$tutor->cedula - $tutor->nombre $tutor->apellido" ?></option>
                  <?php endforeach; ?>
                </select>
              </div>
            </div>
          </div>
          <div class="col-12">
            <div class="row form-group">

              <div class="col-lg-6">
                <label class="form-label" for="descripcion">Descripción</label>
                <textarea class="form-control" placeholder="..." id="descripcion" name="descripcion" style="height: 100px"><?= $proyecto->descripcion ?></textarea>
              </div>

              <div class="col-lg-3">
                <label class="form-label" for="municipio">Municipio</label>
                <input type="text" class="form-control mb-1" placeholder="..." name="municipio" value="<?= $proyecto->municipio ?>">
              </div>

              <div class="col-lg-3">
                <label class="form-label" for="area">Area</label>
                <input type="text" class="form-control mb-1" placeholder="..." name="area" value="<?= $proyecto->area ?>">
              </div>
            </div>
          </div>
          <div class="col-12">
            <div class="row form-group">

              <div class="col-lg-4">
                <label class="form-label" for="repositorio_codigo" for="descripcion">Repositorio de Código</label>
                <input type="text" class="form-control mb-1" placeholder="..." name="repositorio_codigo" value="<?= $proyecto->repositorio_codigo ?>">
              </div>

              <div class="col-lg-4">
                <label class="form-label" for="repositorio_documentacion">Documentación</label>
                <input type="text" class="form-control mb-1" placeholder="..." name="repositorio_documentacion" value="<?= $proyecto->repositorio_documentacion ?>">
              </div>

              <div class="col-lg-4">
                <label class="form-label" for="url">URL</label>
                <input type="text" class="form-control mb-1" placeholder="..." name="url" value="<?= $proyecto->url ?>">
              </div>
            </div>
          </div>

          <div class="col-12">
            <div class="row form-group align-items-end">

              <div class="col-lg-4">
                <label class="form-label">Estudiantes *</label>
                <select class="form-select" id="selectEstudiante">
                  <?php foreach ($estudiantesPendientes as $estudiante) : ?>
                    <option value="<?= $estudiante->id ?>" data-cedula="<?= $estudiante->cedula ?>" data-nombre="<?= $estudiante->nombre ?>" data-apellido="<?= $estudiante->apellido ?>"><?= "$estudiante->cedula - $estudiante->nombre $estudiante->apellido" ?></option>
                  <?php endforeach; ?>
                </select>
              </div>

              <div class="col-lg-1 align-middle">
                <button class="btn btn-primary" id="anadirEstudiante">Añadir</button>
              </div>

            </div>
          </div>

          <div class="col-12 mb-4">
            <div class="row form-group justify-content-center">
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">C.I.</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Apellido</th>
                    <th scope="col">Remover</th>
                  </tr>
                </thead>
                <tbody id="cuerpoTablaEstudiantes">
                  <?php foreach ($estudiantes as $estudiante) : ?>
                    <tr id="appenedStudent-<?= $estudiante->estudiante_id ?>">
                      <th scope="row">
                        <input type="text" name="estudiantes[]" class="form-control-plaintext" value="<?= $estudiante->estudiante_id ?>" hidden>
                        <?= $estudiante->cedula ?>
                      </th>
                      <td><?= $estudiante->nombre ?></td>
                      <td><?= $estudiante->apellido ?></td>
                      <td><button class="btn btn-secondary" onClick="removeStudent(<?= $estudiante->estudiante_id ?>)">Eliminar</button></td>
                    </tr>
                  <?php endforeach; ?>
                </tbody>
              </table>
            </div>
          </div>
          <hr class="border-light m-0">
          <div class="text-right mt-3">
            <input type="submit" class="btn btn-primary" value='Actualizar Registro' />&nbsp;
          </div>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
  $(document).ready(function() {
    $('#anadirEstudiante').click(function(e) {
      e.preventDefault();

      let studentsAlreadyAppened = document.getElementById("cuerpoTablaEstudiantes").children.length;



      if (studentsAlreadyAppened >= 4) {
        alert('limite de estudiantes alcanzado');
      } else {
        let selectedStudent = $('#selectEstudiante option:selected');

        let studentId = $(selectedStudent).val();

        if ($("#cuerpoTablaEstudiantes").find(`#appenedStudent-${studentId}`).length > 0) {
          alert('Estudiante ya ha sido añadido')
          return false;
        }

        console.log($(selectedStudent).data('nombre'))
        let fila = `<tr id="appenedStudent-${studentId}">
                    <th scope="row">
                    <input type="text" name="estudiantes[]" class="form-control-plaintext" value="${studentId}" hidden>
                    ${$(selectedStudent).data('cedula')}
                    </th>
                    <td>${$(selectedStudent).data('nombre')}</td>
                    <td>${$(selectedStudent).data('apellido')}</td>
                    <td><button class="btn btn-secondary" onClick="removeStudent(${studentId})">Eliminar</button></td>
                  </tr>`;
        $('#cuerpoTablaEstudiantes').append(fila);

        //$(`#selectEstudiante option[value='${studentId}']`).remove();
      }


    })
  })

  function removeStudent(id) {
    $(`#appenedStudent-${id}`).remove()
  }
</script>

<script>
  $(document).ready(function() {
    $('#proyectoActualizar').submit(function(e) {
      e.preventDefault()


      url = $(this).attr('action');
      data = $(this).serializeArray();

      console.log(url)

      $.ajax({
        type: "POST",
        url: url,
        data: data,
        error: function(error, status) {
          alert(error.responseText)
        },
        success: function(data, status) {
          alert('actualizaco exitosamente')
          //window.location.replace("<?= APP_URL . $this->Route('proyectos') ?>");
        },
      });

    })
  })
</script>