$(function () {
    // Proxy created on the fly
    var updater = $.connection.dataUpdaterHub;
    var alert = $.connection.alertHub;
    // Declare a function on the job hub so the server can invoke it
    updater.client.updater = function () {
        GetRequestDetails();
    };
    alert.client.displayLabAlert = function () {
        myFunctionSnackUpdate();
    };
    // Sta
    // Start the connection
    $.connection.hub.start();
});
function myFunctionSnackUpdate(name) {
    // Get the snackbar DIV
    var bellSound = document.getElementById("bellSound");
    var x = document.getElementById("snackbar");
    // Add the "show" class to DIV
    x.className = "show";
    bellSound.play();
    // After 3 seconds, remove the show class from DIV
    setTimeout(function () { x.className = x.className.replace("show", ""); }, 6000);
}