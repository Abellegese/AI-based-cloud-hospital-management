
//Get request count
function GetRequestCount() {
    PageMethods.GetRequestCount(OnRequestCountDataBinded);
}
GetRequestCount();
function OnRequestCountDataBinded(count) {
    let requestCount = document
        .getElementById("requestCount")
        .innerText = count
}
//Creatig Request Table
function GetRequestDetails() {
    PageMethods.GetPendingRequest(OnRequestDataBinded);
}
function OnRequestDataBinded(result) {
    CreateTable(result);
    FillTable(result.length, result);
}
function CreateTable(result) {
    if (result.length > 0) {
        var session = document.getElementById("session");
        var requestDiv = document.getElementById("requestDiv");
        session.style.display = "initial"
      
        requestDiv.style.display = "none"
        var table = document.getElementById("requestTable");
        table.innerHTML = "";
        table.style.display = "table"
        

        var header = table.insertRow(0);
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);
        var header3 = header.insertCell(2);
        var header4 = header.insertCell(3);
        header1.innerHTML = "Reg No";
        header2.innerHTML = "Name";
        header4.innerHTML = "Date";
        header3.innerHTML = "Status";
        header1.className = " bg-light text-gray-500  text-uppercase";
        header2.className = " bg-light text-gray-500 text-uppercase";
        header3.className = " bg-light text-gray-500 text-right text-uppercase";
        header4.className = "text-right bg-light text-uppercase text-gray-500";
    }
    else {
        var table = document.getElementById("requestTable");
        var session = document.getElementById("session");
        var requestDiv = document.getElementById("requestDiv");
        session.style.display = "none"
        table.style.display = "none"
        requestDiv.style.display = "block"

    }
}

function GetRowIndex(row) {
    let table = document.getElementById("requestTable");
    let id = table.rows[row.rowIndex].cells[0].innerText
    let status = table.rows[row.rowIndex].cells[3].innerText
    document
        .getElementById("regNumber")
        .innerText = id
    $('#RequestModal').modal('hide');
    if (status == "completed") {
        document
            .getElementById("regHistoryNumber")
            .innerText = id
        $('#HistoryModal').modal('show');
    }
    else {
        $('#ExamineModal').modal('show');
    }
}
function FillTable(rowCount, result) {
    var table = document.getElementById("requestTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        //Declaring custome element creation
        const icon = document.createElement('span')
        const regNoSpan = document.createElement('span')
        const regIcon = document.createElement('span')
        regIcon.className = 'bi  bi-file-medical  text-gray-300'
        icon.className = 'bi bi-calendar  text-gray-300';
        const datespan = document.createElement('span')
        datespan.className = ' text-gray-500 font-weight-light badge badge-light mr-1'

        regNoSpan.className = ' text-gray-500 font-weight-light badge badge-light mr-1'

        //End creation

        row.onclick = function () { GetRowIndex(this)  }

        regNoSpan.innerHTML = result[i]["RegNo"];
        //regNoSpan.onclick = GetRowIndex()
        datespan.innerHTML = result[i]["Date"];
        cell2.innerHTML = result[i]["Name"];
        const tags = document.createElement('span')
        tags.innerHTML = result[i]["Status"];

        if (tags.innerHTML == "pending") {
            tags.className = "badge badge-danger";
        }
        else if (tags.innerHTML == "examining") {
            tags.className = "badge badge-warning";
        }
        else {
            tags.className = "badge badge-success";
        }
        cell4.className = "text-right ";
        cell3.className = "text-right ";

        //Appending the created element
        cell1.appendChild(regIcon)

        cell1.appendChild(regNoSpan)
        cell4.appendChild(icon)
        cell4.appendChild(datespan)
        cell3.appendChild(tags)
        //End appending

        //
    }
}

function ExamineWithoutTest() {
    document
        .getElementById("regHistoryNumber")
        .innerText = document
        .getElementById("regNumber")
        .innerText
    $('#ExamineModal').modal('hide');
    $('#HistoryModal').modal('show');
}
function ShowPatientHistory() {
    document
        .getElementById("regPatientHistoryNumber")
        .innerText = document
        .getElementById("regHistoryNumber")
        .innerText
    $('#HistoryModal').modal('hide');
    $('#PatientHistoryModal').modal('show');
    GetPatientHistory()
}
function BackToHistory() {
    $('#HistoryModal').modal('show');
    $('#PatientHistoryModal').modal('hide');
}
function SendTestRequest() {
    let regNumber = document
        .getElementById("regNumber")
        .innerText
    let editor = CKEDITOR.replace('editor2');

    let remark = CKEDITOR.instances.editor2.getData()
    console.log(remark)
    let bioChemCheckBox = document
        .getElementById("bioChemCheckBox")
        .checked
    let stoolCheckBox = document
        .getElementById("stoolCheckBox")
        .checked
    let bloodChechBox = document
        .getElementById("bloodChechBox")
        .checked
    let colonCheckBox = document
        .getElementById("colonCheckBox")
        .checked
    let gastrosCheckBox = document
        .getElementById("gastrosCheckBox")
        .checked
    let urineCheckBox = document
        .getElementById("urineCheckBox")
        .checked
    let xrayChechBox = document
        .getElementById("xrayChechBox")
        .checked
    let sonogCheckBox = document
        .getElementById("sonogCheckBox")
        .checked
    let ecgCheckBox = document
        .getElementById("ecgCheckBox")
        .checked
    let otherCheckBox = document
        .getElementById("otherCheckBox")
        .checked
    PageMethods.SendTestRequest
        (
            regNumber,
            remark,
            bioChemCheckBox,
            stoolCheckBox,
            bloodChechBox,
            colonCheckBox,
            gastrosCheckBox,
            urineCheckBox,
            xrayChechBox,
            sonogCheckBox,
            ecgCheckBox,
            otherCheckBox
        )
}

function GetDiagnosisRequest() {

    let regNo = document
        .getElementById3("regHistoryNumber")
        .innerText

    PageMethods.GetDiagnosisRequest(regNo, OnDiagDataBinded)
}
function OnDiagDataBinded(data) {
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
    if (data[5] == "True")
        bioChemIcon.className = "bi bi-check-circle text-success"
    if (data[6] == "True")
        stoolIcon.className = "bi bi-check-circle text-success"
    if (data[7] == "True")
        bloodIcon.className = "bi bi-check-circle text-success"
    if (data[8] == "True")
        colonIcon.className = "bi bi-check-circle text-success"
    if (data[9] == "True")
        gastrosIcon.className = "bi bi-check-circle text-success"
    if (data[10] == "True")
        urineIcon.className = "bi bi-check-circle text-success"
    if (data[11] == "True")
        xrayIcon.className = "bi bi-check-circle text-success"
    if (data[12] == "True")
        sonogIcon.className = "bi bi-check-circle text-success"
    if (data[13] == "True")
        otherIcon.className = "bi bi-check-circle text-success"
    if (data[15] == "True")
        ecgIcon.className = "bi bi-check-circle text-success"

    //Binding Remarks
    //remarks.innerHTML = data[4]
    //opd.innerHTML = data[17]
}
function ShowOtherTest() {
    $('#TestRequestModal').modal('hide');
    $('#otherTestRequestModal').modal('show');
}
function GetOtherTestResult() {
    let regNo = document
        .getElementById("regHistoryNumber")
        .innerText

    PageMethods.GetOtherTest(regNo, OnOtherTestDataBinded)
}
function OnOtherTestDataBinded(data) {

    document
        .getElementById("otherTestResultDiv")
        .innerHTML = data[0]

}

function EndDiagSession() {
    let regNo = document
        .getElementById("regHistoryNumber")
        .innerText
    let finalDiag = tinymce.get("historyEditor").getContent()

    PageMethods.EndDiagSession(finalDiag, regNo)

    //Hiding and Firing Notification
    $('#HistoryModal').modal('hide');
    $('#RequestModal').modal('show');

    ShowGeneralSnackbar("Session was successfully closed!");
}

function CreateAppointment() {
    let regNo = document
        .getElementById("regHistoryNumber")
        .innerText
    let notes = $("#txtNotes").val()
    let dueDate = $("#txtDueDate").val()

    PageMethods.CreateAppointment(notes, dueDate, regNo)

    $('#AppointmentModal').modal('hide');

    ShowGeneralSnackbar("Appointment was successfully recorded and scheduled!");
}
function CreateInjectionSchedule() {
    let regNo = document
        .getElementById("regHistoryNumber")
        .innerText
    let notes = $("#txtInjectionNotes").val()
    let injectionName = $("#txtInjectionName").val()
    let dueDate = $("#txtInjectionDueDate").val()

    PageMethods.CreateInjectionSchedule(notes, dueDate, regNo, injectionName)

    $('#InjectionModal').modal('hide');

    ShowGeneralSnackbar("Injection was successfully recorded and scheduled!");
}
function CreateMedicineSchedule() {
    let regNo = document
        .getElementById("regHistoryNumber")
        .innerText
    let notes = $("#txtDosaAndNotes").val()
    let medName = $("#txtMedicineName").val()

    PageMethods.CreateMedicieSchedule(notes, medName, regNo)

    $('#MedicineModal').modal('hide');

    ShowGeneralSnackbar("Medicine was successfully recorded to catalog!");
}
function EndAllSession() {
    PageMethods.EndAllDiagSession()
    $('#SessionModal').modal('hide')
    GetRequestDetails()
}
function GetRequestOnProgress() {
    PageMethods.GetRequestProgress(OnRequestOnProgressBinded)
}
function OnRequestOnProgressBinded(data) {

    let pendingProgress = document.getElementById("requestPending")
    let examiningProgress = document.getElementById("requestExamining")
    let pendingPercentage, examiningPercentage

    pendingPercentage = (data[0] / (data[0] + data[1])) * 100
    examiningPercentage = (data[1] / (data[0] + data[1])) * 100
    pendingProgress.style.width = pendingPercentage + "%"
    examiningProgress.style.width = examiningPercentage + "%"


    let pendingRequest = document.getElementById("pendingRequest")
    let examiningRequest = document.getElementById("examiningRequest")

    pendingRequest.innerText = data[0]
    pendingRequest.innerText = data[1]

}
GetRequestOnProgress();

$(document).ready(function () {
    $('#ddlDiseaseType').select2(

    );
    //$('#ddlDiseaseCondion').select2(

    //);
    tinymce.init({
        selector: 'textarea#historyEditor',
        browser_spellcheck: true,
        contextmenu: true,
        plugins: [
            'a11ychecker', 'advlist', 'advcode', 'advtable', 'autolink', 'checklist', 'export',
            'lists', 'link', 'image', 'charmap', 'preview', 'anchor', 'searchreplace', 'visualblocks',
            'powerpaste', 'fullscreen', 'formatpainter', 'insertdatetime', 'media', 'table', 'help', 'wordcount'
        ],
        toolbar: 'undo redo | formatpainter casechange blocks | bold italic backcolor | ' +
            'alignleft aligncenter alignright alignjustify | ' +
            'bullist numlist checklist outdent indent | removeformat | a11ycheck code table help'
    });
    tinymce.init({
        selector: 'textarea#examinationEditor',
        browser_spellcheck: true,
        contextmenu: true,
        plugins: [
            'a11ychecker', 'advlist', 'advcode', 'advtable', 'autolink', 'checklist', 'export',
            'lists', 'link', 'image', 'charmap', 'preview', 'anchor', 'searchreplace', 'visualblocks',
            'powerpaste', 'fullscreen', 'formatpainter', 'insertdatetime', 'media', 'table', 'help', 'wordcount'
        ],
        toolbar: 'undo redo | formatpainter casechange blocks | bold italic backcolor | ' +
            'alignleft aligncenter alignright alignjustify | ' +
            'bullist numlist checklist outdent indent | removeformat | a11ycheck code table help'
    });

});
function SaveDiseasePositiveData() {
    let regNo = document
        .getElementById("regHistoryNumber").innerText

    let diseaseName = $('#ddlDiseaseNamePositive option:selected').val()
    let diseaseType = $('#ddlDiseaseType option:selected').val()
    let severity = $('#ddlDiseaseCondion option:selected').val()
    let notes = $('#txtDiseaseRemark').val()


    PageMethods.SaveDiseasePositive(regNo, diseaseName, diseaseType, severity, notes)
}
function SaveFollowUpTreatmentType() {
    let diseaseName = $('#ddlDiseaseNameFollowUp option:selected').val()

    let regNo = document
        .getElementById("regHistoryNumber").innerText
    let treatmentType = $('#ddlDiseaseTreatmentTypeFollowUp option:selected').val()

    PageMethods.SaveFollowUpTreatmentType(regNo, treatmentType, diseaseName, OnFollowUpTreatmentTypeSaving)
}
function OnFollowUpTreatmentTypeSaving(data) {
    if (data > 0) {
        alert("Treatment Type for the selected disease was already saved!")
    }
    else {
        alert("Successfully saved!")
    }
}
function SaveFollowUp() {
    let regNo = document
        .getElementById("regHistoryNumber").innerText
    let folloUpType = $('#ddlFollowUpType option:selected').val()
    let terminatioPeriod = $('#txtFollowUpPeriod').val()
    PageMethods.SaveFollowUp(regNo, folloUpType, terminatioPeriod, OnFollowUp)
}
function OnFollowUp(data) {
    if (data > 0) {
        alert("Follow Up was already saved!")
    }
    else {
        alert("Successfully saved!")
    }
}
function SaveFollowUpDisease() {
    let regNo = document
        .getElementById("regHistoryNumber").innerText
    let diseaseName = $('#ddlDiseaseNameFollowUp option:selected').val()
    
    PageMethods.SaveFollowUpDisease(regNo, diseaseName, OnFollowUpDisease)
}
function OnFollowUpDisease(data) {
    if (data > 0) {
        alert("Disease for this Follow Up was already saved!")
    }
    else {
        alert("Successfully saved!")
    }
}
