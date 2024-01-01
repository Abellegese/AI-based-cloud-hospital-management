"""
Deploy Flask App in IIS Server
"""
from flask import Flask, jsonify, request
from models import XrayClassifier
from heatmap import HeatmapGenerator
from flask_cors import CORS, cross_origin

app = Flask(__name__)
cors = CORS(app)
app.config['Access-Control-Allow-Origin'] = '*'

@app.route("/predict", methods=["POST"])
@cross_origin()
def predictDisease():
    # Accepting the incoming request and parsing it as json
    request_data = request.get_json()
    # extracting parameters
    model_type = request_data['model_type']
    img_path = request_data['img_path']
    print(model_type)
    print(img_path)
    # proccessing the prediction
    predict = XrayClassifier.predict(
        model_type=model_type, img_path=img_path)
    print(predict)
    return predict


@app.route("/heatmap", methods=["POST"])
@cross_origin()
def generateHeatmap():
    # Accepting the incoming request and parsing it as json
    request_data = request.get_json()
    # extracting parameters
    model_type = request_data['model_type']
    img_path = request_data['img_path']
    print(model_type)
    print(img_path)
    # proccessing the prediction
    path = HeatmapGenerator.create_heatmap(
        model_type=model_type, img_path=img_path)
    print(path)
    return jsonify({'path':path})

if __name__ == "__main__":
    app.run()
