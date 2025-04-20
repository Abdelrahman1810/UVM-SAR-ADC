def extract_sections(filename):
    numberOfTest = 0
    with open(filename, 'r') as file:
        lines = file.readlines()

    output = []
    extract = False

    for i, line in enumerate(lines):
        # First extraction block
        if "UVM_INFO @ 0" in line:
            extract = True
            numberOfTest += 1

        if extract:
            output.append(line.rstrip())

        if extract and "** Note: $finish" in line:
            extract = False
            output.append("")

        # Second extraction block
        if "# Coverage Report" in line:
            # output.append(lines[i-1].rstrip())
            output.append(line.rstrip())
            i += 1
            while i < len(lines):
                output.append(lines[i].rstrip())
                if "# Total coverage" in lines[i]:
                    break
                i += 1

        # Third extraction block
        if "# CAPSTATS REPORT" in line:
            output.append(lines[i-1].rstrip())
            output.append(line.rstrip())
            i += 1
            while i < len(lines):
                output.append(lines[i].rstrip())
                if "END CAPSTATS REPORT" in lines[i]:
                    output.append(lines[i+1].rstrip())
                    break
                i += 1

    return '\n'.join(output), numberOfTest

filename = 'transcript'
result, numberOfTest = extract_sections(filename)

if numberOfTest == 1:
    filename = "../Reports/AnalysisData_SingleTest.txt"
    print("SingleTest")
else:
    filename = "../Reports/AnalysisData_MultiTest.txt"
    print("MultiTest")

with open(filename, 'w') as file:
    file.write(result)


