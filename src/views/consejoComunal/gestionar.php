<div>
  <div>
    <div class="d-flex justify-content-between align-items-center w-100 font-weight-bold mb-2">
      <h4 class="d-flex justify-content-between align-items-center w-100 font-weight-bold py-3 mb-4">
        <div><span class="text-muted font-weight-light">  Consejo Comunal   </span>/ Gestión</div>

        <a class="btn btn-primary btn-round d-block" href="#" data-bs-toggle="modal" data-bs-target="#crear"><span class="ion ion-md-add"></span>&nbsp; Nuevo </a>

      </h4>
    </div>
  </div>

  <div class="card">
    <h6 class="card-header bg-primary text-white">Consejo Comunal</h6>
    <div class="card-body px-3 pt-3">
      <table id="tabla" class="table table-striped" style="width:100%">
        <thead>
          <tr>
            <th>Código</th>
            <th>Consejo Comunal</th>
            <th>Vocero</th>
            <th>Teléfono</th>
            <th>Sector</th>
            <th>Acción</th>
          </tr>
        </thead>
      </table>
    </div>
  </div>

  <!-- MODAL CREAR -->
  <div class="modal fade" id="crear" tabindex="-1" role="dialog" aria-labelledby="crearLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="crearLabel">Nuevo Consejo Comunal</h5>

        </div>
        <form action="<?= APP_URL . $this->Route('consejoComunal/guardar') ?>" method="post" id="guardar" name="consejoComunalguardar">
          <div class="modal-body">
            <!-- el action será tomado en la función que ejecuta el llamado asincrono -->
            <input type="hidden" name="estatus" value="1">
            <div class="container-fluid">
              <div class="row pb-2">
                <div class="col-12">
                  <div class="row form-group">
                    <div class="col-lg-6">
                      <label class="form-label" for="nombre">Nombre del Consejo Comunal *</label>
                      <input type="text" required class="form-control mb-1" name="nombre" id="nombre">
                      <h6 id="codigoCheck" style="color: red;">
                        ** El nombre es requerido **
                      </h6>
                    </div>

                    <div class="col-lg-6">
                      <label class="form-label" for="nombre">Nombre del Vocero</label>
                      <input type="text" required class="form-control mb-1" name="nombre_vocero" id="nombre_vocero">
                      
                    </div>
                    
                  </div>
                  <div class="row form-group">
                    
                   
                    <div class="col-lg-6">
                      <label class="form-label" for="sector_id">Sector *</label>
                      <select class="form-select" name="sector_id" id="sector_id">
                        <option>Seleccione</option>
                        <?php foreach ($sectores as $sector) : ?>
                          <option value="<?= $sector->id ?>"><?= "$sector->nombre" ?></option>
                        <?php endforeach; ?>
                      </select>
                    </div>

                    <div class="col-lg-6">
                      <label class="form-label" for="telefono">Teléfono</label>
                      <input type="number" required class="form-control mb-1" placeholder="..." name="telefono" id="telefono">
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- footer de acciones -->
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" id="crearSubmit">Cancelar</button>
            <input type="submit" class="btn btn-primary" value="Guardar" id="submit">
            <div id="loading">
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>


   <!-- MODAL ACTUALIZAR -->
   <div class="modal fade" id="editar" tabindex="-1" role="dialog" aria-labelledby="editarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="crearLabel">Actualizar Consejo Comunal</h5>

        </div>
        <form action="<?= APP_URL . $this->Route('consejoComunal/update') ?>" method="post" id="actualizar">
        <input type="hidden" name="id" id="idconsejocomunal">
          <div class="modal-body">
            <!-- el action será tomado en la función que ejecuta el llamado asincrono -->
            <input type="hidden" name="estatus" value="1">
            <div class="container-fluid">
              <div class="row pb-2">
                <div class="col-12">
                  <div class="row form-group">
                    <div class="col-lg-6">
                      <label class="form-label" for="nombre">Nombre del Consejo Comunal *</label>
                      <input type="text" required class="form-control mb-1" name="nombre" id="nombre">

                    </div>

                    <div class="col-lg-6">
                      <label class="form-label" for="nombre">Nombre del Vocero</label>
                      <input type="text" required class="form-control mb-1" name="nombre_vocero" id="nombre_vocero">
                      
                    </div>
                    
                  </div>
                  <div class="row form-group">
                    
                   
                    <div class="col-lg-6">
                      <label class="form-label" for="sector_id">Sector *</label>
                      <select class="form-select" name="sector_id" id="sector_id">
                        <option>Seleccione</option>
                        <?php foreach ($sectores as $sector) : ?>
                          <option value="<?= $sector->id ?>"><?= "$sector->nombre" ?></option>
                        <?php endforeach; ?>
                      </select>
                    </div>

                    <div class="col-lg-6">
                      <label class="form-label" for="telefono">Teléfono</label>
                      <input type="number" required class="form-control mb-1" placeholder="..." name="telefono" id="telefono">
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- footer de acciones -->
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" id="crearSubmit">Cancelar</button>
            <input type="submit" class="btn btn-primary" value="Guardar" id="submit">
            <div id="loading">
              <div class="spinner-border text-primary" role="status">
                <span class="sr-only"></span>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>



  <script>
     let updateUrl = "<?= APP_URL . $this->Route('consejoComunal/edit') ?>";
    let deleteUrl = "<?= APP_URL . $this->Route('consejoComunal/delete') ?>";

    $(document).ready(() => {

      toggleLoading(false)

      // DATATABLE CRUD

      // las acciones son definidas en la clase que contiene el botón, es decir,
      // si necesito editar, le añado la clase "edit"
      // luego en la función table.on(). verifico si la clase del boton en el que hice click
      // contiene el nombre de alguna acción que haya definido




      let table = new DataTable('#tabla', {
        ajax: '<?= $this->Route('consejoComunal/ssp') ?>',
        processing: true,
        serverSide: true,
        pageLength: 30,

        columnDefs: [{
          data: null,
          render: function(data, type, row, meta) {
            return `<div class="dropdown show">
                      <button class="btn btn-primary btn-icon rounded-pill dropdown-toggle hide-arrow" href="#" role="button" id="dropdown-${row[0]}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="bx bx-dots-vertical-rounded"></i>
                      </button>
                      <div class="dropdown-menu" aria-labelledby="dropdown-${row[0]}">
                        <a class="dropdown-item" onClick="editar('${row[0]}')" href="javascript:void(0)">Editar</a>
                        <a class="dropdown-item text-danger" onClick="remove('${row[0]}')" href="javascript:void(0)">Eliminar</a>
                      </div>
                    </div>`;
          }, // combino los botons de acción
          targets: 5 // la columna que representa, empieza a contar desde 0, por lo que la columna de acciones es la 3ra
        }]

      });



      $('#guardar').submit(function(e) {
        e.preventDefault()

        toggleLoading(true);


        url = $(this).attr('action');
        data = $(this).serializeArray();




        $.ajax({
          type: "POST",
          url: url,
          data: data,
          error: function(error, status) {
            toggleLoading(false)
            Swal.fire({
              position: 'bottom-end',
              icon: 'error',
              title: error.responseText,
              showConfirmButton: false,
              toast: true,
              timer: 2000
            })

          },
      success: function(data, status) {
            table.ajax.reload();
            // usar sweetalerts
            Swal.fire({
              position: 'bottom-end',
              icon: 'success',
              title: 'El Consejo Comunal fue creado con exito',
              showConfirmButton: false,
              toast: true,
              timer: 1500
            }).then(() => location.reload())
            $('#crear').modal('hide');
            $('#crear').modal('closed');
            document.getElementById("guardar").reset();
            // actualizar tabla
            toggleLoading(false, '#guardar')
          },
        });

      })

      $('#actualizar').submit(function(e) {
        e.preventDefault()

        toggleLoading(true, '#actualizar');


        url = $(this).attr('action');
        data = $(this).serializeArray();

        $.ajax({
          type: "POST",
          url: url,
          data: data,
          error: function(error, status) {
            toggleLoading(false, '#actualizar')
            Swal.fire({
              position: 'bottom-end',
              icon: 'error',
              title: error.responseText,
              showConfirmButton: false,
              toast: true,
              timer: 2000
            })

          },
          success: function(data, status) {
            table.ajax.reload();
            Swal.fire({
              position: 'bottom-end',
              icon: 'success',
              title: 'El Consejo Comunal fue editado con exito',
              showConfirmButton: false,
              toast: true,
              timer: 1500
            })
            // actualizar tabla
            toggleLoading(false, '#actualizar')

            $('#editar').modal('hide')
          },
        });

      })


      function toggleLoading(show, form = '') {
        if (show) {
          $(`${form} #loading`).show();
          $(`${form} #submit`).hide();
        } else {
          $(`${form} #loading`).hide();
          $(`${form} #submit`).show();
        }

      }
    })

    function renderUpdateForm(data) {
     
      // console.log(data)
     $('#editar').modal('show')
     
     
     $(`#actualizar #idconsejocomunal`).val(data.consejoComunal.consejo_comunal_id);
     $(`#actualizar #nombre`).val(data.consejoComunal.consejo_comunal_nombre);
     $(`#actualizar #nombre_vocero`).val(data.consejoComunal.nombre_vocero);
     $(`#actualizar #sector_id option[value='${data.consejoComunal.sector_id}']`).attr("selected", true);
     $(`#actualizar #telefono`).val(data.consejoComunal.consejo_comunal_telefono);

     }
     
     
     
         function editar(id) {
           $.ajax({
             type: "POST",
             url: updateUrl,
             data: {
               'id': id
             },
             error: function(error, status) {
               Swal.fire({
                 position: 'bottom-end',
                 icon: 'error',
                 title: error.responseText,
                 showConfirmButton: false,
                 toast: true,
                 timer: 2000
               })
             },
             success: function(data, status) {
               renderUpdateForm(JSON.parse(data))
             },
           });
         }
     
         function remove(id) {
             $.ajax({
             type: "POST",
             url: deleteUrl,
             data: {
               'id': id
             },
             error: function(error, status) {
               Swal.fire({
                 position: 'bottom-end',
                 icon: 'error',
                 title: error.responseText,
                 showConfirmButton: false,
                 toast: true,
                 timer: 3000
               })
     
             },
             success: function(data, status) {
               console.log(data);
               Swal.fire({
                 position: 'bottom-end',
                 icon: 'success',
                 title: 'El Consejo Comunal fue borrado con exito',
                 showConfirmButton: false,
                 toast: true,
                 timer: 1500
               })
               $('#tabla').DataTable().ajax.reload();
             },
           });
           }
    
  </script>
  
  