function CreateReminderTable(result) {
    if (result.length > 0) {
        var reminderStatusDiv = document.getElementById("reminderStatusDiv");

        reminderStatusDiv.style.display = "none"
        var table = document.getElementById("reminderAutomationTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);
        var header3 = header.insertCell(2);
        var header4 = header.insertCell(3);
        header1.innerHTML = "Reminder Name";
        header2.innerHTML = "Date Created";
        header3.innerHTML = "Task";
        header4.innerHTML = "Cycle";
        header1.className = " bg-light text-gray-500  ";
        header2.className = " bg-light text-gray-500 ";
        header3.className = " bg-light text-gray-500 ";
        header4.className = "text-right bg-light text-gray-500";
    }
    else {
        var table = document.getElementById("reminderAutomationTable");
        var reminderStatusDiv = document.getElementById("reminderStatusDiv");
        table.style.display = "none"
        reminderStatusDiv.style.display = "block"

    }
}
function FillReminderTable(rowCount, result) {
    var table = document.getElementById("reminderAutomationTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);

        cell1.innerHTML = result[i]["Name"]

        cell2.innerHTML = result[i]["Date"]
        cell3.innerHTML = result[i]["Task"]
        cell4.innerHTML = result[i]["Cycle"]
    }
}
function CreateReportTable(result) {
    if (result.length > 0) {
        var session = document.getElementById("session");
        var reportStatusDiv = document.getElementById("reportStatusDiv");

        reportStatusDiv.style.display = "none"
        var table = document.getElementById("reportAutomationTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);
        var header3 = header.insertCell(2);
        var header4 = header.insertCell(3);
        var header5 = header.insertCell(4);
        header1.innerHTML = "Report Type";
        header2.innerHTML = "Recipient";
        header3.innerHTML = "Date";
        header4.innerHTML = "Cycle";
        header5.innerHTML = "Notes";
        header1.className = " bg-light text-gray-500  ";
        header2.className = " bg-light text-gray-500 ";
        header3.className = " bg-light text-gray-500 ";
        header4.className = " bg-light text-gray-500 ";
        header5.className = "text-right bg-light text-gray-500";
    }
    else {
        var table = document.getElementById("reportAutomationTable");
        var reportStatusDiv = document.getElementById("reportStatusDiv");
        table.style.display = "none"
        reportStatusDiv.style.display = "block"

    }
}
function FillReportTable(rowCount, result) {
    var table = document.getElementById("reportAutomationTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);

        cell1.innerHTML = result[i]["ReportType"]

        cell2.innerHTML = result[i]["RecipientAddress"]
        cell3.innerHTML = result[i]["Cycle"]
        cell4.innerHTML = result[i]["StartDate"]
        cell5.innerHTML = result[i]["Notes"]
        //End appending

        //
    }
}
function CreateDiseaseTable(result) {
    if (result.length > 0) {
        var session = document.getElementById("session");
        var diseaseStatusDiv = document.getElementById("diseaseStatusDiv");

        diseaseStatusDiv.style.display = "none"
        var table = document.getElementById("diseaseTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);

        header1.innerHTML = "Disease Name";
        header2.className = "text-right"
        header2.innerHTML = "Severity";
    }
    else {
        var table = document.getElementById("diseaseTable");
        var diseaseStatusDiv = document.getElementById("diseaseStatusDiv");
        table.style.display = "none"
        reportStatusDiv.style.display = "block"

    }
}
function FillDiseaseTable(rowCount, result) {
    var table = document.getElementById("diseaseTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        row.className = "border-bottom"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell2.className = "text-right"
        cell1.innerHTML = result[i]["DiseaseName"]
        cell2.innerHTML = result[i]["Severity"]
    }
}
function CreateDiseaseStatusTable(result) {
    if (result.length > 0) {
        var diseaseStatusStatusDiv = document.getElementById("diseaseStatusStatusDiv");

        diseaseStatusStatusDiv.style.display = "none"
        var table = document.getElementById("diseaseStatusTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);

        header1.innerHTML = "Disease Name";
        header2.className = "text-right"
        header2.innerHTML = "Status";
    }
    else {
        var table = document.getElementById("diseaseStatusTable");
        var diseaseStatusDiv = document.getElementById("diseaseStatusDiv");
        table.style.display = "none"
        reportStatusDiv.style.display = "block"

    }
}
function FillDiseaseStatusTable(rowCount, result) {
    var table = document.getElementById("diseaseStatusTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        row.className = "border-bottom"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell2.className = "text-right"
        cell1.innerHTML = result[i]["DiseaseName"]
        cell2.innerHTML = result[i]["Status"]
    }
}

function CreateDiseaseTreatmentTable(result) {
    if (result.length > 0) {
        var diseaseTreatmentStatusDiv = document.getElementById("diseaseTreatmentStatusDiv");

        diseaseStatusDiv.style.display = "none"
        var table = document.getElementById("diseaseTreatmentTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);

        header1.innerHTML = "Disease Name";
        header2.className = "text-right"
        header2.innerHTML = "Treatment Type";
    }
    else {
        var table = document.getElementById("diseaseTreatmentTable");
        var diseaseTreatmentStatusDiv = document.getElementById("diseaseTreatmentStatusDiv");
        table.style.display = "none"
        diseaseTreatmentStatusDiv.style.display = "block"

    }
}
function FillDiseaseTreatmentTable(rowCount, result) {
    var table = document.getElementById("diseaseTreatmentTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        row.className = "border-bottom"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell2.className = "text-right"
        cell1.innerHTML = result[i]["DiseaseName"]
        cell2.innerHTML = result[i]["TreatmentType"]
    }
}
function CreateMedicineTable(result) {
    if (result.length > 0) {
        var medicineStatusDiv = document.getElementById("medicineStatusDiv");

        medicineStatusDiv.style.display = "none"
        var table = document.getElementById("medicineTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);
        var header3 = header.insertCell(2);

        header1.innerHTML = "Med Name";
        header2.innerHTML = "Type";
        header3.className = "text-right"
        header3.innerHTML = "Precaution";
    }
    else {
        var table = document.getElementById("medicineTable");
        var medicineStatusDiv = document.getElementById("medicineStatusDiv");
        table.style.display = "none"
        medicineStatusDiv.style.display = "block"

    }
}
function FillMedicineTable(rowCount, result) {
    var table = document.getElementById("medicineTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        row.className = "border-bottom"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        cell2.className = "text-right"
        cell1.innerHTML = result[i]["MedicineName"]
        cell2.innerHTML = result[i]["Type"]
        cell3.innerHTML = result[i]["Precaution"]
    }
}

function CreateDiseaseTypeTable(result) {
    if (result.length > 0) {
        var diseaseTypeStatusDiv = document.getElementById("diseaseTypeStatusDiv");

        diseaseTypeStatusDiv.style.display = "none"
        var table = document.getElementById("diseaseTypeTable");
        table.innerHTML = "";
        table.style.display = "table"


        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);

        header1.innerHTML = "Disease Name";
        header2.innerHTML = "Type";
        header2.className = "text-right"
    }
    else {
        var table = document.getElementById("diseaseTypeTable");
        var diseaseTypeStatusDiv = document.getElementById("diseaseTypeStatusDiv");
        table.style.display = "none"
        diseaseTypeStatusDiv.style.display = "block"

    }
}
function FillDiseaseTypeTable(rowCount, result) {
    var table = document.getElementById("diseaseTypeTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        row.className = "border-bottom"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell2.className = "text-right"
        cell1.innerHTML = result[i]["DiseaseName"]
        cell2.innerHTML = result[i]["DiseaseType"]
    }
}
function CreateMyTable() {
    var diseaseTypeStatusDiv = document.getElementById("diseaseTypeStatusDiv");
    let newTable = document.createElement('table')
    newTable.className = "table"
    var headerN = newTable.insertRow(0);
    headerN.className = "thead-dark";
    var header1N = headerN.insertCell(0);
    var header2N = headerN.insertCell(1);

    header1N.innerHTML = "Disease Name";
    header2N.innerHTML = "Type";
    header2N.className = "text-right"








    var table = document.getElementById("myTable");
    var header = table.insertRow(0);
    header.className = "thead-dark";
    var header1 = header.insertCell(0);
    var header2 = header.insertCell(1);
    var header3 = header.insertCell(2)
    header3.appendChild(newTable)
    header1.innerHTML = "Disease Name";
    header2.innerHTML = "Type";
    header2.className = "text-right"
}
function FillMyTable() {
    var table = document.getElementById("myTable");
    result = ["D1", "D2"]
    for (var i = 0; i < result.length; i++) {
        var row = table.insertRow(i + 1);
        row.className = "border-bottom"
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell2.className = "text-right"
        cell1.innerHTML = result[i]
        cell2.innerHTML = result[i]
    }
}
$(document).ready(function () {
    CreateMyTable()
    FillMyTable()
})