#An example of a length 21 DNA string (whose alphabet contains the symbols 'A', 'C', 'G', and 'T') is "ATGCTTCAGAAAGGTCTTACG."

#Given: A DNA string s of length at most 1000 nt.

#Return: Four integers (separated by spaces) counting the respective number of times that the symbols 'A', 'C', 'G', and 'T' occur in s.
import sys

if __name__ == "__main__":
  if len(sys.argv) != 2:
    print("Usage:\n    python DNA.py <filename>")
    exit()

  with open(sys.argv[1]) as f:
    data = f.readline()
    print(str(data.count("A")) + " " + str(data.count("C")) + " " + str(data.count("G")) + " " + str(data.count("T")))