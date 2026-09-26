#!/usr/bin/env bash
# Test Neovim folding configuration

echo "======================================"
echo "  Neovim Folding Setup Test"
echo "======================================"
echo

# Create a test Python file
cat > /tmp/fold_test.py << 'PYTHON'
def function_one():
    """First function"""
    print("Function 1")
    for i in range(5):
        print(i)

def function_two():
    """Second function"""
    return 42

class MyClass:
    def __init__(self):
        self.value = 100

    def method_one(self):
        return self.value * 2

    def method_two(self):
        for x in range(3):
            print(x)
PYTHON

echo "Test file created: /tmp/fold_test.py"
echo
echo "Opening Neovim with the test file..."
echo
echo "Instructions:"
echo "1. Neovim will open the test Python file"
echo "2. Try these folding shortcuts:"
echo "   - <Space>z  : Toggle fold at cursor"
echo "   - <Space>zm : Close all folds"
echo "   - <Space>zr : Open all folds"
echo "3. You should see function and class definitions folded"
echo "4. Press 'q' to quit"
echo
read -p "Press Enter to continue..."

# Open nvim with the test file
nvim /tmp/fold_test.py
