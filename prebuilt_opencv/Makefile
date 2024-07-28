CXX = g++
CXXFLAGS = `pkg-config --cflags opencv4`
LDFLAGS = `pkg-config --libs opencv4`

TARGET = testing

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(TARGET).cpp $(LDFLAGS)

clean:
	rm -f $(TARGET)

