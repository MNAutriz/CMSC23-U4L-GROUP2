import React from 'react';
import './ProductListing.css';

// Sample agriculture product image URLs
const agricultureProductImages = [
  "https://media.istockphoto.com/id/965062732/photo/open-air-fruit-market-with-bananas.jpg?s=612x612&w=0&k=20&c=v8FxZazj4iVOXJ2cW7tzD-FZH_gGV-jCIVk4MM38JmE=",
  "https://media.istockphoto.com/id/1919357973/photo/worms-eye-view-of-coconut-tree.jpg?s=612x612&w=0&k=20&c=oPOm3yFrj5_rkYJatKMPghrykdWkxgGc50JD55WQJfc=",
  "https://media.istockphoto.com/id/1036072290/photo/little-vegetable-store-asia-vegetable-store.jpg?s=612x612&w=0&k=20&c=AU4PW0OpXnFSArY5_-5bYel-eTdeQ_DR9Od3x_rq-_o=",
  "https://media.istockphoto.com/id/980812590/photo/fresh-raw-mangoes.jpg?s=612x612&w=0&k=20&c=cMyKeUk3tv0r295jMTZiWLCZ_WAAsajJqR9cnafq7PA=",
  "https://media.istockphoto.com/id/965029752/photo/fresh-pineapple-for-sale.jpg?s=612x612&w=0&k=20&c=gVublPZ7r-de5LtEV98wu3ZCZwqDjrLUaaCtbf082Fo=  ",
  "https://media.istockphoto.com/id/1333273912/photo/jocote-spanish-plum-spondias-purpura-at-the-asian-street-market.jpg?s=612x612&w=0&k=20&c=qv2tMvRWf-lSPg-51esWwyoCpUMmoMtKJwsg657AQK8=",
  "https://media.istockphoto.com/id/1919357973/photo/worms-eye-view-of-coconut-tree.jpg?s=612x612&w=0&k=20&c=oPOm3yFrj5_rkYJatKMPghrykdWkxgGc50JD55WQJfc=",
  "https://media.istockphoto.com/id/1488884938/photo/a-colorful-display-of-fresh-fruits-in-a-market-stall-in-baguio-philippines-featuring-various.jpg?s=612x612&w=0&k=20&c=XcC80C69fUfu7Lc9GkYV3bPyCddPjRSl9uT4sQWuyIQ=",
  "https://media.istockphoto.com/id/1367623080/photo/apples-peaches-and-persimmons-for-sale-at-a-street-market-in-divisioria-manila-philippines.jpg?s=612x612&w=0&k=20&c=wIhP7ZkcnhBeG8iRrIYfrbAx2kkpu5EePch3RHukRPU=",
  "https://media.istockphoto.com/id/965062732/photo/open-air-fruit-market-with-bananas.jpg?s=612x612&w=0&k=20&c=v8FxZazj4iVOXJ2cW7tzD-FZH_gGV-jCIVk4MM38JmE=",
];

const ProductListing = () => {
  const products = [
    { id: 1, 
      name: "Product 1", 
      price: "$10", 
      description: "A tomato plant will thrive in warm, moist conditions. We recommend growing in seedling trays if bought as seeds, before transplanting to the soil when the plant is one month old. Your tomato plant needs some extra TLC in the form of loam soil, which is higher quality and more nutritious.", 
      image: agricultureProductImages[0] 
    }, 
    { id: 2, 
      name: "Product 2", 
      price: "$10", 
      description: "Tomato plants love sunlight and need at least six hours of direct exposure every day — just be careful not to place them where they can get too much, as they will wilt. You may also need to stake and prune your tomato plant occasionally to control its vine-like growth.", 
      image: agricultureProductImages[1] 
    }, 
    { id: 3, 
      name: "Product 3", 
      price: "$10", 
      description: "A tomato plant will thrive in warm, moist conditions. We recommend growing in seedling trays if bought as seeds, before transplanting to the soil when the plant is one month old. Your tomato plant needs some extra TLC in the form of loam soil, which is higher quality and more nutritious.", 
      image: agricultureProductImages[2] 
    }, 
    { id: 4, 
      name: "Product 4", 
      price: "$10", 
      description: "Though some people have a love-hate relationship with okra, it’s a popular ingredient in many Filipino dishes, making it a welcome guest in most family kitchens. If you’re someone who enjoys them, the good news is that they are very easy to grow right in your backyard.", 
      image: agricultureProductImages[3] 
    }, 
    { id: 5, 
      name: "Product 5", 
      price: "$10", 
      description: "Pepper plants are of the same family as tomato plants, so they have similar growing difficulties and needs. Of all the pepper plants you could cultivate in your backyard — such as bell pepper, sweet peppers, and many more — the best variety to start with is the bird’s eye chili peppers or siling labuyo.", 
      image: agricultureProductImages[4] 
    }, 
    { id: 6, 
      name: "Product 6", 
      price: "$10", 
      description: "Calamansi plants, also known as calamondin, are fruit-bearing plants native to the Philippines. They grow small white flowers that bear small citrus fruits over time.", 
      image: agricultureProductImages[5] 
    }, 
    { id: 7, 
      name: "Product 7", 
      price: "$10", 
      description: "Calamansi plants, also known as calamondin, are fruit-bearing plants native to the Philippines. They grow small white flowers that bear small citrus fruits over time.", 
      image: agricultureProductImages[6] 
    }, 
    { id: 8, 
      name: "Product 8", 
      price: "$10", 
      description: "Calamansi plants, also known as calamondin, are fruit-bearing plants native to the Philippines. They grow small white flowers that bear small citrus fruits over time.", 
      image: agricultureProductImages[7] 
    }, 
    { id: 9, 
      name: "Product 9", 
      price: "$10", 
      description: "Calamansi plants, also known as calamondin, are fruit-bearing plants native to the Philippines. They grow small white flowers that bear small citrus fruits over time.", 
      image: agricultureProductImages[8] 
    }, 
    { id: 10, 
      name: "Product 10", 
      price: "$10", 
      description: "Calamansi plants, also known as calamondin, are fruit-bearing plants native to the Philippines. They grow small white flowers that bear small citrus fruits over time.", 
      image: agricultureProductImages[9] 
    }, 
    
  ];

  return (
    <div className="product-listing">
      {products.map(product => (
        <div className="product-card" key={product.id}>
          <img src={product.image} alt={product.name} />
          <div className="product-info">
            <h3>{product.name}</h3>
            <p>{product.description}</p>
            <button>{product.price} Add to Cart</button>
          </div>
        </div>
      ))}
    </div>
  );
}

export default ProductListing;
