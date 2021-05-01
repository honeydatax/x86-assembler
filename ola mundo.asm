proc printout  msgptr:word
     mov    dx, [msgptr]
     mov    ah, 9
     int    21h
     ret
endp