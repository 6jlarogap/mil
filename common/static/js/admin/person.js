django.jQuery(function($) {
    function check_mia() {
        if ($('#id_mia:checked').length) {
            $('#id_burial').val('').attr('disabled', '1');
        } else {
            $('#id_burial').removeAttr('disabled');
        }
    }

    $('#id_mia').change(check_mia);
    check_mia();
})