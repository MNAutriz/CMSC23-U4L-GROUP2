import React from 'react';

// Define ShoppingCartItem functional component
const ShoppingCartItem = ({ itemName, price, quantity, onDelete }) => {
  return (
    // Render a div with class "cart-item"
    <div className="cart-item">
      <div>
        <p>{itemName}</p>
        <p>{price}</p>
        <p>Quantity: {quantity}</p> 
      </div>
      {/* Render a delete button with an onClick event listener that calls the onDelete function */}
      <button onClick={onDelete}>Delete</button>
    </div>
  );
};

// Export ShoppingCartItem component as default
export default ShoppingCartItem;