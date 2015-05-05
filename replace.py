__author__ = 'erkrenz'
items = []

lines = []

with open('/home/erkrenz/NICTA-NDSU-National-Map/Integrated.csv', 'r') as file:



    for thing in file.readline().split(','):
        if thing != 'lga':
            items.append(thing)

with open('/home/erkrenz/NICTA-NDSU-National-Map/NSWVIC.kml', 'r') as file:
    lines = file.readlines()

counter = 0

newlines = []

for counter in range(0, 78):

    newlines = []
    print counter, " / ", 77
    if counter == 0:
        for line in lines:

            newlines.append(line.replace('Integrated', items[counter]))

    elif counter <= 9:
        for line in lines:
            newlines.append(line.replace('Integrat_' + str(counter), items[counter]))
    else:
        for line in lines:
            newlines.append(line.replace('Integrat' + str(counter), items[counter]))

    lines = newlines


with open('/home/erkrenz/NICTA-NDSU-National-Map/NSWVIC_headers.kml', 'w') as file:
    file.writelines(lines)