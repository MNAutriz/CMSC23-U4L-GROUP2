import React from 'react';
import { useHistory } from 'react-router-dom';
import './Login.css'; // Import your CSS file containing styles



const Login = () => {
  const history = useHistory();

  const handleLogin = () => {
    // Logic for handling login
    // For demonstration, let's navigate to the e-commerce website after login
    history.push('/ecommerce');
  };

  return (
    <div id="banner">
      <div className="login-container">
        <h2>Login to Your Account</h2>
        {/* Your login form here */}
        <button onClick={handleLogin}>Login</button>
      </div>
    </div>
  );
}

export default Login;
