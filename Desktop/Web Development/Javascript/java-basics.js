/* Java script tutorials */

//🔢 Math and Functions
/* It is best practice to convert the money in cents instead of peso considering that it requires you to remove the 
inaccuracies created by storing float values. */
console.log((2095+799)/100);
console.log(Math.round((2095+799)*0.1)/100);

//🧵 Strings
var itemCost = ((2095+799)/100).toFixed(2);
console.log(`Shipping summary: `);
console.log('Items (2)' + '\t\t' + `$${itemCost}`);
