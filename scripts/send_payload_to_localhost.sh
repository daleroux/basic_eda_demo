#!/usr/bin/bash


curl -v -k -X POST http://localhost:5005/ \
  -H "Content-Type: application/json" \
  -d '{"event_type":"demo_webhook_event","source":"custom_webhook","timestamp":"2025-08-01T14:00:00Z","user":{"username":"dleroux","role":"admin","email":"daniel.leroux@example.com"},"system":{"hostname":"webserver-01","ip_address":"192.168.1.10","os":"Fedora 39","uptime_seconds":483920},"alert":{"severity":"warning","category":"disk_space","message":"Disk usage at 85% on /var","threshold_percent":80,"current_percent":85},"tags":["infra","monitoring","test","EDA"],"debug_mode":true}'



