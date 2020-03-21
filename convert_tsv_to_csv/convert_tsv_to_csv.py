import csv

with open("filename") as f:
    read = csv.reader(f, delimiter="\t")
    with open("outfilename", "w+") as out:
        writer = csv.writer(out, delimiter=",", quotechar="\"")
        for elem in read:
            writer.writerow(elem)
