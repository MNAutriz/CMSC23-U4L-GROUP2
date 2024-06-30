import { error } from 'console';
import fs from 'fs/promises';

const writeFile = async() => {
    await fs.writeFile('./test.txt', 'This is written through the asynchronous function');
    console.log('File is written.');
}

const readFile = async() => {
    const data = await fs.readFile('./test.txt', 'utf-8');
    console.log(data);
}

const appendFile = async() => {
    await fs.appendFile('./test.txt', '\nIts the line that is actually appended hahahaha.');
    console.log('Content is appended.');
}

writeFile();
appendFile();
readFile();   
