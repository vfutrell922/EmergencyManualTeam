/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/13/2021
 * This file contains the script to control the delete modal
 */
$(document).ready(function () {
    $('#confirmDelete').on('show.bs.modal', function (e) {
        $('#deleteConfirmButton').attr('href', $(e.relatedTarget).data('href'));
    });
});