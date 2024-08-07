const mysql = require('mysql2');

// Load environment variables
require('dotenv').config();

let connection; // Explicitly declare the connection variable

function handleDisconnect() {
    connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
    });

    connection.connect(err => {
        if (err) {
            console.error('Error connecting to MySQL with DB:', err);
            setTimeout(handleDisconnect, 2000);
        }
    });

    connection.on('error', err => {
        console.error('MySQL error', err);
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            handleDisconnect();
        } else {
            throw err;
        }
    });
}
// First connection
handleDisconnect(); 

module.exports = connection; // Export the connection variable