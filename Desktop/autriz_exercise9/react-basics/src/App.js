import React, { useState } from 'react';
import './App.css';
import NavigationButton from './components/NavigationButton';
import ItemCard from './components/ItemCard';
import ShoppingCartProducts from './components/ShoppingCartProduct';
import products from './components/products';
import menus from './components/menus';

function App() {
  
  const [pushcarts, setPushcarts] = useState([]);
  const [message, setMessage] = useState('');

  // TOGGLE TO DISPLAY THE CART
  const [showShoppingCart, setShowShoppingCart] = useState(true);

  // CALCULATES THE TOTAL NUMBER OF ITEMS
  const calculateTotalItems = () => {
    return pushcarts.reduce((total, item) => total + item.quantity, 0);
  };

  // CALCULATES THE TOTAL PRICE
  const calculateTotalValue = () => {
    return pushcarts.reduce((total, item) => total + item.quantity * item.price, 0);
  };

  // ADD ITEM TO CART
  const addToCart = (itemName, price) => {
    const existingItemIndex = pushcarts.findIndex(item => item.itemName === itemName);

    if (existingItemIndex !== -1) {
      const updatedPushcarts = [...pushcarts];
      updatedPushcarts[existingItemIndex].quantity += 1;
      console.log(`Added ${itemName} with a price of ${price} to the cart!`);
      setPushcarts(updatedPushcarts);
      setMessage(`You have added ${itemName} with a price of ${price} in your cart!`);
    } else {
      const updatedPushcarts = [...pushcarts, { itemName, price, quantity: 1 }];
      console.log(`Added ${itemName} with a price of ${price} to the cart!`);
      setPushcarts(updatedPushcarts);
      setMessage(`You have added ${itemName} with a price of ${price} in your cart!`);
    }

    setTimeout(() => setMessage(''), 3000);
  };

  // REMOVE ITEM FROM CART
  const removeFromCart = (index) => {
    const updatedPushcarts = [...pushcarts];
    const updatedItem = { ...updatedPushcarts[index] };

    if (updatedItem.quantity > 1) {
      updatedItem.quantity -= 1;
      updatedPushcarts[index] = updatedItem;
      setPushcarts(updatedPushcarts);
    } else {
      updatedPushcarts.splice(index, 1);
      setPushcarts(updatedPushcarts);
    }
  };

  // TOGGLE FOR SHOWING THE CART
  const toggleShoppingCart = () => {
    setShowShoppingCart(!showShoppingCart);
  };

  return (
    <div className="app-container">
      <header className="header">
        <h1 className="shop-label">Lazado</h1>

        {/* iterate over the menu and when the menu.name is shopping cart, display the shopping cart */}
        <nav className="navigation">
          {menus.map(menu => {
            if (menu.name === 'Shopping Cart') {
              return (
                <NavigationButton 
                  key={menu.id} 
                  name={menu.name} 
                  url={menu.url} 
                  onClick={toggleShoppingCart} 
                />
              );
            } else {
              return (
                <NavigationButton 
                  key={menu.id} 
                  name={menu.name} 
                  url={menu.url} 
                />
              );
            }
          })}
        </nav>
      </header>
      <div className="main-content">
        <div className="item-container">
          {products.map(product => (
            <ItemCard
              key={product.id}
              imageUrl={product.image}
              altText={product.name}
              buttonText="Add to Cart"
              itemName={product.name}
              price={product.price}
              addToCart={addToCart}
            />
          ))}
        </div>
        {showShoppingCart && ( // SHOW SHOPPING CART IF TRUE
          <div className="shopping-cart">
            <h2>Shopping Cart</h2>
            <ShoppingCartProducts pushcarts={pushcarts} removeFromCart={removeFromCart} />
            <div className="cart-summary">
              <p>Total Items: {calculateTotalItems()}</p>
              <p>Total Value: ${calculateTotalValue().toFixed(2)}</p>
            </div>
          </div>
        )}
      </div>
      {message && (
        <div className="message-box">
          <p>{message}</p>
        </div>
      )}
      <footer className="footer">
        <p>&copy; 2024 Lazado. All rights reserved.</p>
      </footer>
    </div>
  );
}

export default App;
