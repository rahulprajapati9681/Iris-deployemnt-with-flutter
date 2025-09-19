# model_api.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import numpy as np

app = Flask(__name__)
CORS(app)

# Load model
model = joblib.load('iris_LogesticRegression_model.pkl')

# ✅ Health-check route
@app.route('/', methods=['GET'])
def home():
    return jsonify({
        "status": "API is live 🚀",
        "message": "Welcome to Iris Prediction API. Use POST /predict with 4 features."
    })

# ✅ Prediction route
@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        features = data.get('features', [])
        if len(features) != 4:
            return jsonify({'error': 'Exactly 4 features are required.'}), 400
        
        # Convert to numpy array
        features = np.array(features).reshape(1, -1)
        prediction = model.predict(features)[0]

        # Map class numbers to species names
        species_map = {0: "Iris-setosa", 1: "Iris-versicolor", 2: "Iris-virginica"}
        return jsonify({'prediction': species_map[prediction]})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Run app
if __name__ == '__main__':
    app.run(port=5001, debug=True)
