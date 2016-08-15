# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

recipesForm =
  getCategories: (group) ->
    groupSelector = '#recipes-form ' + group + ' select'
    $(document).on 'change', groupSelector, ->
      recipesForm.handleCategoriesChange($(this))
      value = $(this).val()
      level = $(this).parent().attr('id').slice(-1)
      categoryNumber = $(this).parent().parent().attr('id').slice(-1)
      url = """
        /categories?parent_id=#{value}
        &category_level=#{level}
        &category_number=#{categoryNumber}
      """
      $.getScript(url)
      return
  handleCategoriesChange: (categoriesSelect) ->
    hiddenField = categoriesSelect.parent().siblings('#recipe_category_ids')
    value = categoriesSelect.val()
    if value == ''
      value = categoriesSelect.parent().prev().find('select').val()
    hiddenField.val(value)

  addIngredient: ->
    $(document).on 'click', '#recipes-form #add-ingredient', ->
      prevIngredient = $(this).siblings('div').last()
      newIngredient = prevIngredient.clone()
      prevId = prevIngredient.find('div').first().find('input').attr('id').substring(30,31)
      newId = parseInt(prevId) + 1

      $.each $(newIngredient.find('input, select')), (index, input) ->
        name = $(input).attr('name').replace(prevId, newId)
        $(input).attr('name', name)
        $(input).prop('value', '')
        $(input).children('option').prop('selected', false)
        if $(input).attr('id') != undefined
          id = $(input).attr('id').replace(prevId, newId)
          $(input).attr('id', id)

      newIngredient.insertAfter(prevIngredient)
      false
$ ->
  recipesForm.getCategories('#categories-group-0')
  recipesForm.getCategories('#categories-group-1')
  recipesForm.getCategories('#categories-group-2')
  recipesForm.addIngredient()
