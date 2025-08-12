# 🌤 Weather App — Flutter

A modern weather application built with **Flutter**, using **geolocation**, **OpenWeather API**, and **glassmorphism UI**.  
It displays **current weather**, **hourly forecast**, and **weekly forecast** for your current location.

---

## 📸 Screenshots
*(Add screenshots Later  )*

---

## 🚀 Features
- 📍 **Live Location Detection** using `geolocator`
- ⏳ **Real-time Clock & Date** updates
- 🌡 **Current Weather Data** (Temperature, Wind Speed, Humidity)
- 📅 **Hourly & Weekly Forecast**
- 🎨 **Glassmorphism UI** with blur effects
- 📱 Responsive and clean Material Design

---

## 🛠 Packages Used
| Package                   | Purpose |
|---------------------------|-----------------------------------------------|
| **flutter/material.dart** | Core Flutter UI components |
| **dart:async**            | `Future` & `Timer` for async and clock updates |
| **dart:ui**               | `BackdropFilter` for glass blur effect |
| **geolocator**            | Get GPS coordinates of device |
| **intl**                  | Date & time formatting |
| **http**                  | Fetch data from the weather API |

---

## 🔗 API Used
- **OpenWeather API** — https://api.openweathermap.org/data/2.5/weather?q=London&appid={API key} 
  Provides weather data (temperature, humidity, wind speed, etc.).

---

## 📂 Project Structure
lib/
│
├── models/
│ └── weather_get_model.dart # Model to map API JSON
│
├── services/
│ └── fetch_weather_data.dart # API call logic
│
├── screens/
│ ├── splash_screen.dart # Splash screen
│ ├── weather_screen.dart # Main screen with current weather
│ └── weekly_weather.dart # Weekly forecast screen
│
└── main.dart # App entry point


👨‍💻 Author
Mohsin Ali — https://github.com/Mohsinali30





