$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look below for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
    swal {
      title: 'Are you sure?'
      text: 'This cannot be undone!'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Delete'
      cancelButtonText: 'Cancel'
      closeOnConfirm: false
      closeOnCancel: false
    }, (isConfirm) ->
    if isConfirm
      swal 'Deleted!', 'Student has been deleted!.', 'success', $.rails.confirmed link
    else
      swal 'Cancelled', 'Student delete has been cancelled', 'error'
    return

$ ->
  $("[data-behavior='delete']").on "click", (e) ->
    e.preventDefault()

    swal {
      title: 'Are you sure?'
      text: 'You will not be able to recover this imaginary file!'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Yes, delete it!'
      cancelButtonText: 'No, cancel plx!'
      closeOnConfirm: false
      closeOnCancel: false
    }, (confirmed) =>
      if confirmed
        # $.ajax(
        #   url: $(this).attr("href")
        #   dataType: "JSON"
        #   method: "DELETE"
        #   success: =>
            swal 'Deleted!', 'Your imaginary file has been deleted.', 'success'
        # )

      else
        swal 'Cancelled', 'Your imaginary file is safe :)', 'error'
      return