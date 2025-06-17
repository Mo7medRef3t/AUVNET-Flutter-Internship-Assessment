# AUVNET Flutter Internship Assessment

## Overview

This is a streamlined and responsive e-commerce mobile application built using **Flutter**, designed as part of the AUVNET internship technical assessment. The app demonstrates clean architecture principles, effective use of the **BLoC pattern**, and integration with **Firebase** services. It provides a seamless shopping experience, including product exploration, onboarding, user authentication, and a customizable user profile.

---

## Features

- **User Authentication** (Email/Password) using Firebase Auth  
- **Cloud Firestore** integration for product and restaurant data  
- **Cloudinary** used as a secure, scalable alternative to Firebase Storage  
- **Local data caching** and profile image handling via Hive  
- **Clean, responsive UI** following modern UX standards and Figma-provided design  
- **BLoC State Management** with immutable states and copyWith usage  
- **Modular and scalable project structure** following Clean Architecture principles  

---

## Project Structure

The project follows Clean Architecture, divided into clear layers:

lib/
├── core/ # Shared widgets, utils, and Hive helpers
├── features/
│ ├── auth/ # Authentication logic (data, domain, presentation)
│ ├── home/ # Home view and product list
│ ├── onboarding/ # App introduction flow
│ └── profile/ # User profile and preferences
└── main.dart # App initialization with Firebase and Hive

---

## Tech Stack

- **Flutter**  
- **Firebase Auth**  
- **Cloud Firestore**  
- **Cloudinary (for media hosting)**  
- **Hive (local storage)**  
- **flutter_bloc** for state management  
- **go_router** for routing  
- **Google Fonts & Responsive Design**

---

## Why Cloudinary?

Due to limitations on Firebase Storage access, **Cloudinary** was used to securely host images and store their URLs in Firestore. This approach ensures performance, scalability, and secure access control while maintaining full functionality as required by the task.

---

## Getting Started

### Prerequisites

- Flutter SDK (>=3.10)  
- Firebase project configured  
- Cloudinary account (if replacing media logic)  
- Android Studio or VSCode  

### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/Mo7medRef3t/AUVNET-Flutter-Internship-Assessment.git
   ```

2. Get packages:
   ```bash
   flutter pub get
   ```

3. Add your Firebase configuration:
   - Replace `firebase_options.dart` with your generated config (using FlutterFire CLI)

4. Run the app:
   ```bash
   flutter run
   ```

---

## Contact

For any inquiries or feedback, please feel free to reach out via email or GitHub.