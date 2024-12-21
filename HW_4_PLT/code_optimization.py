def optimize_code(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    optimized_lines = []
    displayed_matrices = set()
    computed_results = set()
    constant_expressions = {}

    for line in lines:
        stripped_line = line.strip()

        if "printMatrix" in stripped_line:
            matrix_name = stripped_line.split("(")[-1].strip(");")
            if matrix_name in displayed_matrices:
                continue
            displayed_matrices.add(matrix_name)

        if "=" in stripped_line and "+" not in stripped_line and "*" not in stripped_line:
            parts = stripped_line.split("=")
            if len(parts) == 2:
                variable, value = parts[0].strip(), parts[1].strip(";").strip()
                if value.isdigit():
                    constant_expressions[variable] = int(value)

        if "C[i][j]" in stripped_line and "A[i][k] * B[k][j]" in stripped_line:
            if stripped_line in computed_results:
                continue
            computed_results.add(stripped_line)

        if "for" in stripped_line and "int" not in stripped_line:
            optimized_lines.append("\n")

        optimized_lines.append(line)

    with open(output_file, 'w') as f:
        f.writelines(optimized_lines)

    print("Code optimization completed. Optimized code saved to", output_file)


def main():
    input_file = "output_code.c"
    output_file = "optimized_code.c"
    optimize_code(input_file, output_file)


if __name__ == "__main__":
    main()
