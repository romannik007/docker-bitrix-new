#!/bin/bash

mkdir /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
mysqld --daemonize