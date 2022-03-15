'use strict'
const AWS = require('aws-sdk');
const rds = new AWS.RDS();

exports.handler = (event, context, callback) => {
  console.log("=========================== Event ======================");
  console.log(JSON.stringify(event));
  console.log("========================================================");

  const mysql = require('mysql');
  const fs = require('fs');

  const sqlStatement = fs.readFileSync('snapshot.sql') + '';

  const dbConn = mysql.createConnection({
    host: event.ClusterEndpoint,
    user: event.DbUsername,
    password: event.DbPassword,
    database: event.DbName,
    multipleStatements: true
  });

  const createDbStructure = new Promise((resolve, reject) => {
    dbConn.query(sqlStatement, (err, result) => {
      if (err) reject(err);
      // for (var i = 0; i < result.length; i++) {
      //   console.log(result[i]);
      // }
      resolve("Database Structure Succesfully created and lookup tables populated!");
    });
  });
  
  const disableEventRule = (ruleName, cb) => {
    const AWS = require('aws-sdk');
    
    const cwEvents = new AWS.CloudWatchEvents({ apiVersion: '2015-10-07' });

    const params = {
      Name: ruleName
    };

    cwEvents.disableRule(params, (err, data) => {
      if (err) {
        console.log(`*********** Error dsiabling rule ${params.Name}`);
        console.log(JSON.stringify(err));
      } else {
        cb("Rule Successfully disabled");
        
        
      }
    });
  }

  const deleteSnapshot = (params, cb) => {
    console.log('================ DELETE =================');
    rds.deleteDBClusterSnapshot(params, (err, data) => {
      if (err) {
        console.log(`Error deleting snapshot: ${JSON.stringify(err)}`); 
        cb();
      }
      else {
        console.log(`Delete snapshot successfull: ${JSON.stringify(data)}`);
        cb(data);
      }
    });

  }

  createDbStructure.then((res) => {
    console.log(res);
    dbConn.end();
    disableEventRule(event.CwTimerRule, (res) => {
      console.log(res);
      let params = {
        DBClusterSnapshotIdentifier: `${event.ClusterId}-snapshot-final`
      };
      deleteSnapshot(params, (data) => {
        console.log(data);
      });
    });
  }).catch((err) => {
    console.log(`err: ${err}`);
    if (JSON.stringify(err).includes('ER_TABLE_EXISTS_ERROR')) {
      disableEventRule(event.CwTimerRule, (res) => {
      console.log(res);
    });
    }
    dbConn.end()
    callback();
  });
  
}

