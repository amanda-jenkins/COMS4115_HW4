#!/bin/bash

# Check if a source code file was provided as an argument!
if [ "$#" -ne 1 ]; then
  echo "Usage: ./run_compiler.sh <source_code_file>"
  exit 1
fi

SOURCE_FILE=$1

# Check if file exists
if [ ! -f "$SOURCE_FILE" ]; then
  echo "Error: File '$SOURCE_FILE' not found!"
  exit 1
fi

# Step 1: Scanner
echo "Running scanner..."
python3 scanner.py "$SOURCE_FILE" > tokens.txt

if [ $? -ne 0 ]; then
  echo "Error: Scanner failed."
  exit 1
fi

# Step 2: Parser
echo "Running parser..."
python3 parser1.py tokens.txt > parser_output.txt 2>&1

if [ $? -ne 0 ]; then
  echo "Error: Parser failed:"
  cat parser_output.txt
  exit 1
fi

# This checks for parser errors in output
if grep -q "Errors detected:" parser_output.txt; then
  echo "Parser reported errors:"
  cat parser_output.txt
  exit 1
fi

echo "Parsing completed successfully. The AST is saved to 'generated_ast.json'."

# Step 3: Code Generation Stage
echo "Running code generation..."
python3 code_gen.py generated_ast.json

if [ $? -ne 0 ]; then
  echo "Error: Code generation failed."
  exit 1
fi

echo "Code generation completed successfully. Output saved to 'output_code.c'."

# Step 4: Code Optimization
echo "Optimizing generated code..."
python3 code_optimization.py

if [ $? -ne 0 ]; then
  echo "Error: Code optimization failed."
  exit 1
fi

echo "Code optimization completed successfully. Output saved to 'optimized_code.c'."

# Step 5: Compilation of optimized code
echo "Compiling optimized C code..."
gcc -o optimized_output optimized_code.c

if [ $? -ne 0 ]; then
  echo "Error: Compilation of optimized C code failed."
  exit 1
fi

# Step 6: Run!
echo "Running the optimized program..."
./optimized_output

if [ $? -ne 0 ]; then
  echo "Error: Execution of optimized program failed."
  exit 1
fi

echo "Program executed successfully. Output displayed above."
