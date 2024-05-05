// NavigationButton.js

import React from 'react';

const NavigationButton = ({ name, url, onClick }) => {
  return (
    <button className="nav-button" onClick={onClick}> 
      {name}
    </button>
  );
}

export default NavigationButton;
