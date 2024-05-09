import React from 'react';
import './Header.css';

const Header = () => {
  return (
    <header className="header">
      <div className="logo">Your Logo</div>
      <div className="search-bar">
        <input type="text" placeholder="Search products" />
        <button><i className="fas fa-search"></i></button>
      </div>
      <nav>
        <ul>
          <li>Home</li>
          <li>Categories</li>
          <li>Cart</li>
          <li>Account</li>
        </ul>
      </nav>
    </header>
  );
}

export default Header;
