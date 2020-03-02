INCLUDE += -I glad/include -I include
CFLAGS += -std=gnu11 -Os
LDFLAGS += -lglfw3 -lGL -lpthread -lm -ldl
XLDFLAGS += -lX11 -lXrandr -lXi -lXcursor -lXxf86vm -lXinerama
EMFLAGS += -s WASM=1 -s NO_EXIT_RUNTIME=1 -s USE_GLFW=3 -s FULL_ES2=1 -s FULL_ES3=1 --preload-file $(PWD)/glsl@/glsl --preload-file $(PWD)/textures@/textures

SRC += $(wildcard src/*.c)

.PHONY: x
x:
	mkdir -p build/
	$(CC) $(CFLAGS) $(INCLUDE) $(SRC) glad/src/glad.c $(LDFLAGS) $(XLDFLAGS) -o build/main

.PHONY: em
em:
	mkdir -p dist/
	emcc $(EMFLAGS) $(CFLAGS) $(INCLUDE) $(SRC) $(LDFLAGS) -o dist/main.js

.PHONY: clean
clean:
	rm -rf dist/ build/
