#= require active_admin/base
#= require chosen-jquery
$ ->
  # enable chosen js
  $('#service_category_category_id,#q_child_ids,#q_parent_id,#q_category_id').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'

  $('#service_category_category_id').trigger('chosen:activate').on 'change', (event) ->
    event.target.form['commit'].focus()
