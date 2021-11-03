$(document).ready(function () {
    $('#confirmDelete').on('show.bs.modal', function (e) {
        $('#deleteConfirmButton').attr('href', $(e.relatedTarget).data('href'));
    });
});