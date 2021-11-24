/*
 *  Author: Vincent Futrell
 *  Date Last Modified: 11/05/2021
 *  This file contains the script to expose the medications select
 */

$(document).ready(function () {
    var has_medication_input = document.getElementById("hasMedicationInput");
    var medications_select = document.getElementById("MedicationsSelect");
    if (has_medication_input.checked) {
        medications_select.style.display = "block";
    }

    document.getElementById("hasMedicationInput").onchange = showList;
});

function showList() {
    var listContainer = document.getElementById("MedicationsSelect");
    if (listContainer.style.display == "none") {
        listContainer.style.display = "block";
    }
    else {
        listContainer.style.display = "none";
    }
}
