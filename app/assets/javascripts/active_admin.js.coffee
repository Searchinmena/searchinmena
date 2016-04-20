#= require active_admin/base
$ ->
  $('.upload_csv form').submit (event) ->
    format = $('#dump_file').val().split('.').pop().toLowerCase();
    if format == 'csv'
    else
      alert 'Please attach csv file only'
      event.preventDefault()
      return
