'use strict';

const mysql = require('mysql');
const fs = require('fs');

const sqlStatement = fs.readFileSync('snapshot.sql') + '';

const doit = new Promise((resolve, reject) => {

  const con = mysql.createConnection({
    host: 'newswirescalendar-cluster.cluster-cgoj1wekjubc.us-east-1.rds.amazonaws.com',
    user: 'nwcalendar',
    password: 'nwcalendar',
    database: 'newswirescalendar',
    multipleStatements: true
  });

  con.query(sqlStatement, (err, result) => {
    if (err) reject(err);
    for (var i = 0; i < result.length; i++) {
      console.log(result[i]);
    }
    resolve("Complete!");
  });
});

doit.then((res) => {
  console.log(res);
  process.exit(0);
}).catch((err) => {
  console.log("err");
  process.exit(1);
});
