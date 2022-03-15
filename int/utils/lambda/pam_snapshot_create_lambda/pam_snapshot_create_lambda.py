import boto3  
import datetime  
import time  
import sys

#identifier should be passed
def lambda_handler(event, context):  
    my_session = boto3.session.Session()
    my_region = my_session.region_name
    print(my_region)
    prefix = "us-east-1-"
    if (my_region == 'us-west-2'):
        prefix = 'us-west-2-'
    elif (my_region == 'us-east-1'):
        prefix = 'us-east-1-'


    client = boto3.client('rds')
    date=time.strftime("%Y-%m-%d-%H-%M-%S")
    snapshot_name = prefix + event['identifier']+date
    print (snapshot_name)
    
    response = client.create_db_snapshot(
    DBSnapshotIdentifier= snapshot_name,
    DBInstanceIdentifier=event['identifier'],
        Tags=[
                {
                'Key': 'PAM',
                'Value': 'snapshot'
                }
            ]
    )