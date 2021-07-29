import boto3
import iamzero

iamzero.init()

# loads the region that you have specified in your AWS CLI configuration
my_session = boto3.session.Session()
region = my_session.region_name

# if the user hasn't defined a region, choose a fallback region, since this is just an example
if not region:
    region = "us-west-1"
    print(f"Warning: AWS_REGION not found, defaulting to {region}...")


ec2 = boto3.client('ec2', region_name=region)

# currently we don't have a recommendation in place for ec2.describe_instances()
# we'll aim for coverage of EC2 APIs ASAP - in which case we'll need to update this example
# to be a different API!
ec2.describe_instances()
