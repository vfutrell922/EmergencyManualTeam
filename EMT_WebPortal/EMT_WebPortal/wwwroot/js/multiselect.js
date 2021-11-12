//Author: Vincent Futrell
//Date last modified: 11/08/2021
//This file contains the js code for the vf-multiselect dropdown
var expanded = false;

//Once the page is ready, request the medications from the database and populate the list
$(document).ready(function () {
    getMedications();
});

function selectMedication(id) {
    var all_medication_boxes = $(".vf-option-box");
    for (let i = 0; i < all_medication_boxes.length; i++) {
        let med_box = all_medication_boxes[i];
        if (med_box.value == id) {
            med_box.checked = true;
            return;
        }
    }
}

//Below are the two handler functions and the two helper functions for the dropdown bar
function vf_multiselect_dropclick() {
    let medIds = $(".vf-medId");
    for (let i = 0; i < medIds.length; i++) {
        let this_id = medIds[i].innerHTML;
        selectMedication(this_id);
    }
    if (!expanded) {expandOptionList("");}
    else {hideOptionsList();}
}

function vf_multiselect_search() {
    let user_input = $("#medication_input").val();
    if (user_input == null) {
        expandOptionList("");
    }
    else {
        expandOptionList(user_input);
    }
}

function expandOptionList(search_string) {
    $("#MedicationsSelect").focus();

    var all_meds = $(".vf-option-container");

    //hide all nonmatching medications
    if (search_string != "") {
        for (let i = 0; i < all_meds.length; i++) {
            let current_med = all_meds[i];
            if (!current_med.id.toLowerCase().includes(search_string.toLowerCase())) {
                current_med.style.display = "none";
            }
        }
    }
    //or display all
    else {
        for (let i = 0; i < all_meds.length; i++) {
            let current_med = all_meds[i];
            current_med.style.display = "block";
        }
    }

    //display the options list
    let option_list = $("#optionList");
    option_list[0].style.display = "block";
    expanded = true;
    switchIcons(expanded);
}


/*
 * Hides the options list
 * 
 **/
function hideOptionsList() {
    if (!expanded) { return;}
    let option_list = $("#optionList");
    option_list[0].style.display = "none";
    expanded = false;
    switchIcons(expanded);
}

function switchIcons(expanded) {
    var up_icon = $("#up-icon");
    var down_icon = $("#down-icon");
    if (expanded) {
        up_icon.type = "image";
        down_icon.type = "hidden";
    }
    else {
        up_icon.type = "hidden";
        down_icon.type = "image";
    }
}



//*****************************Below are the functions for creating the dropdown list of options
function getMedications() {
    var option_list = $(".vf-option-list");

    $.ajax({
        type: "GET",
        url: "/api/medicationsget/getmultiselect/true/",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {

            for (let i = response.length - 1; i >= 0; i--) {
                let medication = response[i];
                let option_container = createOptionContainer(medication);
                let med_option = createOptionBox(medication);
                let med_label = createOptionLabel(medication);

                option_container.appendChild(med_option);
                option_container.appendChild(med_label);

                option_list[0].appendChild(option_container);
            }
        }
    });
}

function createOptionBox(medication) {
    let med_option = document.createElement("input");
    med_option.type = 'checkbox';
    med_option.value = medication.ID;
    med_option.id = medication.Name + "-box";
    med_option.classList = 'vf-option-box';
    med_option.onclick = "checkBoxChange(this)";
    return med_option;
}

function createOptionLabel(medication) {

    let med_label = document.createElement("label");
    med_label.htmlFor = medication.Name + "-box";
    med_label.innerHTML = medication.Name;

    return med_label;
}

function createOptionContainer(medication) {
    let option_container = document.createElement("div");
    option_container.classList = 'vf-option-container'
    option_container.id = medication.Name + "-option-container"
    return option_container;
}


//Below is the code to handle the selection of options from the dropdown list
function submitSelectedMedications() {
    let the_select = document.createElement("select");
    the_select.display = "none";
    the_select.multiple = "multiple";
    the_select.name = "MedicationsIdList";

    var selected_list = $(".vf-option-box");

    for (let i = 0; i < selected_list.length; i++) {
        if (selected_list[i].checked) {
            let new_selected = document.createElement("option");
            new_selected.selected = true;
            new_selected.value = selected_list[i].value;
            the_select.appendChild(new_selected);
        }
    }

    let med_select = $("#MedicationsSelect");
    med_select[0].appendChild(the_select);
}

