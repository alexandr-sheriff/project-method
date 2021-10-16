<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="/static/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="/static/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="/static/js/mdb.min.js"></script>
<!-- jQuery Multi -->
<script type="text/javascript" src="/static/js/multi.min.js"></script>
<!-- Bootstrap Select -->
<script type="text/javascript" src="/static/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="/static/js/defaults-ru_RU.min.js"></script>
<!-- jQuery Validation -->
<script type="text/javascript" src="/static/js/jquery.validate.js.js"></script>
<!-- MDBootstrap Datatables  -->
<script type="text/javascript" src="/static/js/addons/datatables.min.js"></script>

<!-- Initializations -->
<script type="text/javascript">
    // Animations initialization
    new WOW().init();

    $(function () {
        window.setTimeout(function () {
            $('#my-alert').alert('close');
        }, 5000);
    });

    $('#teamUsers').multi({
        enable_search: true,
        search_placeholder: 'Поиск...',
        non_selected_header: 'Участники',
        selected_header: 'Выбранные участники'
    });

   /* $("form").validate();*/

    $(document).ready(function () {
        $('#sortedUsersTable').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: [6, 7]
            }]
        });
        $('#sortedHistoryProjectsTable').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: 7
            }]
        });
        $('#sortedStatStagesTable').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: 7
            }]
        });
        $('#sortedStatTeamsTable').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: 5
            }]
        });
        $('#sortedStatTeamsOnStagesTable').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: 8
            }]
        });
        $('.dataTables_length').addClass('bs-select');
    });

</script>
