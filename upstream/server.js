const express = require('express')
const app = express()
const port = 3000;

const EdService = require('./EdService')
const myArgs = process.argv.slice(2);


app.get('/', async(req, res) => {
  const edService = new EdService('https://api.ecoledirecte.com/v3', myArgs[0], myArgs[1], myArgs[2])
  const { token }=await edService.auth()
  res.send(await edService.read(token))
})

app.listen(port, () => {
  console.log(`Server start and availaible on  http://localhost:${port}/`)
})
