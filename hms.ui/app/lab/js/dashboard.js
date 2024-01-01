function GetRequestDetails() {
    PageMethods.GetPendingRequest(OnRequestDataBinded);
}

function OnRequestDataBinded(result) {
    CreateTable();
    FillTable(result.length, result);
}
function GetRowIndex(row) {
    let table = document.getElementById("requestTable");
    let id = table.rows[row.rowIndex].cells[0].innerText

    document
        .getElementById("testRegNumber")
        .innerText = id
    $('#TestRequestModal').modal('show');
    $('#RequestModal').modal('hide');

    GetDiagnosisRequest()
}
function CreateTable() {
    var table = document.getElementById("requestTable");
    table.innerHTML = "";

    var header = table.insertRow(0);
    header.className = "thead-dark";
    var header1 = header.insertCell(0);
    var header2 = header.insertCell(1);
    var header3 = header.insertCell(2);
    var header4 = header.insertCell(3);
    header1.innerHTML = "Reg No";
    header2.innerHTML = "Name";
    header3.innerHTML = "Date";
    header4.innerHTML = "Status";
    header1.className = " bg-light text-gray-500  text-uppercase";
    header2.className = " bg-light text-gray-500 text-uppercase";
    header3.className = " bg-light text-gray-500 text-uppercase";
    header4.className = "text-right bg-light text-uppercase text-gray-500";
}

function FillTable(rowCount, result) {
    var table = document.getElementById("requestTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        const icon = document.createElement('span')
        const regIcon = document.createElement('span')

        regIcon.className = 'bi bi-file-medical text-gray-300'

        //Row click event beg
        row.onclick = function () { GetRowIndex(this) }
        //End event

        const regNoSpan = document.createElement('span')
        regNoSpan.innerHTML = result[i]["RegNo"];
        regNoSpan.className = ' text-gray-500 font-weight-light badge badge-light mr-1'
        icon.className = 'bi bi-calendar  text-gray-300';
        const datespan = document.createElement('span')
        datespan.innerHTML = result[i]["Date"];
        datespan.className = ' text-gray-500 font-weight-light badge badge-light mr-1'
        cell1.appendChild(regIcon)

        cell1.appendChild(regNoSpan)
        cell2.innerHTML = result[i]["Name"];
        cell3.appendChild(icon)
        cell3.appendChild(datespan)
        const tags = document.createElement('span')
        tags.className = "badge badge-warning";

        tags.innerHTML = result[i]["Status"];
        cell4.appendChild(tags);
        cell4.className = "text-right ";
    }
}


function GetDiagnosisRequest() {

let regNo = document
    .getElementById("testRegNumber")
    .innerText

    PageMethods.GetDiagnosisRequest(regNo, OnDiagDataBinded)
}
function OnDiagDataBinded(data) {
    console.log(data)
    let bioChemIcon = document
        .getElementById("bioChemIcon")
    let stoolIcon = document
        .getElementById("stoolIcon")
    let bloodIcon = document
        .getElementById("bloodIcon")
    let colonIcon = document
        .getElementById("colonIcon")
    let gastrosIcon = document
        .getElementById("gastrosIcon")
    let urineIcon = document
        .getElementById("urineIcon")
    let xrayIcon = document
        .getElementById("xrayIcon")
    let sonogIcon = document
        .getElementById("sonogIcon")
    let ecgIcon = document
        .getElementById("ecgIcon")
    let otherIcon = document
        .getElementById("otherIcon")

    let remarks = document
        .getElementById("remarks")
    let opd = document
        .getElementById("opd")
    //Giving icon colors based on their bool value
    //If True success else default
    if (data[0]["BioChemistry"] == "True")
        bioChemIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Stool"] == "True")
        stoolIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Blood"] == "True")
        bloodIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Colonoscopy"] == "True")
        colonIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Gastroscopy"] == "True")
        gastrosIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Urine"] == "True")
        urineIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["XRay"] == "True")
        xrayIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Sonograph"] == "True")
        sonogIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["Others"] == "True")
        otherIcon.className = "bi bi-bag-plus text-success"
    if (data[0]["ECG"] == "True")
        ecgIcon.className = "bi bi-bag-plus text-success"

    //Binding Remarks
    remarks.innerHTML = data[0]["Remark"]
    opd.innerHTML = data[17]
}
function ShowOtherTest() {
    $('#TestRequestModal').modal('hide');
    $('#OtherTestModal').modal('show');
    document
        .getElementById("otherTestRegNumber")
        .innerText = document
        .getElementById("testRegNumber")
        .innerText
}
function SendTestResult() {
    let regNo = document
        .getElementById("otherTestRegNumber")
        .innerText
    let opd = document
        .getElementById("opd")
        .innerText
    let description = CKEDITOR.instances.editorOtherTest.getData()

    PageMethods.SendTestResult
        (regNo, opd, description)
}