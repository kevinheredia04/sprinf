</div>
<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<!-- <script src="<?= APP_URL  ?>assets/vendor/libs/jquery/jquery.js"></script> -->
<script src="<?= APP_URL  ?>assets/vendor/libs/popper/popper.js"></script>
<script src="<?= APP_URL  ?>assets/vendor/js/bootstrap.js"></script>
<script src="<?= APP_URL  ?>assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="<?= APP_URL  ?>assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->
<script src="<?= APP_URL  ?>assets/vendor/libs/apex-charts/apexcharts.js"></script>

<!-- Main JS -->
<script src="<?= APP_URL  ?>assets/js/main.js"></script>

<!-- Page JS -->
<script src="<?= APP_URL  ?>assets/js/dashboards-analytics.js"></script>
<script src="<?= APP_URL  ?>js/sweetalert2.js"></script>

<!-- Data Tables -->

<script src="https://cdn.datatables.net/v/bs4/dt-1.13.5/datatables.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>

<script>
  (function() {
    $(".table-responsive").on("shown.bs.dropdown", function(e) {
      var $table = $(this),
        $menu = $(e.target).find(".dropdown-menu"),
        tableOffsetHeight = $table.offset().top + $table.height(),
        menuOffsetHeight = $menu.offset().top + $menu.outerHeight(true);

      if (menuOffsetHeight > tableOffsetHeight)
        $table.css("padding-bottom", menuOffsetHeight - tableOffsetHeight);
    });

    $(".table-responsive").on("hide.bs.dropdown", function() {
      $(this).css("padding-bottom", 0);
    });
  })();
  $(function() {
    $('[data-toggle="tooltip"]').tooltip()
  })
</script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>

</html>