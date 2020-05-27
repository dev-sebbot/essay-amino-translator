#Given: Two DNA strings s and t (each of length at most 1 kbp).
#Return: All locations of t as a substring of s (1-indexed)

import sys
import re

if __name__ == "__main__":
  if len(sys.argv) != 2:
    print("Usage:\n    python SUBS.py <filename>")
    exit()

  with open(sys.argv[1]) as f:
    data = f.readline()
    substring = f.readline()
    print(*[match.start() + 1 for match in re.finditer("(?=" + substring + ")", data)])