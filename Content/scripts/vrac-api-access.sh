#Assign the API token variable
url='https://api.mgmt.cloud.vmware.com'
api_token='Your_UI_Token'


#Request the Access Token

access_token=`curl -X POST "$url/iaas/api/login" -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{ "refreshToken": "'$api_token'" }' | jq -r .token`


#Verify the access token variable is assigned
echo $access_token
