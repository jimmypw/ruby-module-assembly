require 'mkmf'

system("make -C solve")

create_makefile('quantbet/quantbet')

system("sed -i 's|^LOCAL_LIBS.*$|LOCAL_LIBS = solve/solve.o|' Makefile")
