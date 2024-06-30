import { EventEmitter } from 'events';

const myEmitter = new EventEmitter();

function helloHandler(name) {
    console.log(`Hello ${name}!`);
}

function goodbyeHandler(place){
    console.log(`Goodbye ${place}!`);
}

myEmitter.on('greet', helloHandler);
myEmitter.on('goodbye', goodbyeHandler);

myEmitter.emit('greet', 'Neil');
myEmitter.emit('goodbye', 'Manila');

myEmitter.on('error', (error) => {
    console.log(`Error detected: ${error}`);
})

myEmitter.emit('error', new Error('the path is not defined'));
