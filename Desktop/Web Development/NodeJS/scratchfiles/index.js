import {posts, returnPosts, postLength} from './postController.js';
import {generateRandom, sumOfNumbers, numbers} from './utils.js'


let randomNumber = generateRandom();
console.log(`Random Number: ${randomNumber}`);

console.log(numbers);

let totalSum = sumOfNumbers(numbers);
console.log(`Total sum of numbers ${totalSum}`);


let lengthOfPosts = postLength();
console.log(posts);
console.log(`Post Length: ${lengthOfPosts}`)