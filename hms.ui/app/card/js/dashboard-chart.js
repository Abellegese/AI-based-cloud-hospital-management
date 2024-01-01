

function CreateRequestChart() {
    PageMethods.GetRequestProgress(OnDailyRequestDataBinded)
}
function OnDailyRequestDataBinded(data) {
    let chartStatus = Chart.getChart("requestChart")
    if (chartStatus != undefined) {
        chartStatus.destroy();
    }
    const requestData = {
        labels: ["Pending","On Examination"],
        datasets: [
            {
                label: "Disease probabilistic distribution",
                data: [data[0], data[1]],
                backgroundColor: ["#c34dc140", "#fbb71440", "#214dfb40"],
                borderColor: ["#a035e110"],
                borderWidth: 1,
                borderRadius: 3,
                aspectRatio: 0.5,
                cutout: "82%"
            },
        ],
    };
    const innerBarText = {
        id: 'innerBarText',
        afterDatasetsDraw(chart, args, pluginOptions) {
            const { ctx, data, chartArea: { top, bottom }, scales: { x, y } } = chart
            ctx.save()
            ctx.font = "bolder 14px sans-serif"
            ctx.fillStyle = 'gray'
            ctx.textAlign = 'center'
            ctx.fillText("Daily Request", chart.getDatasetMeta(0).data[0].x,
                chart.getDatasetMeta(0).data[0].y)
        }
    }
    // config
    const config = {
        type: "doughnut",
        data: requestData,
        options: {
            aspectRation: 0.5,
            plugins: {
                legend: {
                    display: false,
                },
                tooltip: {
                    usePointStyle: true,
                },
            },
        },
        plugins: [innerBarText]
    };

    // render init block
    const diseaseBarChart = new Chart(
        document.getElementById("requestChart"),
        config
    );
}
function GetPatientByGender() {
    PageMethods.GetPatientByGender(OnGenderDataBinded)
}
function OnGenderDataBinded(data) {
    let chartStatus = Chart.getChart("genderChart")
    if (chartStatus != undefined) {
        chartStatus.destroy();
    }
    const requestData = {
        labels: ["Male", "Female"],
        datasets: [
            {
                label: "Disease probabilistic distribution",
                data: [data[0], data[1]],
                backgroundColor: ["#ed8d6240", "#89c33540", "#214dfb40"],
                borderColor: ["#a035e110"],
                borderWidth: 1,
                borderRadius: 3,
                aspectRatio: 0.5,
                cutout: "82%"
            },
        ],
    };
    const innerBarText = {
        id: 'innerBarText',
        afterDatasetsDraw(chart, args, pluginOptions) {
            const { ctx, data, chartArea: { top, bottom }, scales: { x, y } } = chart
            ctx.save()
            ctx.font = "bolder 14px sans-serif"
            ctx.fillStyle = 'gray'
            ctx.textAlign = 'center'
            ctx.fillText("Gender", chart.getDatasetMeta(0).data[0].x,
                chart.getDatasetMeta(0).data[0].y)
        }
    }
    // config
    const config = {
        type: "doughnut",
        data: requestData,
        options: {
            aspectRation: 0.5,
            plugins: {
                legend: {
                    display: false,
                },
                tooltip: {
                    usePointStyle: true,
                },
            },
        },
        plugins: [innerBarText]
    };

    // render init block
    const diseaseBarChart = new Chart(
        document.getElementById("genderChart"),
        config
    ); 
}
function GetAppointmentByStatus() {
    PageMethods.GetAppointmentByStatus(OnAppointmentByStatsBinded)
}
function OnAppointmentByStatsBinded(data) {
    let chartStatus = Chart.getChart("appointmentChart")
    if (chartStatus != undefined) {
        chartStatus.destroy();
    }
    const requestData = {
        labels: ["OnGoing", "Due Passed", "Completed"],
        datasets: [
            {
                label: "Disease probabilistic distribution",
                data: [data[0], data[1], data[2]],
                backgroundColor: ["#80808040", "#89c33540", "#214dfb40"],
                borderColor: ["#a035e110"],
                borderWidth: 1,
                borderRadius: 3,
                aspectRatio: 0.5,
                cutout: "82%"
            },
        ],
    };
    const innerBarText = {
        id: 'innerBarText',
        afterDatasetsDraw(chart, args, pluginOptions) {
            const { ctx, data, chartArea: { top, bottom }, scales: { x, y } } = chart
            ctx.save()
            ctx.font = "bolder 14px sans-serif"
            ctx.fillStyle = 'gray'
            ctx.textAlign = 'center'
            ctx.fillText("Appointment", chart.getDatasetMeta(0).data[0].x,
                chart.getDatasetMeta(0).data[0].y)
        }
    }
    // config
    const config = {
        type: "doughnut",
        data: requestData,
        options: {
            aspectRation: 0.5,
            plugins: {
                legend: {
                    display: false,
                },
                tooltip: {
                    usePointStyle: true,
                },
            },
        },
        plugins: [innerBarText]
    };

    // render init block
    const diseaseBarChart = new Chart(
        document.getElementById("appointmentChart"),
        config
    );
}
$(document).ready(function () {
    GetAppointmentByStatus()
    GetPatientByGender()
    CreateRequestChart()
})
