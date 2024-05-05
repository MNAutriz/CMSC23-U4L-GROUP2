import React from 'react';


// Defines the ItemCard component
const ItemCard = (
    { 
        imageUrl, 
        altText, 
        buttonText, 
        itemName, 
        price, 
        addToCart 
    }) => {

  // Defines the handleAddToCart function
  // Adds the item to the cart
  // Calls the addToCart function with the item name and price
  const handleAddToCart = () => {
    addToCart(itemName, price);
  };

  // Returns the ItemCard component
  // Contains the item image, name, price, and add to cart button
  return (
    <div className="item-card">
      <img src={imageUrl} alt={altText} />
      <div className="card-label">
        <p className='product-name'>{itemName}</p>
        <p>${price}</p>
    {/* Calls the handleAddToCart function when the button is clicked */}
      </div>
      <button onClick={handleAddToCart}>{buttonText}</button>
    </div>
  );
}

export default ItemCard;

