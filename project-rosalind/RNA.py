#Given a DNA string t corresponding to a coding strand, its transcribed RNA string u is formed by replacing all occurrences of 'T' in t with 'U' in u

#Given: A DNA string t having length at most 1000 nt.

#Return: The transcribed RNA string of t

import sys

if __name__ == "__main__":
  if len(sys.argv) != 2:
    print("Usage:\n    python RNA.py <filename>")
    exit()

  with open(sys.argv[1]) as f:
    print(f.readline().replace('T', 'U'))