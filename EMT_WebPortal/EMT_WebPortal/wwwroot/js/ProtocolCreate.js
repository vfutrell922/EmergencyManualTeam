var selectElement = document.getElementById("hasMedicationInput");
selectElement.addEventListener('change', showList);

function showList() {
    var listContainer = document.getElementById("MedicationsSelect");
    if (listContainer.style.display == "none") {
        listContainer.style.display = "block";
    }
    else
    {
        listContainer.style.display = "none";
    }
}