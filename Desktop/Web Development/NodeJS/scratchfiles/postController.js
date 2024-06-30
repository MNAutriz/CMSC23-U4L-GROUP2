export const posts = [
    {id: 1, body: 'Hello world!',author: 'Neil'},
    {id: 2, body: 'Hello mars!',author: 'Mark'},
    {id: 3, body: 'Hello universe!',author: 'Autriz'},
]

export const returnPosts = () => posts;

export function postLength() {
    return posts.length;
} 
