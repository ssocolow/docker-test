# app.py
from flask import Flask
import requests
import json



# Replace with your actual API key and external user ID
api_key = 'mGJSgLnE5VMqazBP2jCoqSJwTESBO0fL'
external_user_id = 'simon'

# Step 1: Create Chat Session
create_session_url = 'https://api.on-demand.io/chat/v1/sessions'
create_session_headers = {
    'apikey': api_key
}
create_session_body = {
    "pluginIds": [],
    "externalUserId": external_user_id
}

# Make the request to create a chat session
response = requests.post(create_session_url, headers=create_session_headers, json=create_session_body)
response_data = response.json()

# Extract the session ID from the response
session_id = response_data['data']['id']

# Step 2: Submit Query
submit_query_url = f'https://api.on-demand.io/chat/v1/sessions/{session_id}/query'
submit_query_headers = {
    'apikey': api_key
}



submit_query_body = {
    "endpointId": "predefined-openai-gpt4o",
    "query": "give me one creative and fun tip to help me eat healthier.",
    "pluginIds": ["plugin-1712327325", "plugin-1713962163"],
    "responseMode": "sync"
}

# Make the request to submit a query
query_response = requests.post(submit_query_url, headers=submit_query_headers, json=submit_query_body)
query_response_data = query_response.json()
healthyTip = query_response_data["data"]["answer"]
print(healthyTip)
# Print the response from the query submission
# print(query_response_data)



app = Flask(__name__)

@app.route('/info')
def home():
    streakInfo = {"current_streak": 6, "longest_streak": 10, "total_uploads": 23, "last_upload": "Yesterday", "healthy_tip": healthyTip}
    return streakInfo

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)

