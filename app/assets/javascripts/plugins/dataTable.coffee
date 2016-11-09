#= require dataTables/jquery.dataTables.min
#= require dataTables/dataTables.bootstrap.min

$ ->
  $('.js-table').DataTable(
    columnDefs: [
      { orderable: false, targets: -1 }
      { bSearchable: false, aTargets: -1 }
    ]
  )

  $('.js-work-statistics-table').DataTable(
    order: [[ 1, "desc" ]]
  )
