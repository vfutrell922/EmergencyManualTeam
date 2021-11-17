/**
 * Author: Vincent Futrell
 * Date Last Modified: 10/24/2021
 * This file contains the scripts for the Charts create page 
 * */

var selectElement = document.querySelector("input[name='file']");
selectElement.addEventListener('change', fillName);

function fillName()
{
    let fileList = selectElement.files;
    let fileName = fileList[0].name;
    var nameField = document.querySelector("input[id='fileName']");
    nameField.value = fileName;
}

