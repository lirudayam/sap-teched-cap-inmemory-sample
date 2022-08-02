# Getting Started: Sample CAP in-memory demo purposes

This is a sample CAP project with some metadata. For demonstration ourposes it does not require any outlying database like a HANA or PostgreSQL database. It utilises a SQLite database within the Cloud Foundry container.

## Start locally

1. Make sure you have run an "npm install" in the directory.
2. Run the cds watch command

If you have any modifications to the data model or updated base mock data, please run following command to persist them in the in-memory SQLite database:
cds deploy --to sqlite

## Deploy to Cloud

Prerequisities:
1. Make sure you have the cf cli installed (locally or via BAS)
2. Make sure you are logged in to CF via cf login or other UI-based login
3. Make sure you point to a CF space, you have access to
4. Update the manifest.yml to show to the correct cloud foundry landscape, e.g. eu10 or us10

Actions:
1. Run the shell script deploy.sh
2. Get the route (no authentication required)

## OData Service

For some sample you have a sample.http file