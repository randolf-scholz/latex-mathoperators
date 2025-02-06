# Package `mathoperators`

[Usage](#usage) | [Requirements](#requirements) | [Installation](#installation) | [Changelog](CHANGELOG.md) | [License](LICENSE)

This package provides a collection of math operators for LaTeX.
It is designed as a partial replacement for the `physics` package, and provides some additional features.

## Usage

```tex
\usepackage{mathoperators}
```

### Features

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
  - `\?`: creates question mark with `\mathrel` spacing. (Used for [ternary operator `p ? y : n`](https://en.wikipedia.org/wiki/Ternary_conditional_operator))
- Bunch of `\DecalaremathOperator`:
  - `\diag`, `\tr`, `\dom`, `\codom`, `\rank`, etc.

## Requirements

- `mathtools` package
- incompatible with `physics` package

## Installation

### 1. Global Installation

```bash
just install  # quick and dirty
```

```bash
./install.py --copy  # recommended
```

This will **copy** the files into your `$TEXMFHOME` directory (typically `~/texmf`), making them available to all your LaTeX projects.

### 2. Local Installation (e.g. for a specific project)

```bash
cd /path/to/your/project
git submodule add https://github.com/randolf-scholz/latex-mathoperators
./latex-mathoperators/install.py .  # creates texmf/ in your project directory
```

This will **symlink** the files into a local `texmf` directory of the current project,
so that you automatically get the latest version of the package when you update the submodule.

In order for $\LaTeX$ to use the local `texmf` directory, you need to set the `TEXMFHOME` environment variable to the correct path.

When compiling manually, use:

```bash
export TEXMFHOME=$PWD/texmf
pdflatex document.tex
```

When using `latexmk` / `OverLeaf`, simply add the following line to your `.latexmkrc` file:

```perl
use Cwd;
$ENV{'TEXMFHOME'}=getcwd.'/texmf/';
```
