CRYSTAL_BIN ?= $(shell which crystal)

all: bin/gembot

bin/gembot:
	$(CRYSTAL_BIN) build -o bin/gembot src/gembot.cr

clean:
	rm -rf .crystal bin/gembot

.PHONY: test
test:
	$(CRYSTAL_BIN) spec