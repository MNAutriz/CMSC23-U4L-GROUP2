import React from 'react';
import ShoppingCartItem from './ShoppingCartItem'; 

// Define ShoppingCartProducts functional component
const ShoppingCartProducts = ({ pushcarts, removeFromCart }) => {
  return (
    // Render a div with class "cart-items"
    <div className="cart-items">
      {pushcarts.map((item, index) => (
        // Render a ShoppingCartItem component for each item in the pushcarts array
        <ShoppingCartItem
          key={index}  // Set key to index for efficient rendering
          itemName={item.itemName} 
          price={item.price}
          quantity={item.quantity} 
          onDelete={() => removeFromCart(index)}
        />
      ))}
    </div>
  );
};

// Export ShoppingCartProducts component as default
export default ShoppingCartProducts;
