#Given a DNA string t, return its reverse complement t^c

import sys

def complement(char):
  if char == "A":
    return "T"
  if char == "T":
    return "A"
  if char == "C":
    return "G"
  if char == "G":
    return "C"

if __name__ == "__main__":
  if len(sys.argv) != 2:
    print("Usage:\n    python REVC.py <filename>")
    exit()

  with open(sys.argv[1]) as f:
    print(''.join(map(complement, f.readline()))[::-1])