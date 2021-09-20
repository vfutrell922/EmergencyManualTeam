var selectElement = document.querySelector("input[name='file']");
selectElement.addEventListener('change', fillName);

function fillName()
{
    let fileList = selectElement.files;
    let fileName = fileList[0].name;
    var nameField = document.querySelector("input[id='fileName']");
    nameField.value = fileName;
}

