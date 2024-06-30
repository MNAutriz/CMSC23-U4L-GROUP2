import { create } from 'domain';
import url, { fileURLToPath } from 'url';


const postedURL = 'https://www.google.com/search?q=hello+world';

const createdUrl = new URL(postedURL);
console.log(createdUrl);

const formattedURL = url.format(createdUrl);
console.log(formattedURL);
console.log(import.meta.url);
console.log(fileURLToPath(import.meta.url));
