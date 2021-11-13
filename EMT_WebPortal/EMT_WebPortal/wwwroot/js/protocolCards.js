/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/12/2021
 * 
 */
$(document).ready(populateCards());


/**
 * Populates the view with protocol cards
 * */
function populateCards() {

    BuildProtocolCards();
    PopulateTabs();
}


/**
 * The following functions are used to create the protocol cards ********************************************************
 * */

/**
 * Adds a card with the associated name and patient type to the view
 * @param {any} protocol_name
 * @param {any} patient_type
 */
function addCard(protocol_name, patient_type) {
    //get the card container
    var card_table = $("#cardTable");
    var new_card = createCard(protocol_name, patient_type);
    card_table[0].appendChild(new_card);
}

/**
 * Returns a new card as a 'div' element
 * @param {any} name
 * @param {any} patient_type
 */
function createCard(name, patient_type) {
    var new_card = document.createElement('div');
    new_card.id = name + "-" + patient_type + "-" + "card";
    new_card.classList = "protocol-card col-5 col-md-offset-2";
    addLabel(new_card, name, patient_type);
    return new_card;
}

/**
 * Adds a label 
 * @param {any} card
 */
function addLabel(card, name, patient_type) {
    var new_label_div = document.createElement('div');
    var new_name_label = document.createElement('p');
    var new_patient_label = document.createElement('p');

    new_label_div.classList = "procard-card-label col-12";
    new_name_label.innerHTML = name;
    new_name_label.classList = "col-12";
    new_patient_label.innerHTML = patient_type;
    new_patient_label.classList = "col-12";

    new_label_div.appendChild(new_name_label);
    new_label_div.appendChild(new_patient_label);
    card.appendChild(new_label_div);
}


/**
 * The following functions are used to construct the protocol tabs and append them to their associated card
 * */

/**
 * Creates and adds a tab to the associated card for the provided protocol
 * @param {any} protocol
 */
function addTab(protocol) {
    var tab = createTab(protocol);
    var card = getRelatedCard(protocol.Name, protocol.PatientType);
    card.appendChild(tab);
}

/**
 * Returns a tab for the protocol as a div element
 * @param {any} protocol
 */
function createTab(protocol) {

    var tab = buildTabContainer();
    var label = buildTabLabel(protocol);
    var button_container = buildButtonContainer(protocol.Id);

    tab.appendChild(label);
    tab.appendChild(button_container);

    return tab;
}

/**
 * Returns a 'div' element of the procard-tab-container class
 * */
function buildTabContainer() {
    var tab_container = document.createElement('div');
    tab_container.classList = "col-12 procard-tab-container";
    return tab_container;
}


/**
 * Returns the tab label with the protocols certification
 * @param {any} protocol
 */
function buildTabLabel(protocol) {
    var tab_label_container = document.createElement('div');
    var tab_label = document.createElement('p');
    let certification = getCertificationString(protocol.Certification);

    tab_label_container.classList = "col-3 procard-tab-label-" + certification;
    tab_label.innerText = certification;
    tab_label_container.appendChild(tab_label);

    return tab_label_container;
}

/**
 * */
function buildButtonContainer(id) {
    var button_container = document.createElement('div');

    button_container.classList = "row col-9 procard-button-container";

    var details_button = createDetailsButton(id);
    var edit_button = createEditButton(id);
    var delete_button = createDeleteButton(id);

    button_container.appendChild(details_button);
    button_container.appendChild(delete_button);
    button_container.appendChild(edit_button);

    return button_container;
}

function createDetailsButton(id) {
    var new_button = document.createElement('input');
    let link = "/Protocols/Details/" + id;
    new_button.type = "button";
    new_button.classList = "col-6 btn btn-outline-info";
    new_button.setAttribute("onclick", "location.href='" + link + "'");
    new_button.value = "Details";
    return new_button;
}

function createEditButton(id) {
    var new_button = document.createElement('input');
    let link = "/Protocols/Edit/" + id;
    new_button.type = "button";
    new_button.value = "Edit";
    new_button.classList = "col-12 btn btn-outline-primary";
    new_button.setAttribute("onclick", "location.href='" + link + "'");
    return new_button;
}

function createDeleteButton(id) {
    var new_button = document.createElement('button');
    new_button.type = "button";
    new_button.innerHTML = "Delete";
    new_button.classList = "col-6 btn btn-outline-danger";
    new_button.setAttribute("data-href", "/Protocols/Delete/" + id);
    new_button.setAttribute("data-toggle", "modal");
    new_button.setAttribute("data-target", "#confirmDelete");
    return new_button;
}

/**
 * Returns the card with the matching name and patient_type
 * @param {any} name
 * @param {any} patient_type
 */
function getRelatedCard(name, patient_type_id) {
    var all_cards = $(".protocol-card");
    let matching_id = name + "-" + getPatientString(patient_type_id) + "-" + "card";
    for (let i = 0; i < all_cards.length; i++) {
        if (all_cards[i].id == matching_id) {
            return all_cards[i];
        }
    }
}


/**
 * Returns the patient_type
 * @param {any} id
 */
function getPatientString(id) {
    switch (id) {
        case 0:
            return "ADULT";
        case 1:
            return "PEDIATRIC";
        case 2:
            return "ALL";
    }
}

/**
 * Returns the patient_type
 * @param {any} id
 */
function getCertificationString(id) {
    switch (id) {
        case 0:
            return "EMT";
        case 1:
            return "AEMT";
        case 2:
            return "PARA";
        case 3:
            return "ALL";
    }
}


/**
 * Builds a card for each permutation of <protocol.name, protocol.patient_type> and adds them to the view
 * */
function BuildProtocolCards() {

   $.ajax({
        type: "GET",
        url: "/api/protocolsget/getcardnames",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            for (let i = 0; i < data.length; i++) {
                addCard(data[i], "ADULT");
                addCard(data[i], "PEDIATRIC");
                addCard(data[i], "ALL")
            }
        }
    });

}

/**
 * Builds a tab for every protocol and appends it to the proper card
 * */
function PopulateTabs() {
    var values;
   $.ajax({
        type: "GET",
        url: "/api/protocolsget",
        contentType: "application/json; charset=utf-8",
       success: function (data) {
           let collections = data.split(']')
           var protocols = JSON.parse(collections[1] + "]");
           for (let i = 0; i < protocols.length; i++) {
               var protocol = protocols[i];
               addTab(protocol);
           }

       }
    });


}
