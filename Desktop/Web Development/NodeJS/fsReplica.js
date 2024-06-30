import fs from 'fs/promises';


const readingFiles = async () => {
    const data = await fs.readFile('./test.txt', 'utf8');
    console.log(data);
}

const writingFiles = async () => {
    await fs.writeFile('./test.txt', 'OH THIS IS THE FILE WHICH IS WRITTEN!');
    console.log('Written successfully.');
}


const appendFiles = async () => {
    await fs.appendFile('./test.txt', '\nTHIS IS THE APPEND MESSAGE')
    console.log('Appended successfully.');
}

writingFiles();
appendFiles();
readingFiles();

