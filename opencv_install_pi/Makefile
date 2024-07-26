# Compiler
CXX = g++

# Compiler flags
CXXFLAGS = `pkg-config --cflags opencv4` -I/usr/local/include/opencv4/

# Linker flags
LDFLAGS = `pkg-config --libs opencv4`

# Source files
SRC = display_image.cpp

# Object files
OBJ = $(SRC:.cpp=.o)

# Executable
EXEC = display_image

# Build the executable
$(EXEC): $(OBJ)
	$(CXX) -o $@ $^ $(LDFLAGS)

# Compile source files into object files
%.o: %.cpp
	$(CXX) -c $< $(CXXFLAGS)

# Clean up
clean:
	rm -f $(OBJ) $(EXEC)

