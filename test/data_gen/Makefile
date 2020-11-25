BIN = gen
SRCS= gen.c
OBJS= gen.o

PKGS = 

CFLAGS  += -g -Wall -Werror
CPPFLAGS+= -I. -D_GNU_SOURCE
all: $(BIN) data

$(BIN): $(OBJS)
	$(CC) $(OBJS) ${LDFLAGS} -o ${BIN}

$(OBJS): %.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $<

clean:
	-rm -rf $(BIN) *.o *.core

.PHONY: install clean data

-include $(DEPS)
