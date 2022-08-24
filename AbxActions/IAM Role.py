def handler(context, inputs):
    import boto3
    client = boto3.client('ec2')
    
    VMid = inputs["externalIds"][0]
    print("VMid =", VMid)
    
    response = client.associate_iam_instance_profile(
        IamInstanceProfile={
            'Name':'CloudWatchAgentAdminRole'
        }, 
        InstanceId = VMid)
    
    outputs = {"outputJSON: ":response}
    
    return outputs