#CC = gcc
CC = clang-3.8
#For older gcc, use -O3 or -O2 instead of -Ofast
#CFLAGS = -lm -pthread -Ofast -march=native -funroll-loops -Wno-unused-result
CFLAGS = -O2 -march=native -fsanitize=address -fno-omit-frame-pointer -funroll-loops -Wno-unused-result -pthread 
LDFLAGS = -lm
BUILDDIR := build
SRCDIR := src

SRC := $(wildcard $(SRCDIR)/*.c)
EXEC := glove shuffle cooccur vocab_count

all: dir $(EXEC:=.exec)

dir :
	@echo "[LOG]: Building $(BUILDDIR)"
	@echo "[LOG]: Source files $(SRC)"
	mkdir -p $(BUILDDIR)

%.exec: $(SRCDIR)/%.c
	@echo "Building $@ from $<"
	$(CC) $< -o $(BUILDDIR)/$(@:.exec=) $(CFLAGS) $(LDFLAGS)

# glove : $(SRCDIR)/glove.c
# 	$(CC) $(SRCDIR)/glove.c -o $(BUILDDIR)/glove $(CFLAGS)
# shuffle : $(SRCDIR)/shuffle.c
# 	$(CC) $(SRCDIR)/shuffle.c -o $(BUILDDIR)/shuffle $(CFLAGS)
# cooccur : $(SRCDIR)/cooccur.c
# 	$(CC) $(SRCDIR)/cooccur.c -o $(BUILDDIR)/cooccur $(CFLAGS)
# vocab_count : $(SRCDIR)/vocab_count.c
# 	$(CC) $(SRCDIR)/vocab_count.c -o $(BUILDDIR)/vocab_count $(CFLAGS)

clean:
	rm -rf build $(EXEC)
