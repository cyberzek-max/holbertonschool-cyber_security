#!/usr/bin/python3
"""
read_write_heap.py - search and replace a string in the heap of a running process
Usage: read_write_heap.py pid search_string replace_string
"""

import sys
import os

if len(sys.argv) != 4:
    print("Usage: {} pid search_string replace_string".format(sys.argv[0]))
    sys.exit(1)

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

if len(replace) > len(search):
    print("Error: replace string longer than search string")
    sys.exit(1)

maps_path = f"/proc/{pid}/maps"
mem_path = f"/proc/{pid}/mem"

# Find heap region
heap_start = heap_end = None
try:
    with open(maps_path, 'r') as maps:
        for line in maps:
            if "[heap]" in line:
                heap_start, heap_end = [int(x, 16) for x in line.split(' ')[0].split('-')]
                break
except Exception as e:
    print("Error reading maps:", e)
    sys.exit(1)

if heap_start is None:
    print("Heap not found")
    sys.exit(1)

# Open mem and modify
try:
    with open(mem_path, 'r+b') as mem:
        mem.seek(heap_start)
        heap_data = mem.read(heap_end - heap_start)
        index = heap_data.find(search)
        if index == -1:
            print("Search string not found in heap")
            sys.exit(0)
        mem.seek(heap_start + index)
        mem.write(replace.ljust(len(search), b'\x00'))
        print(f"Replaced '{search.decode()}' with '{replace.decode()}' at {hex(heap_start + index)}")
except PermissionError:
    print("Permission denied: you may need sudo")
    sys.exit(1)
except Exception as e:
    print("Error:", e)
    sys.exit(1)
