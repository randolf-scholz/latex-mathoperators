# Define the default task
export NAME := "mathoperators"
export BUILD_DIR := ".build"
export RESULT_DIR := ".results"
export ROOT_DIR := `git rev-parse --show-toplevel`
export TEST_DIR := ROOT_DIR + "/tests"
export TEXMF_BASE_DIR := "texmf"
export TEXMF_DIR := TEXMF_BASE_DIR + "/tex/latex"


default:
  @just --list


install:  # install the LaTeX package
    cp -r src/* "$(kpsewhich -var-value TEXMFHOME)/tex/latex/"


clean:  # remove all .build directories
    find . -type d -name '{{BUILD_DIR}}' -prune -exec rm -rf {} \;
    find . -type d -name '{{RESULT_DIR}}' -prune -exec rm -rf {} \;


test_setup:  # create the build and result directories
    # cleanup the test directories
    rm -rf "{{TEST_DIR}}/{{BUILD_DIR}}"
    rm -rf "{{TEST_DIR}}/{{RESULT_DIR}}"
    rm -rf "{{TEST_DIR}}/{{TEXMF_BASE_DIR}}"
    # create the test directories
    mkdir -p "{{TEST_DIR}}/{{BUILD_DIR}}"
    mkdir -p "{{TEST_DIR}}/{{RESULT_DIR}}"
    mkdir -p "{{TEST_DIR}}/{{TEXMF_DIR}}"
    # simlink all files from src to tests/texmf/tex/latex
    ln -sr "{{ROOT_DIR}}/src/"* "{{TEST_DIR}}/{{TEXMF_DIR}}/"


[no-cd]
test_compile $file $compiler:
    #!/usr/bin/env bash
    name="$(basename $file '.tex')"
    OUTPUT_DIR="$BUILD_DIR/$compiler/$name"
    TARGET_DIR="$RESULT_DIR/$compiler"
    # define array with compiler options "-shell-escape" "-interaction=nonstopmode"
    options=(
        "-$compiler"
        "-output-directory=$OUTPUT_DIR"
    )
    # compile with -Werror
    errors=$(latexmk -Werror "${options[@]}" "$file" 2>&1)
    if [ $? -eq 0 ]; then
        ok="✅"
        mkdir -p "$TARGET_DIR"
        cp "$OUTPUT_DIR/$name.pdf" "$TARGET_DIR/$name.pdf"
    else
        errors=$(latexmk "${options[@]}" "$file" 2>&1)
        if [ $? -eq 0 ]; then
            ok="⚠️"
        else
            ok="❌"
        fi
    fi
    echo -e "$ok"


[no-cd]
test_one $file:  # compile a single test file
    #!/usr/bin/env bash
    # compile the file, catch the errors in a variable
    name="$(basename $file '.tex')"
    # compile with pdfLaTeX
    result_pdf=$(just test_compile "$file" "pdf")
    # compile with LuaLaTeX
    result_lua=$(just test_compile "$file" "pdflua")
    # compile with XeLaTeX
    result_xe=$(just test_compile "$file" "pdfxe")
    # print the results
    padded_name=$(printf "%-32s" "$name:")
    echo -e "$padded_name pdf=$result_pdf, lua=$result_lua, xe=$result_xe"


test $case="*":  # run all tests
    #!/usr/bin/env bash
    echo "Current directory: $PWD"
    cd "$TEST_DIR" || exit 1
    echo "Current directory: $PWD"
    just test_setup
    # detect all test files
    shopt -s nullglob
    files=(test_$case.tex)
    # run the tests in parallel
    echo "Running tests on ${#files[@]} test files."
    # exit 1
    for file in "${files[@]}"; do
        just test_one "$file" &
    done
    wait
