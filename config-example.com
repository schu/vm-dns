#!/bin/sh
set -e
sqlite3 pdns.sqlite3 \
  "INSERT INTO 'domains' ('id', 'name', 'type') \
  VALUES (1, 'example.com', 'NATIVE');"
sqlite3 pdns.sqlite3 \
  "INSERT INTO 'records' ('domain_id', 'name', 'type', 'content', 'ttl') \
  VALUES (1, 'example.com', 'SOA', 'dns.example.com hostmaster.example.com', 60);"
sqlite3 pdns.sqlite3 \
  "INSERT INTO 'records' ('domain_id', 'name', 'type', 'content', 'ttl') \
  VALUES (1, 'example.com', 'NS', 'dns.example.com', 60);"
sqlite3 pdns.sqlite3 \
  "INSERT INTO 'records' ('domain_id', 'name', 'type', 'content', 'ttl') \
  VALUES (1, 'dns.example.com', 'A', '10.8.8.8', 60);"
sqlite3 pdns.sqlite3 \
  "INSERT INTO 'records' ('domain_id', 'name', 'type', 'content', 'ttl') \
  VALUES (1, 'example.com', 'A', '10.8.8.8', 60);"
