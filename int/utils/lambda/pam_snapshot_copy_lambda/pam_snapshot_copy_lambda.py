import boto3  
import botocore  
import datetime  
import re  
import logging

print('Loading function')

def byTimestamp(snap):  
  if 'SnapshotCreateTime' in snap:
    return datetime.datetime.isoformat(snap['SnapshotCreateTime'])
  else:
    return datetime.datetime.isoformat(datetime.datetime.now())

def lambda_handler(event, context): 
    my_session = boto3.session.Session()
    my_region = my_session.region_name
    print(my_region)

    if (my_region == 'us-west-2'):
        copyfrom_region = 'us-east-1'
    elif (my_region == 'us-east-1'):
        copyfrom_region = 'us-west-2'
    
    client = boto3.client("sts")
    account_id = client.get_caller_identity()["Account"]
    print(account_id)
    
    client1_otherregion = boto3.client('rds',copyfrom_region)
    client1 = boto3.client('rds')
    source_snaps = client1_otherregion.describe_db_snapshots(DBInstanceIdentifier = event['identifier'])['DBSnapshots']
    #print ("DB_Snapshots:", source_snaps)
    source_snap = sorted(source_snaps, key=byTimestamp, reverse=True)[0]['DBSnapshotIdentifier']
    #print ("DB Latest Snapshots:", source_snap)
    print ("arn:aws:rds:us-west-2:"+account_id+":snapshot:" + source_snap)
    
    if my_region == 'us-west-2':
        print(my_region)
        client1.copy_db_snapshot(
            SourceDBSnapshotIdentifier="arn:aws:rds:us-east-1:"+account_id+":snapshot:"+source_snap,
            TargetDBSnapshotIdentifier=source_snap)
    elif my_region == 'us-east-1':
        print(my_region)
        client1.copy_db_snapshot(
            SourceDBSnapshotIdentifier="arn:aws:rds:us-west-2:"+account_id+":snapshot:"+source_snap,
            TargetDBSnapshotIdentifier=source_snap)