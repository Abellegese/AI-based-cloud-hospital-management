function GetPatientHistory() {
    let regNo = document
        .getElementById("regPatientHistoryNumber")
        .innerText

    PageMethods.GetPatientHistory(regNo, OnHistoryBinded)
}
function OnHistoryBinded(data) {
    console.log(data)
    CreateInitialTable(data);
    FillDataTable(data.length, data);
}
function CreateInitialTable(result) {
    if (result.length > 0) {
        var historyStatusDiv = document.getElementById("historyStatusDiv");

        historyStatusDiv.style.display = "none"
        var table = document.getElementById("historyTable");
        table.innerHTML = "";
        table.style.display = "table"
        var header = table.insertRow(0);
        header.className = "thead-dark";
        var header1 = header.insertCell(0);
        var header2 = header.insertCell(1);
        var header3 = header.insertCell(2);
        var header4 = header.insertCell(3);
        var header5 = header.insertCell(4);
        var header6 = header.insertCell(5);
        var header7 = header.insertCell(6);
        header1.innerHTML = "Diag. No";
        header2.innerHTML = "Date";
        header3.innerHTML = "Test";
        header4.innerHTML = "Result";
        header5.innerHTML = "Medicine";
        header6.innerHTML = "Appointment";
        header7.innerHTML = "Remark";
        header1.className = " bg-light text-gray-500 text-uppercase";
        header2.className = " bg-light text-gray-500 text-uppercase";
        header3.className = " bg-light text-gray-500 text-uppercase";
        header4.className = " bg-light text-gray-500 text-uppercase";
        header5.className = " bg-light text-gray-500 text-uppercase";
        header6.className = " bg-light text-gray-500 text-uppercase";
        header7.className = "text-right bg-light text-uppercase text-gray-500";
    }
    else {
        var table = document.getElementById("historyTable");
        var historyStatusDiv = document.getElementById("historyStatusDiv");
        table.style.display = "none"
        historyStatusDiv.style.display = "block"

    }
}
function FillDataTable(rowCount, Diagresult) {
    var table = document.getElementById("historyTable");
    for (var i = 0; i < rowCount; i++) {
        var row = table.insertRow(i + 1);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);

        cell1.innerHTML = Diagresult[i]["DiagNo"]
        cell2.innerHTML = Diagresult[i]["Date"]
        cell3.innerHTML = Diagresult[i]["Remark"]
        cell4.innerHTML = Diagresult[i]["Description"]
        cell5.innerHTML = Diagresult[i]["MedName"] + " | " + Diagresult[i]["Dose"]
        cell6.innerHTML = Diagresult[i]["Notes"]
        cell7.innerHTML = Diagresult[i]["FinalDiag"]
        

    }
}

