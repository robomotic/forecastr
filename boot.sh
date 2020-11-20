#!/bin/sh

#exec gunicorn -b :5000 --access-logfile - --error-logfile - app:app
exec gunicorn -b :5000 --worker-class eventlet -w 1 app:app --timeout 120