def main():
    q = 5
    N = 512
    answer = 1
    for elem in range(1, q):
       answer *= 1 - (elem/N)
    print(1 - answer)

if __name__ == "__main__":
    main()
