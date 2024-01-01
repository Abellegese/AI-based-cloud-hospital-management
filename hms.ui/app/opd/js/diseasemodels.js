﻿let diseases =  [
    'Fungal infection',
    'Allergy',
    'GERD',
    'Chronic cholestasis',
    'Drug Reaction',
    'Peptic ulcer diseae',
    'AIDS',
    'Diabetes',
    'Gastroenteritis',
    'Bronchial Asthma',
    'Hypertension',
    'Migraine',
    'Cervical spondylosis',
    'Paralysis(brain hemorrhage)',
    'Jaundice',
    'Malaria',
    'Chicken pox',
    'Dengue',
    'Typhoid',
    'hepatitis A',
    'Hepatitis B',
    'Hepatitis C',
    'Hepatitis D',
    'Hepatitis E',
    'Alcoholic hepatitis',
    'Tuberculosis',
    'Common Cold',
    'Pneumonia',
    'Dimorphic hemmorhoids(piles)',
    'Heart attack',
    'Varicose veins',
    'Hypothyroidism',
    'Hyperthyroidism',
    'Hypoglycemia',
    'Osteoarthristis',
    'Arthritis',
    '(vertigo) Paroymsal  Positional Vertigo',
    'Acne',
    'Urinary tract infection',
    'Psoriasis',
    'Impetigo',
]
let selectedSymptoms = []
var symptoms = ['itching',
    'skin rash',
    'nodal skin eruptions',
    'continuous sneezing',
    'shivering',
    'chills',
    'joint pain',
    'stomach pain',
    'acidity',
    'ulcers on tongue',
    'muscle wasting',
    'vomiting',
    'burning micturition',
    'spotting urination',
    'fatigue',
    'weight gain',
    'anxiety',
    'cold hands and feets',
    'mood swings',
    'weight loss',
    'restlessness',
    'lethargy',
    'patches in throat',
    'irregular sugar level',
    'cough',
    'high fever',
    'sunken eyes',
    'breathlessness',
    'sweating',
    'dehydration',
    'indigestion',
    'headache',
    'yellowish skin',
    'dark urine',
    'nausea',
    'loss of appetite',
    'pain behind the eyes',
    'back pain',
    'constipation',
    'abdominal pain',
    'diarrhoea',
    'mild fever',
    'yellow urine',
    'yellowing of eyes',
    'acute liver failure',
    'fluid overload',
    'swelling of stomach',
    'swelled lymph nodes',
    'malaise',
    'blurred and distorted vision',
    'phlegm',
    'throat irritation',
    'redness of eyes',
    'sinus pressure',
    'runny nose',
    'congestion',
    'chest pain',
    'weakness in limbs',
    'fast heart rate',
    'pain during bowel movements',
    'pain in anal region',
    'bloody stool',
    'irritation in anus',
    'neck pain',
    'dizziness',
    'cramps',
    'bruising',
    'obesity',
    'swollen legs',
    'swollen blood vessels',
    'puffy face and eyes',
    'enlarged thyroid',
    'brittle nails',
    'swollen extremeties',
    'excessive hunger',
    'extra marital contacts',
    'drying and tingling lips',
    'slurred speech',
    'knee pain',
    'hip joint pain',
    'muscle weakness',
    'stiff neck',
    'swelling joints',
    'movement stiffness',
    'spinning movements',
    'loss of balance',
    'unsteadiness',
    'weakness of one body side',
    'loss of smell',
    'bladder discomfort',
    'foul smell of urine',
    'continuous feel of urine',
    'passage of gases',
    'internal itching',
    'toxic look (typhos)',
    'depression',
    'irritability',
    'muscle pain',
    'altered sensorium',
    'red spots over body',
    'belly pain',
    'abnormal menstruation',
    'dischromic patches',
    'watering from eyes',
    'increased appetite',
    'polyuria',
    'family history',
    'mucoid sputum',
    'rusty sputum',
    'lack of concentration',
    'visual disturbances',
    'receiving blood transfusion',
    'receiving unsterile injections',
    'coma',
    'stomach bleeding',
    'distention of abdomen',
    'history of alcohol consumption',
    'fluid overload',
    'blood in sputum',
    'prominent veins on calf',
    'palpitations',
    'painful walking',
    'pus filled pimples',
    'blackheads',
    'scurring',
    'skin peeling',
    'silver like dusting',
    'small dents in nails',
    'inflammatory nails',
    'blister',
    'red sore around nose',
    'yellow crust ooze']
function createTag() {
    const tags = document.createElement('span')
    let diseaseSymptom = document.getElementById("txtSymptoms").value
    tags.className = "mx-2 badge badge-success font-weight-light"
    tags.innerHTML = diseaseSymptom
    selectedSymptoms.push(tags.innerHTML)
    //append it to the main element
    const tagDiv = document.getElementById("tagDiv")
    tagDiv.appendChild(tags)
}
function removeTag() {
    const tagDiv = document.getElementById("tagDiv")
    tagDiv.innerHTML = ""
}
function createSymptomTensor() {
    intSymptoms = [0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0
    ]
    for (let i = 0; i < selectedSymptoms.length; i++) {
        let index = symptoms.indexOf(selectedSymptoms[i])
        intSymptoms[index] = 1
    }
    intSymptoms = tf.tensor2d(intSymptoms, [1, 132]);
    return intSymptoms
}

let highRankedResults = []
let highRankedResultLabels = []

async function predictDisease() {
    //document.getElementById("spinner").style.display = "block"
    const model = await tf.loadGraphModel('../ai-models/Disease-Predictor/model.json');
    const results = model.predict(createSymptomTensor());
    let result = Array.from(results.dataSync())
  

    for (let i = 0; i < result.length; i++) {
        if (Number(result[i]) * 100 > 10) {
            //console.log(result[i]*100)
            highRankedResults.push(result[i])
            highRankedResultLabels.push(
                diseases.sort()[result.indexOf(result[i])]
            )
        }
    }
    createGraph(highRankedResults, highRankedResultLabels)
    selectedTopOneDisease(highRankedResults, highRankedResultLabels)
}
//function to create graph
function createGraph(d, l) {
    console.log(d)
    let chartStatus = Chart.getChart("diseaseBarChart")
    if (chartStatus != undefined) {
        chartStatus.destroy()
    }
    
    const dataDisease = {
        labels: l,
        datasets: [{
            label: 'Disease probabilistic distribution',
            data: d,
            backgroundColor: ["#a035e195", "#fbb71495", "#214dfb95"],
            borderColor: ["#a035e195", "#fbb71495", "#214dfb95"],
            barThickness: 19,
            borderWidth: 1,
            borderRadius: 3,
            aspectRatio: 0.5,
            cutout: "82%"
        }]
    };
    const innerBarText = {
        id: 'innerBarText',
        afterDatasetsDraw(chart, args, pluginOptions) {
            const { ctx, data, chartArea: { top,bottom }, scales: { x, y } } = chart
            ctx.save()
            ctx.font = "bolder 10px sans-serif"
            ctx.fillStyle = 'gray'
            ctx.textAlign = 'center'
            ctx.fillText("16%", chart.getDatasetMeta(0).data[0].x,
                chart.getDatasetMeta(0).data[0].y)
        }
    }
   
    const configDisease = {
        type: "doughnut",
        data: dataDisease,
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
        /*plugins: [innerBarText]*/
    };

    // render init block
    const diseaseBarChart = new Chart(
        document.getElementById('diseaseBarChart'),
        configDisease
    );
}
function selectedTopOneDisease(o,e) {
    let index = o.indexOf(max(o))
    let maxProb = max(o)
    let disease = e[index]
    document.getElementById("diseaseDiv")
        .style
    document.getElementById("diseaseSpan")
        .innerHTML = ""
        .display = "block"
    document.getElementById("diseaseSpan")
        .innerHTML = disease
    document.getElementById("probSpan")
        .innerHTML = ""
    document.getElementById("probSpan")
        .innerHTML = "This disease based on the provided symptom vector achieved "+maxProb.toFixed(2)*100 + "% prob. distribution"
}
function max(arguments) {
    var max = Number.NEGATIVE_INFINITY;
    // Loop through the arguments, looking for, and remembering, the biggest.
    for (var i = 0; i < arguments.length; i++)
        if (arguments[i] > max) max = arguments[i];
    // Return the biggest
    return max;
}
function CreateCSV() {
    let diseaseTable = document.getElementById("diseaseTable")
    let row = diseaseTable.rows
    let rowCount = row.length
    let diseaseArray = []
    for (let i = 0; i < rowCount; i++) {
        let diseaseUntrimmed = String(diseaseTable.rows[i].cells[i].innerText)
        if (diseaseUntrimmed != "") {
            let index = diseaseUntrimmed.indexOf("_")
            let diseaseTrimmed = diseaseUntrimmed.substring(index, diseaseUntrimmed.length)
            diseaseArray.push(diseaseTrimmed)
        }
    }
    console.log(diseaseArray)
}