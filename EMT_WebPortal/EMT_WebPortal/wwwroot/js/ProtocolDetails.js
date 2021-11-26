$(document).ready(function () {
    var hasMedication = document.getElementById("hasMedsBool");
    var hasOLMC = document.getElementById("hasOLMCBool");
    var hasMedsDiv = document.getElementById("hasMedsDiv");
    var noMedsDiv = document.getElementById("noMedsDiv");
    var hasOLMCDiv = document.getElementById("hasOLMCDiv");
    var noOLMCDiv = document.getElementById("noOLMCDiv");
    var protocolId = document.getElementById("protocolId");

    

    if (hasMedication.innerHTML == "True") {
        var idNumber = parseInt(protocolId.innerHTML);
        buildMedicationList(idNumber);
        hasMedsDiv.style.display = "block";
        noMedsDiv.style.display = "none";
    }
    else {
        hasMedsDiv.style.display = "none";
        noMedsDiv.style.display = "block";
    }

    if (hasOLMC.innerHTML == "True") {
        hasOLMCDiv.style.display = "block";
        noOLMCDiv.style.display = "none";
    }
    else {
        hasOLMCDiv.style.display = "none";
        noOLMCDiv.style.display = "true";
    }
});


function buildMedicationList(idNumber) {
    let apiUrl = "/api/protocolsget/getmedicationnames/" + idNumber;
    $.ajax({
        type: "GET",
        url: apiUrl,
        success: function (response) {

            var names = JSON.parse(response);
            var medicationList = document.getElementById("medsList");
            var listElement = document.createElement("ul");
            medicationList.appendChild(listElement);

            for (let i = 0; i < names.length; i ++) {
                let listItem = document.createElement("li");
                listItem.innerHTML = names[i];
                listElement.appendChild(listItem);
            }
        },
        error: function () {
            alert("error");
        }
    })
}