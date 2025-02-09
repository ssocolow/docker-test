const express = require('express');
const { exec } = require('child_process');
const app = express();
const port = 3003;

app.get('/ping', (req, res) => {
    exec('./script.sh', (error, stdout, stderr) => {
        if (error) {
            console.error(`Error executing script: ${error}`);
            return res.status(500).send(`Error executing script: ${error.message}`);
        }
        console.log(`Script output: ${stdout}`);
        res.send(`Script executed successfully!\nOutput: ${stdout}`);
    });
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
}); 