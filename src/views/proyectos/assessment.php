<div>
  <div>
    <div class="d-flex justify-content-between align-items-center w-100 font-weight-bold mb-2">
      <h4 class="d-flex justify-content-between align-items-center w-100 font-weight-bold py-3 mb-4">
        <div>Baremos <?= $fase->nombre_trayecto . ' - ' . $fase->nombre_fase . ' - ' . $fase->fecha_inicio . '/' . $fase->fecha_cierre ?></div>


      </h4>
    </div>
  </div>
  <?php if ($errors->danger) : ?>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <strong>Atención!</strong> Han ocurrido algunos errores críticos al generar baremos:
      <ul>
        <?php foreach ($errors->danger as $error) : ?>
          <li><?= $error ?></li>
        <?php endforeach; ?>

      </ul>
    </div>
  <?php endif; ?>
  <?php if ($errors->warning) : ?>

    <div class="alert alert-secondary alert-dismissible fade show" role="alert">
      <strong>Atención!</strong> El equipo de proyecto cuenta con las siguientes caracteristicas:
      <ul>
        <?php foreach ($errors->warning as $error) : ?>
          <li><?= $error ?></li>
        <?php endforeach; ?>

      </ul>
    </div>
  <?php endif; ?>

  <form action="<?= APP_URL . $this->Route('proyectos/guardar') ?>" method="post" id="proyectoGuardar">

    <?php foreach ($baremos as $materia) : ?>
      <div class="card mb-3">
        <h6 class="card-header bg-primary text-white"><?= $materia->nombre ?></h6>
        <div class="card-body px-3 pt-3">
          <input type="hidden" name="estatus" value="1">

          <?php foreach ($materia->dimension->grupal as $dimension) : ?>
            <div class="container">
              <div class="row">
                <div class="col-12">
                  <strong>GRUPAL - <?= $dimension->nombre ?></strong>
                </div>
                <hr>
                <?php foreach ($dimension->indicadores as $indicador) : ?>

                  <div class="col-6">
                    <label class="form-label" for="repositorio_documentacion"><?= $indicador->nombre ?> - <?= $indicador->ponderacion ?> pts</label>
                    <input type="number" class="form-control mb-1" max="<?= $indicador->ponderacion ?>" placeholder="..." name="repositorio_documentacion">

                  </div>
                <?php endforeach; ?>

              </div>
            </div>
          <?php endforeach; ?>



          <?php if (property_exists($materia->dimension, 'individual') && !empty($materia->dimension->individual)) : ?>
            <div class="my-5"></div>
            <hr>
            <div class="my-5"></div>

            <?php foreach ($integrantes as $integrante) : ?>
              <div class="container">
                <div class="row">
                  <div class="col-12">
                    <strong>INDIVIDUAL - <?= $integrante->nombre ?> - C.I. <?= $integrante->cedula ?> </strong>
                  </div>
                  <hr>
                  <?php foreach ($materia->dimension->individual as $dimension) : ?>
                    <div class="col-6">
                      <label class="form-label" for="repositorio_documentacion"><?= $indicador->nombre ?> - <?= $indicador->ponderacion ?> pts</label>
                      <input type="number" class="form-control mb-1" max="<?= $indicador->ponderacion ?>" placeholder="..." name="repositorio_documentacion">

                    </div>
                  <?php endforeach; ?>

                </div>
              </div>
            <?php endforeach; ?>


          <?php endif; ?>




        </div>
      </div>
    <?php endforeach; ?>
    <hr class="border-light m-0">
    <?php if ($errors->danger) : ?>
      <p>
        No se podrá evaluar baremos hasta que se resuelvan los conflictos críticos
      </p>
    <?php else : ?>

      <div class="text-end mt-3">
        <input type="submit" class="btn btn-primary" value='Evaluar' />&nbsp;
      </div>

    <?php endif; ?>
  </form>
</div>