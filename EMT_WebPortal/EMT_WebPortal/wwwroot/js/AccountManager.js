//The following functions cause the dropdown title to reflect the selection
function selectCaregiver() {
    var user = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + user);
    dropdownButton.textContent = 'CareGiver';
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

//Submits the role change to the database
async function submitChange() {
    var userName = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + userName);
    var role = dropdownButton.textContent;
    var output = {
        userName: userName,
        role: role
    };
    try {
        const response = await fetch('/AccountManager/roleChange', {
            method: 'POST',
            data: 'json',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(output)
        });
        if (response.status == 200) {
            alert("Role change succeeded");
            location.reload();
        }
        else {
            alert("An error occured");
        }
    }
    catch (error) {
        console.log(error);
    }
}

