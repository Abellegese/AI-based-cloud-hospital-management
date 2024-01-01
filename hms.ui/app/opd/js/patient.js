function GetRowIndex(row) {
    let table = document.getElementById("patientTable");
    let id = table.rows[row.rowIndex].cells[1].innerText
    document
        .getElementById("regNumber")
        .innerText = id

    $('#patientDetailModal').modal('show')
}
function GetPatientDetails(id) {

}