import boto3  
import datetime  
import time  
import sys

def lambda_handler(event, context):
    print("Connecting to RDS")
    client = boto3.client('rds')
    date=time.strftime("%Y-%m-%d-%H-%M-%S")
    snapshot_name = event['identifier']+date
    
    response = client.delete_db_instance(
    DBInstanceIdentifier=event['identifier'],
    SkipFinalSnapshot=False,
    FinalDBSnapshotIdentifier=snapshot_name
    )