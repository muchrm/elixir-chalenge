// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
let repositories = [];
let filteredRepositories = [];
function changePage(page) {
    if (page < 1) {
        page = 1;
    } else if (page > 10) {
        page = 10;
    }
    filteredRepositories = repositories.slice((page - 1) * 10, page * 10)
    updateList()
    updatePagination(page)
}

function updateList() {
    var myNode = document.getElementById("body");
    while (myNode.firstChild) {
        myNode.removeChild(myNode.firstChild);
    }
    filteredRepositories.forEach(repo => {
        var div = `
        <tr>
        <td><a href="${repo.html_url}" target="_blank">${repo.full_name}</a></td>
        <td>${repo.description}</td>
        <td>${repo.stargazers_count}</td>
        <td>${repo.forks_count}</td>
        </tr>`;
        myNode.insertAdjacentHTML('beforeend', div)
    });
}

function updatePagination(page) {
    var pagination = document.getElementById("pagination");
    pagination.childNodes.forEach(child => {
        child.className = ""
    })
    document.getElementById("li" + page).className = "active"
}
document.getElementById("pagination").addEventListener("click", (e) => {
    if (e.target.id && e.target.nodeName == "A") {
        changePage(e.target.id)
    }
});

fetch('/list').then((response) => {
    return response.json();
}).then((data) => {
    repositories = data;
    var pagination = document.getElementById("pagination");
    pagination.style.display = 'block'
})
