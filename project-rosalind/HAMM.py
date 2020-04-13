#Given two strings s and t of equal length, the Hamming distance between s and t, denoted dH(s,t), is the number of corresponding symbols that differ in s and t.

#Given: Two DNA strings s and t of equal length (not exceeding 1 kbp).

#Return: The Hamming distance dH(s,t).
import sys

if __name__ == "__main__":
  if len(sys.argv) != 2:
    print("Usage:\n    python HAMM.py <filename>")
    exit()

  with open(sys.argv[1]) as f:
    hamming_distance = 0

    dna1 = f.readline()
    dna2 = f.readline()

    for i in range(0, len(dna1)-1):
      if(dna1[i] != dna2[i]):
        hamming_distance = hamming_distance + 1
    print(hamming_distance)