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

$ ->
  recipesForm.getCategories('#categories-group-0')
  recipesForm.getCategories('#categories-group-1')
  recipesForm.getCategories('#categories-group-2')
