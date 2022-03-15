import boto3  
import botocore  
import datetime  
import re  
import logging
import sys

print('Loading function')

def byTimestamp(snap):  
  if 'SnapshotCreateTime' in snap:
    return datetime.datetime.isoformat(snap['SnapshotCreateTime'])
  else:
    return datetime.datetime.isoformat(datetime.datetime.now())

#    identifier, db_instance_class and DBSubnetGroupName should be passed
def lambda_handler(event, context):  
    client = boto3.client('rds')    
    source_snaps = client.describe_db_snapshots(DBInstanceIdentifier = event['identifier'])['DBSnapshots']
    #print ("DB_Snapshots:", source_snaps)
    source_snap = sorted(source_snaps, key=byTimestamp, reverse=True)[0]['DBSnapshotIdentifier']
    print ("DB_Snapshots:", source_snap)
    response = client.restore_db_instance_from_db_snapshot(
        DBInstanceIdentifier=event['identifier'],
        DBSnapshotIdentifier=source_snap, 
        DBInstanceClass=event['db_instance_class'], 
        Engine='sqlserver-se', 
        DBSubnetGroupName=event['db_subnet_group_name'],
        MultiAZ=False, 
        PubliclyAccessible=False,
        Tags=[
            {
                'Key': 'owner',
                'Value': 'teamhercules@dowjones.com'
            },
            {
                'Key': 'environment',
                'Value': 'prod'
            },
            {
                'Key': 'bu',
                'Value': 'djin'
            },
            {
                'Key': 'product',
                'Value': 'platform'
            },
            {
                'Key': 'component',
                'Value': 'assets'
            },
            {
                'Key': 'Name',
                'Value': 'pam-rds'
            }
            ]
        )
    print(response)