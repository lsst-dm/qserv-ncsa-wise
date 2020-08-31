import glob
total_num_rows = 0
for fname in glob.glob('count/*'):
    file = open(fname, 'r')
    for l in file:
        num_rows = int(l.split()[0])
        total_num_rows = total_num_rows + num_rows
        break
print total_num_rows
        
