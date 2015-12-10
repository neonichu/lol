.PHONY: all clean

all:
	swift build
	./.build/debug/lol list

clean:
	swift build --clean
