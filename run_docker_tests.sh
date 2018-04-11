#!/bin/sh


docker build --tag jira_swift .
docker run --rm jira_swift