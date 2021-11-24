/**
 * Author: Vincent Futrell
 * Date Last Modified: 11/09/2021
 * This file contains the scripts for the account management page
 * */

//The following functions cause the dropdown's title to reflect the selection
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

function selectDirector() {
    var user = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + user);
    dropdownButton.textContent = 'Director';
}

/**
 * Changes the role of the assciated account
 * */
async function submitChange() {
    var userName = event.target.getAttribute('data-arg1');
    const dropdownButton = document.getElementById("dropdownMenuButton " + userName);
    var currentRole = document.getElementById("role-display " + userName).textContent;
    var role = dropdownButton.textContent;
    var output = {
        userName: userName,
        role: role
    };
    if (currentRole == role) {
        alert("Cannot Change: This account is already assigned this role.");
        return;
    }
    if (role != "Administrator" && isLastAdmin())
    {
        alert("Cannot Change: This account is the only administrator.");
        return;
    }
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

/**
 * Returns if there is more than one Administrator before the requested change is applied 
 * */
function isLastAdmin() {
    let adminCount = 0;
    let allUsersRoles = $(".roles-display");
    let userCount = allUsersRoles.length;

    for (let i = 0; i < userCount; i++)
    {
        if (allUsersRoles[i].textContent == "Administrator") {
            adminCount++;
        }
    }

    if (adminCount-1 > 0) {
        return false;
    }

    return true;
}

