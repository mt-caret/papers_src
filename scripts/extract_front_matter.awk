NR == 1 && /---/ { dashes = 1 }
NR > 1 && dashes > 0 && /---/ { dashes = dashes + 1 }
NR > 1 && dashes == 1 && $1 == "title:" { print $0 }
