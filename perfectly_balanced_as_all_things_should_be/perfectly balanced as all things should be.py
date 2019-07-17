import sys, re

def main():
        found = []

        if len(sys.argv) != 2:
                print("Please pass in a file to be snapped.")
                sys.exit()

        with open(sys.argv[1], 'r+') as file:
                for line in file:
                        result = re.match('^\\s*<(Content|EmbeddedResource|Compile)\\s*Include="([^"]*)', line)
                        if result is None:
                                continue
                        
                        if(result.group(2) in found):
                                print("{0}".format(result.group(2)))
                        else:
                                found.append(result.group(2))
                
if __name__ == "__main__":
    main()