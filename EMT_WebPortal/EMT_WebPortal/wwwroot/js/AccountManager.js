function selectCaregiver() {
    var user = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + user);
    dropdownButton.textContent = 'Caregiver';
}

function selectAdministrator() {
    var user = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + user);
    dropdownButton.textContent = 'Administrator';
}

function selectWebMaster() {
    var user = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + user);
    dropdownButton.textContent = 'WebMaster';
}

