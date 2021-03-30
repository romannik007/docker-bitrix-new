#!/bin/bash

systemctl disable --now mysql
systemctl disable --now httpd
systemctl disable --now httpd-scale
systemctl disable --now nginx

