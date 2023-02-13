with open('../data/keep.txt', 'r') as f:
    start_date = f.read()
    start_date = start_date[0:5]
    
    f.close()

print(start_date)

with open('../data/keep.txt', 'w') as f:

    f.write(start_date)
    f.close()
    
