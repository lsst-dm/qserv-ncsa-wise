import requests
import sys
url='http://lsst-qserv-master03:25081/ingest/trans'
database='wise_01'
response = requests.post(url, json={"database":database, "auth_key":"***"})
response.raise_for_status()
responseJson = response.json()
if not responseJson['success']:
    print("error: " + responseJson['error'], file=sys.stderr)
    sys.exit(1)
print(responseJson['databases'][database]['transactions'][0]['id'])
