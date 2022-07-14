const { MongoClient, ServerApiVersion } = require('mongodb');


const appConfig = require("@azure/app-configuration");
const connection_string = process.env.AZURE_APP_CONFIG_CONNECTION_STRING;
const configClient = new appConfig.AppConfigurationClient(connection_string);

async function run() {
  
  let clusterHost = await configClient.getConfigurationSetting({
    key: "TestApp:Settings:Message"
  });

    console.log("Retrieved value:", clusterHost);
    

const uri = `mongodb+srv://main-user:<password>@${clusterHost.value}/?retryWrites=true&w=majority`;
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true, serverApi: ServerApiVersion.v1 });
client.connect(err => {
    const collection = client.db("test").collection("devices");
    collection.find()
  // perform actions on the collection object
  client.close();
});
  
//   retrievedSetting = await configClient.getConfigurationSetting({
//     key: "Mongo:User:Login"
//   });

//   console.log("Retrieved value:", retrievedSetting.value);
  
//   retrievedSetting = await configClient.getConfigurationSetting({
//     key: "Mongo:User:Credential"
//   });

//   console.log("Retrieved value:", retrievedSetting.value);
  
//   retrievedSetting = await configClient.getConfigurationSetting({
//     key: "cluster-connection-string"
//   });

//   console.log("Retrieved value:", retrievedSetting.value);
}

run().catch((err) => console.log("ERROR:", err));
