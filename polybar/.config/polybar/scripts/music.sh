#!/usr/bin/env bash
INFO=$(http :47836/current 2> /dev/null)

TITLE=$( echo "$INFO" | jq -r '.title')
ARTIST=$( echo "$INFO" | jq -r '.artist')
STATUS=$( echo "$INFO" | jq -r '.status')

if [[ $STATUS = "playing" ]]; then
	echo "$TITLE - $ARTIST"
else
	echo "-"
fi
