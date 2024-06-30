import crypto from 'crypto';

const hash = crypto.createHash('sha256');
hash.update('password123');
console.log(hash.digest('hex'));

crypto.randomBytes(16, (err, data) => {
    if(err){
        throw new Error('Error is detected');
    } 
    console.log(data.toString('hex'));
})