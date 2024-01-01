function createGraph() {
    let chartStatus = Chart.getChart("diseaseChart");
    if (chartStatus != undefined) {
        chartStatus.destroy();
    }
    const data = {
        labels: ["a", "b", "c"],
        datasets: [
            {
                label: "Disease probabilistic distribution",
                data: [100, 233, 140],
                backgroundColor: ["#a035e195", "#fbb71495", "#214dfb95"],
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
            ctx.fillText("Disease", chart.getDatasetMeta(0).data[0].x,
                chart.getDatasetMeta(0).data[0].y)
            //for (let i = 0; i < data.labels.length; i++) {
            //    ctx.fillText(Number(data.datasets[0].data[i]).toFixed(4), chart.getDatasetMeta(0).data[i].x,
            //        chart.getDatasetMeta(0).data[i].y + 12)
            //}
        }
    }
    // config
    const config = {
        type: "doughnut",
        data,
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
    const diseaseChart = new Chart(
        document.getElementById("diseaseChart"),
        config
    );
}
createGraph();

function CreateRequestChart() {
    PageMethods.GetRequestData(OnDailyRequestDataBinded)
}
function OnDailyRequestDataBinded(data) {
    console.log(data) 
    let requestArray = []
    let dayArray = []
    for (let i = 0; i < data.length; i++) {
        dayArray[i]= data[i]["Day"]
        requestArray[i] = data[i]["RequestCount"]
    }
    let chartStatus = Chart.getChart("requestChart")
    if (chartStatus != undefined) {
        chartStatus.destroy();
    }
    const requestData = {
        labels: dayArray,
        datasets: [
            {
                label: "Disease probabilistic distribution",
                data: requestArray,
                backgroundColor: ["#c34dc1", "#fbb71440", "#214dfb40"],
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
$(document).ready(function () {
    CreateRequestChart()
})
