import http from 'http';
import url from 'url';
import path from 'path';
import fs from 'fs/promises';

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const PORT = 8000;

const server = http.createServer( async(req, res) => {
    try{
        if(req.method === 'GET'){
            let filepath;
            if(req.url === '/'){
                filepath = path.join(__dirname, '/public', '/index.html');
                console.log(filepath);
            } else if(req.url === '/about'){
                filepath = path.join(__dirname, '/public', '/about.html');
                console.log(filepath);
            } else {
                filepath = path.join(__dirname, '/public', '/error.html');
                console.log(filepath);
            }

            const data = await fs.readFile(filepath);
            res.setHeader('Content-Type', 'text/html');
            res.write(data);
            res.end();

        } else {
            throw new Error('Invalid request method');
        }
    } catch(error) {
        res.writeHead(500, {
            "Content-Type" : "text/html"
        })
        res.end(`<h1> Server Error Detected ${error}</h1>`);
    }
});

server.listen(PORT, () => {
    console.log(`Server is listening to PORT ${PORT}`);
});
