// Import necessary modules and components
import React from 'react'; // Importing React library
import ReactDOM from 'react-dom/client'; // Importing ReactDOM library for rendering
import './index.css'; // Importing CSS styles for the index
import App from './App'; // Importing the main App component

// Create a root element using ReactDOM.createRoot method and target the element with id 'root'
const root = ReactDOM.createRoot(document.getElementById('root'));

// Render the main App component inside a StrictMode component
root.render(
  <React.StrictMode>
    <App /> {/* Render the main App component */}
  </React.StrictMode>
);
