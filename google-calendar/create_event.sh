#!/bin/bash

# Replace these variables with your own details
#CLIENT_ID="YOUR_CLIENT_ID"
#CLIENT_SECRET="YOUR_CLIENT_SECRET"
#REFRESH_TOKEN="YOUR_REFRESH_TOKEN"
CALENDAR_ID="primary"  # Use "primary" or your specific calendar ID

# Function to obtain a new access token using the refresh token
function get_access_token() {
  ACCESS_TOKEN=$(curl -s -X POST \
    -d "client_id=$CLIENT_ID" \
    -d "client_secret=$CLIENT_SECRET" \
    -d "refresh_token=$REFRESH_TOKEN" \
    -d "grant_type=refresh_token" \
    "https://oauth2.googleapis.com/token" | jq -r '.access_token')

  if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" == "null" ]; then
    echo "Failed to obtain access token."
    exit 1
  fi
}

# Obtain a new access token
get_access_token

# Event data in JSON format
EVENT_DATA=$(cat <<EOF
{
  "summary": "Terraform Demo Success",
  "description": "This event was created using Terraform!",
  "start": {
    "dateTime": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  },
  "end": {
    "dateTime": "$(date -u -d '+1 hour' +"%Y-%m-%dT%H:%M:%SZ")"
  }
}
EOF
)

# Make the API call to create the event
curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -d "$EVENT_DATA" \
  "https://www.googleapis.com/calendar/v3/calendars/$CALENDAR_ID/events" \
  | grep -q '"id":' && echo "Event created successfully!" || echo "Failed to create event."

