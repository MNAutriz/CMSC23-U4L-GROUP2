export let numbers = [0, 1, 2, 3, 4, 5];

export function generateRandom(){
    return Math.floor(Math.random() * 100) + 1;
}

export function sumOfNumbers(numbers){
    let sum = 0;
    let length = numbers.length;

    numbers.forEach((number) => {
        sum += number;
    }) 
    return sum;
}