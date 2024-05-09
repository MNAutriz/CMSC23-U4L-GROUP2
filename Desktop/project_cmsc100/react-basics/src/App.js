import React from 'react';
import Header from './components/header/Header';
import Footer from './components/footer/Footer';
import ProductListing from './components/product/ProductListing';
import './App.css';

const products = [
  { id: 1, name: 'Product 1', price: '$10', image: 'product1.jpg', description: 'Description of Product 1' },
  { id: 2, name: 'Product 2', price: '$20', image: 'product2.jpg', description: 'Description of Product 2' },
  { id: 3, name: 'Product 3', price: '$30', image: 'product3.jpg', description: 'Description of Product 3' },
  { id: 1, name: 'Product 1', price: '$10', image: 'product1.jpg', description: 'Description of Product 1' },
  { id: 2, name: 'Product 2', price: '$20', image: 'product2.jpg', description: 'Description of Product 2' },
  { id: 3, name: 'Product 3', price: '$30', image: 'product3.jpg', description: 'Description of Product 3' },
];

const App = () => {
  return (
    <div className="App">
      <Header />
      <ProductListing products={products} />
      <Footer />
    </div>
  );
}

export default App;
