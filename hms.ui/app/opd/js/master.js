$('#automation').click(function () {
    SaveAutomationSetting();
});
$('#appointment').click(function () {
    SaveAutomationSetting();
});
$('#report').click(function () {
    SaveAutomationSetting();
});
$('#reminder').click(function () {
    SaveAutomationSetting();
});
$('#email').click(function () {
    SaveAutomationSetting();
});
function SaveData(data, modelName, methodName) {
    $.ajax({
        type: "POST",
        url: 'localhost/heatmap',
        data: '{ ' + modelName + ': ' + JSON.stringify(data) + ' }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            data = response
            path = data.path
            alert(path)
        },
        error: function (error) {
            alert("Error during saving!");
        }
    });
}
function SaveAutomationSetting() {
    let result;
    var setting = {
        EnableAutomation: document.getElementById("automation").checked,
        EnableAppointment: document.getElementById("appointment").checked,
        EnableReport: document.getElementById("report").checked,
        EnableReminder: document.getElementById("reminder").checked,
        EnableEmail: document.getElementById("email").checked
    };
    console.log(setting)
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/SaveAutomationSetting",
        data: '{ setting: ' + JSON.stringify(setting) + ' }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            result = response.d
           HelloWorld(result)
        },
        error: function (error) {
            alert(error);
        }
    }); 
}
function HelloWorld(r) {

    alert(r)
}
function ShowAddAutomation() {
    $('#ReportAutomationListModal').modal('hide');
    $('#ReportAutomationModal').modal('show');
}
function ShowAddReminder() {
    $('#ReminderAutomationListModal').modal('hide');
    $('#ReminderAutomationModal').modal('show');
}
function ShowAddDiseaseModal() {
    $('#DiseaseListModal').modal('hide');
}
function ShowAddDiseaseStatusModal() {
    $('#DiseaseStatusListModal').modal('hide');
}
function SaveReportAutomation() {
    var reportModel = {
        ReportType: $('#ddlReportType option:selected').text(),
        RecipientAddress: $('#txtReportRecipientEmail').val(),
        Cycle: $('#ddlReportCycle option:selected').text(),
        StartDate: $('#txtFromDate').val(),
        Notes: $('#txtReportNotes').val()
    };
    SaveData(reportModel, "reportModel", SaveReportAutomation)
    GetAutomatedReport()
    $('#ReportAutomationListModal').modal('show');
    $('#ReportAutomationModal').modal('hide');
}
function GetAutomatedReport() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetAutomatedReport",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            CreateReportTable(response.d)
            FillReportTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}

function SaveReminder() {
    var reminderModel = {
        Name: $('#txtReminderName').val(),
        Task: $('#txtTask').val(),
        Cycle: $('#ddlReminderCycle option:selected').val()
    };
    SaveData(reminderModel, "reminderModel", "SaveReminder")
    GetReminder()
    $('#ReminderAutomationListModal').modal('show');
    $('#ReminderAutomationModal').modal('hide');
}
function GetReminder() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetReminder",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            CreateReminderTable(response.d)
            FillReminderTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}

$(document).ready(function () {
    GetReminder()
    GetAutomatedReport()
})

//Catelog creation and retrieval
function SaveDisease() {
    var diseaseModel = {
        DiseaseName: $('#txtDiseaseName').val(),
        Severity: $('#ddlDiseaseSeverity option:selected').val()
    };
    SaveData(diseaseModel, "diseaseModel", "SaveDisease")
    GetDiseaseData()
    $('#AddDiseaseModal').modal('hide');
    $('#DiseaseListModal').modal('show');

}
function SaveDiseaseStatus(){
    var diseaseModel = {
        DiseaseName: $('#ddlDiseaseStatusName option:selected').val(),
        Status: $('#txtDiseaseStatus').val()
    };
    SaveData(diseaseModel, "diseaseModel", "SaveDiseaseStatus")
    ShowGeneralSnackbar("Disease Status Successfully Saved!")
}
function GetDiseaseData() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetDisease",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            CreateDiseaseTable(response.d)
            FillDiseaseTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}
function GetDiseaseStatusData() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetDiseaseStatus",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            CreateDiseaseStatusTable(response.d)
            FillDiseaseStatusTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}

function SaveDiseaseTreatmentType() {
    var diseaseModel = {
        DiseaseName: $('#ddlDiseaseNameTreatmentType option:selected').val(),
        TreatmentType: $('#txtTreatmentType').val()
    };
    SaveData(diseaseModel, "diseaseModel", "SaveDiseaseTreatmentType")
    ShowGeneralSnackbar("Disease Treatment Type Successfully Saved!")
}
function GetDiseaseTreatmentData() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetDiseaseTreatmentType",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            CreateDiseaseTreatmentTable(response.d)
            FillDiseaseTreatmentTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}
function SaveMedicine() {
    var medicineModel = {
        MedicineName: $('#txtAddMedicineName').val(),
        Type: $('#ddlMedicineType option:selected').val(),
        Precaution: $('#txtPrecaution').val()
    };
    SaveData(medicineModel, "medicineModel", "SaveMedicine")
    GetMedicineData()
    $('#AddMedicineModal').modal('hide');
    $('#MedicineListModal').modal('show');
    ShowGeneralSnackbar("Medicine Successfully Saved!")

}
function SaveDiseaseType() {
    var diseaseModel = {
        DiseaseName: $('#ddlDiseaseTypeName option:selected').val(),
        DiseaseType: $('#txtDiseaseType').val()
    };
    SaveData(diseaseModel, "diseaseModel", "SaveDiseaseType")
    GetDiseaseTypeData()
    $('#AddDiseaseTypeModal').modal('hide');
    $('#DiseaseTypeListModal').modal('show');
    ShowGeneralSnackbar("Disease Type was Successfully Saved!")

}

function GetDiseaseTypeData() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetDiseaseType",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            CreateDiseaseTypeTable(response.d)
            FillDiseaseTypeTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}

function GetFollowUpData() {
    $.ajax({
        type: "POST",
        url: "dashboard.aspx/GetFollowUp",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            console.log(response.d)
            //CreateDiseaseTable(response.d)
            //FillDiseaseTable(response.d.length, response.d)
        },
        error: function (error) {
            alert(error);
        }
    });
}
