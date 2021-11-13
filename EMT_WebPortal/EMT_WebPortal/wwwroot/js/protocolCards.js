/*
 * Author: Vincent Futrell
 * Date Last Modified: 11/12/2021
 * 
 */
$(document).ready(populateCards());

function populateCards() {

    getProtocolNames();

    //getProtocols();


    //foreach protocol make a tab
    //foreach tab assign to a card
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

    new_label_div.classList = "procard-label-div col-12";
    new_name_label.innerHTML = name;
    new_name_label.classList = "col-12";
    new_patient_label.innerHTML = patient_type;
    new_patient_label.classList = "col-12";

    new_label_div.appendChild(new_name_label);
    new_label_div.appendChild(new_patient_label);
    card.appendChild(new_label_div);
}


/*
 * The following functions are used to get the necessary data from the server via API endpoints ******************************/


/**
 * Returns an array of unique protocol names
 * */
function getProtocolNames() {

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
 * Returns an array of all protocols on the DB
 * */
function getProtocols() {
    var values;
   $.ajax({
        type: "GET",
        url: "/api/protocolsget",
        contentType: "application/json; charset=utf-8",
       success: function (data) {

        }
    });

    return val;
}
