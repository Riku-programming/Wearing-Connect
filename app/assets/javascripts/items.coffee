
# 5行以上ある場合は追加ボタンを隠す
  $('#classifications').on 'cocoon:before-insert', ->
    if $('#classifications .nested-fields').length >= 5
      $('#add-item').hide();
    else
      $('#add-item').show();