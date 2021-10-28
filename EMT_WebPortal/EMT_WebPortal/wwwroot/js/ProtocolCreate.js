$(document).ready(function () {

    $("#hasMedicationInput").change(showList);

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



    $("#submitButton").click(function(){
        var protocol = new Object();

        var theName = $("#Name").val();
        var theMedications = $("#selectList").val();
        var theCertification = $("#Certification").val();
        var thePatientType = $("#PatientType").val();
        var theHasMed = $("#hasMedicationInput").val();
        var theOtherInformation = tinymce.get("OtherInformationArea").getContent();
        var theTreatmentPlan = tinymce.get("TreatmentPlanArea").getContent();
        var theGuideline = $("#Guideline").val();
        var theOLMCRequired = $("#OLMC").val();

        jQuery.ajaxSettings.traditional = true;

        $.ajax({
            type: "POST",
            url: '/Protocols/CreateNew',
            contentType: "application/json; chartset=utf-8",
            data:{"Name": theName, "Certification": theCertification, "PatientType": thePatientType,"HasAssociatedMedication": theHasMed, "OtherInformation": theOtherInformation,"TreatmentPlan": theTreatmentPlan, "Guideline": theGuideline, "OLMCRequired": theOLMCRequired},
            dataType: "json",
            success: function (result)
            {
                alert("it worked");
            }
            
        });
    })
});
