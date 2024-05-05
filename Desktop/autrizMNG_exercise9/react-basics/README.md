# Week 9: React JS State Management

**Name:** Mark Neil Autriz <br/>
**Section:** UV2L <br/>
**Student number:** 2022 - 03446 <br/>

## Code Description

The provided files implement a basic shopping cart functionality in a React application. "ShoppingCartItem.js" defines a component to represent individual items in the cart, displaying their name, price, quantity, and a delete button. Meanwhile, "ShoppingCartProducts.js" orchestrates the display of all items in the cart by importing and rendering the ShoppingCartItem component for each item in the cart array (pushcarts). It allows users to view item details and remove items from the cart using a delete button, facilitated by a function passed down as a prop. Together, these files create a seamless user experience for managing items within a shopping cart interface.

## Things you did in the code
1. ShoppingCartItem.js: Defines a component to represent an item in a shopping cart. It also displays item details (name, price, quantity) and a delete button along with handling the delete functionality through the onDelete prop.
2. ShoppingCartProducts.js: Displays a list of items in the shopping cart this also imports the ShoppingCartItem component along with the maps over the items (pushcarts) in the cart and renders ShoppingCartItem components for each item and a function (removeFromCart) to remove items from the cart.

## Commit Log

1. Created the Structure for the Lazado App.
2. Added documentations for the design and structure of the Lazado app.
3. Added the logic for the components of the Lazado app.
4. Added the structure for the shopping cart.
5. Created the functionality of the shopping cart. 