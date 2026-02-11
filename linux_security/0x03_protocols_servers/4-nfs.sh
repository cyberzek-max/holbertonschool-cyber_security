#!/bin/bash
showmount -e localhost | grep -E '\*|0\.0\.0\.0'
