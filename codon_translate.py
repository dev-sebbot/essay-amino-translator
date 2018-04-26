import sys

codons = {
    "a": "Ala ",
    "b": "",
    "c": "Cys ",
    "d": "Asp ",
    "e": "Glu ",
    "f": "Phe ",
    "g": "Gly ",
    "h": "His ",
    "i": "Ile ",
    "j": "",
    "k": "Lys ",
    "l": "Leu ",
    "m": "Met ",
    "n": "Asn ",
    "o": "",
    "p": "Pro ",
    "q": "Gln ",
    "r": "Arg ",
    "s": "Ser ",
    "t": "Thr ",
    "u": "",
    "v": "Val ",
    "w": "Trp ",
    "x": "",
    "y": "Tyr ",
    "z": "",
    " ": "--",
    ".": "",
    ",": "",
    ";": "",
    "!": "",
    "'": "",
    "\n": "\n"
}

def translate(data):
    ret = " "

    lower_data = data.lower()

    for elem in lower_data:
        ret += codons[elem] + " "

    return ret


def main():
    if not len(sys.argv) == 2:
        print("Usage:\n    python3 codon_translate.py <ASCII file>")
        return 1

    with open (sys.argv[1]) as file:
        data = file.read()
        print(translate(data))
        return 0


if __name__ == "__main__":
    main()
