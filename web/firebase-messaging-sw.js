// Import the Firebase scripts needed
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCg2VjZ9nSI42IAHBElPhDg2yZ24TUMP-Y",
  authDomain: "farmers-market-c591f.firebaseapp.com",
  databaseURL: "https://farmers-market-c591f-default-rtdb.firebaseio.com",
  projectId: "farmers-market-c591f",
  storageBucket: "farmers-market-c591f.firebasestorage.app",
  messagingSenderId: "361385379289",
  appId: "1:361385379289:web:9651675311b1f863dc45c8",
  measurementId: "G-TSLCLXBMM6"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
// Retrieve an instance of Firebase Messaging
const messaging = firebase.messaging();