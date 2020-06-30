$('#classifications').on('cocoon:before-insert', function() {
    if ($('#classifications .nested-fields').length >= 5) {
        return $('#add-item').hide();
    } else {
        return $('#add-item').show();
    }
});