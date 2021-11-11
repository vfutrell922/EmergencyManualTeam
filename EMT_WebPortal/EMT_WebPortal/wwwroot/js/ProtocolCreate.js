$(document).ready(function () {

    $("#hasMedicationInput").change(showList);

    function showList() {
        var up_icon = $("#up-icon");
        var down_icon = $("#down-icon");
        up_icon.display = "none";
        down_icon.display = "inline-flex";
        var listContainer = document.getElementById("MedicationsSelect");
        if (listContainer.style.display == "none") {
            listContainer.style.display = "block";
        }
        else
        {
            listContainer.style.display = "none";
        }
    }

});
