# 🌸 Iris Species Predictor

This is ML project where i have created a beginner firendly ML model on iris dataset and that have been deployed using flask (to create an API of model) and NGROK (to create a secure tunnel to local host) over a flutter Mobile application, we are using our laptop as server here were our model will be running in local host and other devices can access it via a NGROK link as an API in flutter application

## 📦 How to use this project ( SET UP )
- all files except " model_flask_setup " are core flutter files if you want to make any changes in UI of application you can else leave it no need to touch
- Create a seperate folder keep ML model and flask code in same folder (model_flask_setup)
- run flask code(app.py) to create an API of model that will only run on your local host
- Install and setup NGROK run "ngrok http 5000 (here 5000 is your locak port on which model is running ngrok will create a secure tunnel and provide you an Forwarding URL)"
- enter that forwarded URL in flutter applications to make prediction

OR CONTACT ME :)

## 🚀 Features

- 🔮 **Live Predictions** via deployed ML model (tested on Postman and mobile)
- 📱 **Cross-Device Compatibility** for seamless UX on web and mobile
- 🎨 **Modern UI/UX** with animated transitions and polished input fields
- 🧠 **Modular Architecture** for maintainability and scalability
- 📊 **Reliable Results** validated across platforms


## 🛠️ Tech Stack

| Layer        | Tools Used                          |
|--------------|-------------------------------------|
| Frontend     | Flutter, Dart                       |
| Backend      | Flask, scikit-learn, Python         |
| Deployment   | NGROK for testing |
| Testing      | Postman, Android Emulator, Real Device |

## 📷 Screenshots

### API Resquests
<img width="1482" height="770" alt="image" src="https://github.com/user-attachments/assets/dd492acd-caf3-464e-b779-16d81d8a7bf9" />
### App UI

![WhatsApp Image 2025-09-20 at 12 27 00_4ad70e68](https://github.com/user-attachments/assets/442296b1-3937-4211-a3c8-a4cfddd2b389)

![WhatsApp Image 2025-09-20 at 12 27 00_7c502ec2](https://github.com/user-attachments/assets/9561faeb-8e00-4a47-8fdc-901a68ce13b5)

![WhatsApp Image 2025-09-19 at 16 07 02_89d62221](https://github.com/user-attachments/assets/292ec7cc-2597-4997-b96a-37c82e48b5c9)

