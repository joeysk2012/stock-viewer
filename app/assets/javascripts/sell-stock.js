$(document).ready(function() {

    $('#sell_form').submit(function(e) {
        var shares = $('#current_shares').html().split(" ")[0]
        var input = $('#table_shares').val()
        if(input > shares){
            alert("Cannot sell shares than you have!")
            e.preventDefault()
            return false;
        }
        sold = shares - input 
        $('#table_shares').val(sold)
        $('#table_shares').hide()
    });
});
