function GetRowIndex(row) {
    let table = document.getElementById("patientTable");
    let id = table.rows[row.rowIndex].cells[1].innerText
    let date = table.rows[row.rowIndex].cells[0].innerText
    let name = table.rows[row.rowIndex].cells[2].innerText
    document
        .getElementById("regNumber")
        .innerText = id
    document
        .getElementById("name")
        .innerText = name
    document
        .getElementById("registrationDate")
        .innerHTML = date

    $('#patientDetailModal').modal('show')
}

function SendRequest() {

    let RegNo = document
        .getElementById("regNumber")
        .innerText
    let Name = document
        .getElementById("name")
        .innerText
    let Opd = $("#ddlItemName option:selected")
        .text()

    PageMethods.SendRequest(RegNo, Name, Opd, OnSucceded)
}
function OnSucceded(data) {
    if (data == true)
        OnRequestCommandExecuted();
}
function OnRequestCommandExecuted() {
    alert('Request already sent!!')
}
function ShowDeleteModal() {
    $('#DeleteModal').modal('show')
    $('#patientDetailModal').modal('hide')
}
function ShowRequestModal() {
    $('#RequestModal').modal('show')
    $('#patientDetailModal').modal('hide')
}
function ShowEdirModal() {
    $('#EditPatientModal').modal('show')
    $('#patientDetailModal').modal('hide')
}
function ShowHistoryModal() {
    document.getElementById("regPatientHistoryNumber").innerText = 
    document.getElementById("regNumber").innerText
    $('#PatientHistoryModal').modal('show')
    $('#patientDetailModal').modal('hide')
}
function DeletePatient() {
    let regNo = document
        .getElementById("regNumber")
        .innerText
    PageMethods.DeletePatient(regNo)
}
function UpdatePatient() {
    let regNo = document
        .getElementById("regNumber")
        .innerText
    let name = $('#txtEditPatientName').val()
    let address = $('#txtEditAdddress').val()
    let city = $('#txtEditCity').val()
    let mobile = $('#txtEditMobile').val()
    let email = $('#txtEditEmail').val()
    let maritalStatus = $('#ddlEditMaritalStatus option:selected').text()
    let religion = $('#ddlEditReligion option:selected').text()

    PageMethods.UpdatePatient(
        regNo,
        name,
        address,
        city,
        mobile,
        email,
        maritalStatus,
        religion
    )



}
function SearchVal() {
    var patientModel = {
        RegNo: $("#txtSearchPatient").val(),
        Name: $("#txtSearchPatient").val()
    };
    $.ajax({
        type: "POST",
        url: "patient.aspx/GetSearchValues",
        data: '{ patientModel: ' + JSON.stringify(patientModel) + ' }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}
function OnGet(data) {
    console.log(data)
}
$(document).ready(function () {

    SearchText();
});

function SearchText() {


    $("#txtSearch").autocomplete({

        source: function (request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "search.aspx/GetSearchValues",
                data: '{ patientModel: ' + JSON.stringify({
                    RegNo: $("#txtSearch").val(),
                    Name: $("#txtSearch").val()
                }) + ' }',
                dataType: "json",
                success: function (data) {
                    response(data.d);
                },
                error: function (result) {
                    alert($("#txtSearch").val())
                    alert("No Match");
                }
            });
        },
        autoFocus: true
    });
}