import requests
print("Welcome to 2022")
print("Welcome to the world of CI/CD")
headers = {"User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36"}

#Lets test what headers are sent by sending a request to HTTPBin
r1 = requests.get('http://httpbin.org/headers',headers = headers)
user_details = r1.text
print(user_details)

from user_agent import generate_user_agent, generate_navigator
from pprint import pprint
print(generate_user_agent())
#pprint(generate_navigator())
