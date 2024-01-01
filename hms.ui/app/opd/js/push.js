$(function () {
    // Proxy created on the fly
    var updater = $.connection.dataUpdaterHub;
    var alert = $.connection.alertHub;
    // Declare a function on the job hub so the server can invoke it
    updater.client.updater = function () {
        GetRequestDetails();
        GetRequestCount();
        GetRequestOnProgress();
    };
    alert.client.displayOpdAlert = function () {
        myFunctionSnackUpdate();
    };
    alert.client.displayAutomationAlert = function () {
        GetAlert();
        myFunctionSnackUpdate();
    };
    // Sta
    // Start the connection
    $.connection.hub.start();
});
function myFunctionSnackUpdate() {
    // Get the snackbar DIV
    var bellSound = document.getElementById("bellSound");
    var x = document.getElementById("snackbar");
    // Add the "show" class to DIV
    x.className = "show";
    bellSound.play();
    // After 3 seconds, remove the show class from DIV
    setTimeout(function () { x.className = x.className.replace("show", ""); }, 6000);
}
function ShowGeneralSnackbar(message) {
    // Get the snackbar DIV
    var snack = document.getElementById("generalSnackbar");
    // Add the "show" class to DIV
    //Creating span element
    let messageSpan = document
        .createElement('span')
    messageSpan.innerText = message

    let bellIcon = document
        .createElement('span')

    bellIcon.className = "bi bi-bell mr-2"
    snack.innerHTML = ""
    snack.appendChild(bellIcon)
    snack.appendChild(messageSpan)

    snack.className = "show";

    // After 3 seconds, remove the show class from DIV
    setTimeout(function (){ snack.className = snack.className.replace("show", "")},3000);
}
function GetAlert() {
    var $tbl = $('#tbl');
    $.ajax({
        url: 'dashboard.aspx/GetAlertData',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        type: "POST",
        success: function (data) {
            if (data.d.length > 0) {
                $tbl.empty();
                var rows = [];
                for (var i = 0; i < data.d.length; i++) {
                    rows.push('<a href="' + data.d[i]["Query"] + '" class="dropdown-item  d-flex align-items-center"><div class="mr-3"> <div class="' + data.d[i]["Bg"]
                        + '"><span class="' + data.d[i]["Icon"] + '" style="font-size:18px"></span></div></div><div><div class="small text-gray-500">'
                        + data.d[i]["Date"] + '</div><span class="font-weight-bold">' + data.d[i]["Descr"] + '</span><div><span class="font-weight-normal">by '
                        + data.d[i]["Who"] + '</span></div></div></a><br />');
                }
                $tbl.append(rows.join(''));
            }
        },
        error: function (err) {
            console.log(err)
        }
    });
}
$(document).ready(function () {
    GetAlert();
});

