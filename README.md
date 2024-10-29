# Package `mathoperators`

[Usage](#usage) | [Requirements](#requirements) | [Installation](#installation)

## Usage

```tex
\usepackage{mathoperators}
```

This package provides:

- Alternatives implementations to some macros from to the `physics` package, and hence is incompatible with it:
  - `\dd{}`: infinitesimal element in integration
  - `\pdv{}`: partial derivatives
  - `\dv{}`: total derivatives
  - `\eval{}`: function restriction
  - `\qq{text}`: shorthand for `\quad\text{...}\quad`
- Some beamer-aware redefinitions:
  - `\underbrace<overlay>{base}_{sub}`, `\overbrace<overlay>{base}^{sup}`
  - `\underbracket<overlay>{base}_{sub}`, `\overbracket<overlay>{base}^{sup}`
  - `\underset<overlay>{base}{sub}`, `\overset<overlay>{base}{sup}`
- Shortcuts for matrices:
  - `\bmat{1 & 2 \\ 3 & 4}` equivalent to `\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}`
  - similar: `\mat`, `\pmat`.
  - smallmatrix variants: `\smat`, `\bsmat`, `\psmat`
  - `\barr{cc}{1 & 2 \\ 3 & 4}` equivalent to `\left[\begin{array}{cc}1 & 2 \\ 3 & 4\end{array}\right]`.
  - similar: `\arr`, `\parr`
- Shortcuts for variable width decorators:
  - `\Hat` , `\Bar`, `\Tilde`, `\Vec` mapping to `\widehat`, `\overline`, `\widetilde`, `\overrightarrow`.
- Some symbols and operators
  - `\NA` and `\NaN` constants
  - `\defiff`, similar to ≝, but for ⟺.
  - `\?`: creates question mark with `\mathrel` spacing. (Used for [*where*-operator](https://en.wikipedia.org/wiki/Ternary_conditional_operator) `p ? y : n`
- Bunch of `\DecalaremathOperator`:
  - `\diag`, `\tr`, `\dom`, `\codom`, `\rank`, etc.

## Requirements

- `mathtools`, `amsmath`, `xparse`
- `letltxmacro` when using `beamer` redefinitions
- incompatible with `physics` package

## Installation

To include in a project, add this project as a submodule and create a symlink to the `mathoperators.sty` in `<git_root>/texmf/tex/latex/`:

```bash
git submodule add https://github.com/randolf-scholz/latex-mathoperators.git
# create local texmf if it doesn't already exists
mkdir -p texmf/tex/latex
# symlink the .sty files to the local texmf folder.
ln -s  texmf/tex/latex/mathoperators.sty  latex-mathoperators/texmf/tex/latex/mathoperators.sty
```

ensure when compiling that the `$TEXMFHOME` environment variable is set to `<project_root>/texmf/`:

```bash
export TEXMFHOME=texmf
latexmk main.tex
```

or add `$ENV{'TEXMFHOME'}=getcwd.'/texmf/';` to your `latexmk` file (requires `use Cwd;`)

This process can be automated with a script for all submodules:

```bash
for folder in "$PROJECT_ROOT"/dependencies/**/*/; do
  base="$(basename "$folder")"
  parent="$(dirname "$folder")/"
  if [ "$base" == "texmf" ]; then
    for file in "$folder"**; do
      # skip directories
      [ -d "$file" ] && continue
      dest="$PROJECT_ROOT/${file//$parent/}"
      echo "symlinking (relative) $(basename "$file")"
      echo -e "\tsource: $file"
      echo -e "\tdestination: $dest"
      mkdir -p "$(dirname "$dest")"
      ln -sfr "$file" "$dest"
    done
  fi
done
```
