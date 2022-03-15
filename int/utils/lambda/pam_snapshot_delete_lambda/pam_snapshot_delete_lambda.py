import boto3
import datetime

def lambda_handler(event, context):
    print("Connecting to RDS")
    client = boto3.client('rds')
    
    for snapshot in client.describe_db_snapshots(DBInstanceIdentifier=event['identifier'], SnapshotType = 'manual',MaxRecords=50)['DBSnapshots']:
        print ("Deleting snapshot id:", snapshot['SnapshotCreateTime'])
        create_ts = snapshot['SnapshotCreateTime'].replace(tzinfo=None)
        print(create_ts)
        if create_ts < datetime.datetime.now() - datetime.timedelta(days=1):
            print ("Deleting snapshot id:", snapshot['DBSnapshotIdentifier'])
            client.delete_db_snapshot(
                DBSnapshotIdentifier=snapshot['DBSnapshotIdentifier']
            )