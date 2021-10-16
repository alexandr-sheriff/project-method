<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="/static/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="/static/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="/static/js/mdb.min.js"></script>
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

    $(document).ready(function () {
        $('[name="sortedUsersRatingTable"]').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: [4]
            }]
        });
        $('.dataTables_length').addClass('bs-select');
    });

    $(document).ready(function () {
        $('[name="sortedRatingsTable"]').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: [4]
            }]
        });
        $('#sortedUsersTable').DataTable({
            "aaSorting": [],
            columnDefs: [{
                orderable: false,
                targets: [6, 7]
            }]
        });
        $('.dataTables_length').addClass('bs-select');
    });

    // Line
    var ctx = document.getElementById("myChart").getContext('2d');
    var countProjectStatus_0 = document.getElementById("countProjectStatus[0]").value;
    var countProjectStatus_1 = document.getElementById("countProjectStatus[1]").value;
    var countProjectStatus_2 = document.getElementById("countProjectStatus[2]").value;
    var countProjectStatus_3 = document.getElementById("countProjectStatus[3]").value;
    var countProjectStatus_4 = document.getElementById("countProjectStatus[4]").value;
    var countProjectStatus_5 = document.getElementById("countProjectStatus[5]").value;
    var countProjectStatus_6 = document.getElementById("countProjectStatus[6]").value;
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["В ожидании", "Надо сделать", "В работе", "Выполнен", "На проверке", "Проверено", "Завершено"],
            datasets: [{
                label: '# всего',
                data: [countProjectStatus_0, countProjectStatus_1, countProjectStatus_2, countProjectStatus_3, countProjectStatus_4, countProjectStatus_5, countProjectStatus_6],
                backgroundColor: [
                    'rgba(0, 0, 0, 0.2)',
                    'rgba(96, 125, 139, 0.2)',
                    'rgba(3, 169, 244, 0.2)',
                    'rgba(255, 235, 59, 0.2)',
                    'rgba(233, 30, 99, 0.2)',
                    'rgba(156, 39, 176, 0.2)',
                    'rgba(76, 175, 80, 0.2)'
                ],
                borderColor: [
                    'rgba(0, 0, 0, 1)',
                    'rgba(96, 125, 139, 1)',
                    'rgba(3, 169, 244, 1)',
                    'rgba(255, 235, 59, 1)',
                    'rgba(233, 30, 99, 1)',
                    'rgba(156, 39, 176, 1)',
                    'rgba(76, 175, 80, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    //doughnut
    var ctxD = document.getElementById("doughnutChart").getContext('2d');
    var percentageProjectStatus_0 = document.getElementById("percentageProjectStatus[0]").value.replace(/,/, '.');
    var percentageProjectStatus_1 = document.getElementById("percentageProjectStatus[1]").value.replace(/,/, '.');
    var percentageProjectStatus_2 = document.getElementById("percentageProjectStatus[2]").value.replace(/,/, '.');
    var percentageProjectStatus_3 = document.getElementById("percentageProjectStatus[3]").value.replace(/,/, '.');
    var percentageProjectStatus_4 = document.getElementById("percentageProjectStatus[4]").value.replace(/,/, '.');
    var percentageProjectStatus_5 = document.getElementById("percentageProjectStatus[5]").value.replace(/,/, '.');
    var percentageProjectStatus_6 = document.getElementById("percentageProjectStatus[6]").value.replace(/,/, '.');

    var myLineChart = new Chart(ctxD, {
        type: 'doughnut',
        data: {
            labels: ["В ожидании", "Надо сделать", "В работе", "Выполнен", "На проверке", "Проверен", "Завершен"],
            datasets: [{
                data: [percentageProjectStatus_0, percentageProjectStatus_1, percentageProjectStatus_2, percentageProjectStatus_3, percentageProjectStatus_4, percentageProjectStatus_5, percentageProjectStatus_6],
                backgroundColor: [
                    'rgba(0, 0, 0, 0.7)',
                    'rgba(96, 125, 139, 0.7)',
                    'rgba(3, 169, 244, 0.7)',
                    'rgba(255, 235, 59, 0.7)',
                    'rgba(233, 30, 99, 0.7)',
                    'rgba(156, 39, 176, 0.7)',
                    'rgba(76, 175, 80, 0.7)'
                ],
                hoverBackgroundColor: [
                    'rgba(0, 0, 0, 1)',
                    'rgba(96, 125, 139, 1)',
                    'rgba(3, 169, 244, 1)',
                    'rgba(255, 235, 59, 1)',
                    'rgba(233, 30, 99, 1)',
                    'rgba(156, 39, 176, 1)',
                    'rgba(76, 175, 80, 1)'
                ]
            }]
        },
        options: {
            responsive: true
        }
    });

</script>
