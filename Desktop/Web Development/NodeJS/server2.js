import {createServer} from 'http';
const PORT = process.env.PORT;

//Middleware for looking at the method and url.
const loggerMiddleware = (req, res, next) => {
    console.log(`${req.method}, ${req.url}`);
    next();
}

//Middleware for conversion of the content type to JSON.
const jsonMiddleware = (req, res, next) => {
    res.setHeader('Content-Type', 'application/json');
    next();
}

//Function for finding user through their id.
const findUserById = (req, res) => {
    const id = req.url.split('/')[3];
    const foundUser = users.find((user) => user.id === Number(id));
    if(foundUser){
        res.write(JSON.stringify(foundUser));
    } else {
        res.statusCode = 404; 
        requestWriteHandler(res, {"message": 'User not found.'})
    }
}

//Displaying the route is not found.
const routeNotFound = (req, res) => {
    res.statusCode = 404;
    requestWriteHandler(res, {"message": 'Invalid Route OR Request'})
}

//Use to write the content in the file.
const requestWriteHandler = (res, content) => {
    res.write(JSON.stringify(content));
}

const addUserHandler = (req, res) => {
    let body = '';
    req.on('data', (chunk) => {
        body += chunk.toString();
    });
    req.on('end', () => {
        const newUser = JSON.parse(body);
        users.push(newUser);
        res.statusCode = 201;
        res.write(JSON.stringify(newUser));
        res.end();
    })
}

//Creation of the server.
const server = createServer((req, res) => {
    loggerMiddleware(req, res, () => {
        jsonMiddleware(req, res, () => {
            try{
                if(req.url === '/api/users' && req.method === 'GET'){
                res.write(JSON.stringify(users));
            } else if (req.url.match(/\/api\/users\/([0-9]+)/) && req.method === 'GET'){
                findUserById(req, res);
            } else if (req.url === '/api/users' && req.method === 'POST'){
                addUserHandler(req, res);
            }
            else { 
                routeNotFound(req, res);
            } 
            res.end();
            
            } catch(error){
                console.log(`ERROR FOUND ${error}`);
            }
        })
    })
})


const users = [
    {id: 1, name: 'Mark Neil', age:20},
    {id: 2, name: 'Guinday Autriz', age:10},
    {id: 3, name: 'Mcniall Gaindei', age:30}
]

server.listen(PORT, () => {
    console.log(`Listening to port ${PORT}`);
})
