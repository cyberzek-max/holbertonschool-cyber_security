#!/bin/bash
showmount -e $1 | grep -E '\*|0\.0\.0\.0'
