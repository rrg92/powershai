/*
	Este é um pequeno web server para testar o Upload!
	foi gerado com ChatGPT, pode conter vários erros!
	O objetivo é me ajudar a testar uplodas feitos com o PowershAI, permitindo inspecionar como os dados chegam no server!
*/

const express = require('express');
const multer = require('multer');
const { v4: uuidv4 } = require('uuid');


const path = require('path');
const fs = require('fs');

// Initialize express
const app = express();
const port = 3000;


// Middleware to capture raw bytes
app.use((req, res, next) => {
  let data = [];
  
  // Listen for data chunks from the request stream
  req.on('data', chunk => {
    console.log("Chunk received...");
	data.push(chunk);
  });
  
 //// When the request ends, concatenate and log the raw bytes
 req.on('end', () => {
   const rawBody = Buffer.concat(data);
   console.log("content-type", req.headers );
   console.log('Raw Request Data (Bytes):', rawBody);
 });
 
  next()
 
});

app.use(express.text({type:"*/*"}));


// Ensure the "upfiles" directory exists, create if it doesn't
const uploadDir = './upfiles';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir); // Save to the "upfiles" directory
  },
  filename: (req, file, cb) => {
    // Append unique identifier to avoid duplicates
    const uniqueSuffix = uuidv4();
    const ext = path.extname(file.originalname);
    const baseName = path.basename(file.originalname, ext);
    const finalFileName = `${baseName}-${uniqueSuffix}${ext}`;
    console.log(`Saving file to: ${path.join(uploadDir, finalFileName)}`);  // Log the file path
    cb(null, finalFileName);
  },
});


const upload = multer({ storage: storage });

app.post('/upload', (req, res) => {
  upload.any()(req, res, (err) => {
    if (err) {
      console.error('Error during file upload:', err);
      return res.status(500).send('Error during file upload');
    }
	
	console.log("ContentType", req.headers["Content-Type"] );

    console.log('Form fields:');
    req.body && Object.keys(req.body).forEach(key => {
      console.log(`${key}: ${req.body[key]}`);
    });

    req.files && req.files.forEach(file => {
      console.log(`File uploaded: ${file.originalname}`);
    });

    res.send('Upload complete');
  });
});


app.use("/*", (req,res) => {
	console.log("body", req.body);
	res.status(200).send("ok");
})


// Start server
app.listen(port, () => {
  console.log(`Server listening on http://localhost:${port}`);
});
