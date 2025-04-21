def sqrt_nr(x, i):
    if i == 0:
        return 1
    
    prev_sqrt = sqrt_nr(x, i-1)
    return (prev_sqrt + x/prev_sqrt) / 2