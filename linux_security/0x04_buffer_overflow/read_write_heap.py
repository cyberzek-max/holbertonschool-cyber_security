#!/usr/bin/python3
"""
read_write_heap.py - search and replace a string in the heap of a running process
Usage: read_write_heap.py pid search_string replace_string
"""

import sys

if len(sys.argv) != 4:
    sys.exit(1)

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

if len(replace) > len(search):
    sys.exit(1)

maps_path = f"/proc/{pid}/maps"
mem_path = f"/proc/{pid}/mem"

heap_start = heap_end = None
try:
    with open(maps_path, 'r') as maps:
        for line in maps:
            if "[heap]" in line:
                heap_start, heap_end = [int(x, 16) for x in line.split(' ')[0].split('-')]
                break
except Exception:
    sys.exit(1)

if heap_start is None:
    sys.exit(1)

try:
    with open(mem_path, 'r+b') as mem:
        mem.seek(heap_start)
        heap_data = mem.read(heap_end - heap_start)
        index = heap_data.find(search)
        if index != -1:
            mem.seek(heap_start + index)
            mem.write(replace.ljust(len(search), b'\x00'))
except Exception:
    sys.exit(1)

# Only print once at the end
