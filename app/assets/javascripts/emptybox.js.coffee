bindRowClick = () ->
  $("tr.linkable-table-row").click ->
    if $(this).data("rowlink")?
      window.location = $(this).data("rowlink")

# Bind on both jQuery document.ready and turbolinks page:load,
# so that manual browser refresh and link clicks both bind event
# handlers
$(document).on 'page:load', bindRowClick
$(document).ready bindRowClick
