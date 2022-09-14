root@tkg-jump-box [ ~/vra ]# cat connect-vra.sh

#Assign values to the variables for the hostname of your vRealize Automation appliance,
#your user name, and your password.

identity_service_url='vRA_URL'
username='your_User'
password='Your_Password'

#Use the Identity Service API to obtain the API token.
#the API token is also known as the refresh token. It is valid for 90 days
#and can be used to generate a new access token when the access token expires

api_token=`curl --insecure -X POST \
  "$identity_service_url/csp/gateway/am/api/login?access_token" \
  -H 'Content-Type: application/json' \
  -d '{
  "username": "'"$username"'",
  "password": "'"$password"'"
}' | jq -r .refresh_token`

echo ""


# Verify the API token variable is assigned
echo "API token is:"
echo "-------------"
echo $api_token
echo ""

#With the API token assigned, use the IaaS API to request the access token.

access_token=`curl --insecure -X POST \
  "$identity_service_url/iaas/api/login" \
  -H 'Content-Type: application/json' \
  -s \
  -d '{
  "refreshToken": "'"$api_token"'"
}' | jq -r .token`

#Verify the access token variable is assigned.

echo "Access token is:"
echo "----------------"

echo $access_token
