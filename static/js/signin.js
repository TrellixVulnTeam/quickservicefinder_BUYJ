$(function(){
    $('#btnSignIn').click(function(){
        showElem('loader');
        $.ajax({
            url: '/signIn',
            data: $('form').serialize(),
            type: 'POST',
            success: function(response){
                console.log(response);
                if(response.responseCode == 200 && response.responseOwner == true) {
                    $('#toastContent').html(response.responseMessage);
                    window.location.href = '/ownerServices'
                }
                else if(response.responseCode == 200 && response.responseOwner == false){
                    $('#toastContent').html(response.responseMessage);
                    window.location.href = '/listSubsectors'
                }
                else if(response.responseCode == 400){
                    $('#toastContent').html(response.responseMessage);
                }
                else if(response.responseCode == 500){
                    $('#toastContent').html("Ha ocurrido un error: " + response.responseMessage);
                }
            },
            error: function(error){
                console.log(error);
                $('#toastContent').html('Ha ocurrido un error inesperado.');
            },
            complete: function() {
                hideElem('loader');
                $('.toast').toast('show');
            }
        });
    });
});