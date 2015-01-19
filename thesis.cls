\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\LoadClass[twoside, titlepage]{scrreprt}

\RequirePackage{fixltx2e}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{microtype}
\RequirePackage{polyglossia}
\RequirePackage[natbib, style=authoryear, maxnames=2]{biblatex}
\RequirePackage{booktabs}
\RequirePackage[all]{onlyamsmath}
\RequirePackage{siunitx}
\RequirePackage[english,iso]{isodate}
\RequirePackage{xspace}
\RequirePackage{hyperref}

% General settings

\setmainlanguage[variant=uk]{english}
\setmainfont[Ligatures=TeX, Numbers=OldStyle]{TeX Gyre Pagella}
\setsansfont[Ligatures=TeX, Numbers=OldStyle]{Linux Biolinum}
\isodash{\ensuremath{\cdot}}% Replacement for `‧` = U+‧2027 HYPHENATION POINT

\DefineBibliographyStrings{english}{andothers = {\&~al\adddot}}

\graphicspath{{gfx/}}

% General helper commands

\newcommand*\todo[1]{%
    \textcolor[HTML]{A00000}{\textbf{|}}%
    \marginpar{\textcolor[HTML]{A00000}{\textbf{To do:}\\#1}}}

\let\labelfont\textbf

\newcommand*\textfigure[4][float]{%
    % #1: alignment (default: float)
    % #2: figure name (equals label)
    % #3: figure caption
    % #4: figure description
    % TODO: Implement proper positioning
    \begin{figure}
        \centering
        \includegraphics[width=\textwidth]{#2}
        \caption{\label{fig:#2}\labelfont{#3} #4}
    \end{figure}
}

\newcommand*\hashtag[1]{%
    {\footnotesize\textcolor[HTML]{808080}{\#}\kern 0.1em}#1}

\newcommand*\newspecies[2]{%
    % #1: species label
    % #2: species name to print
    \csdef{species@#1}{#2}
}

\newcommand*\species[1]{\textit{\csuse{species@#1}}\xspace}

\newspecies{mmu}{Mus musculus}
\newspecies{hsa}{Homo sapiens}

\newcommand*\abbrev[3][]{%
    % #1 [optional] long description
    % #2 macro name
    % #3 expanded abbreviation
    \csdef{#2}{%
        \ifblank{#1}{\hashtag{#3}}{#1 (\hashtag{#3})}%
        \csdef{#2}{#3\xspace}%
        \xspace}}

\input{abbreviations.tex}

% Organisation

\newcommand*\chapterfile[1]{\input{#1.tex}}

% Titles

\def\gobbleuntil#1\relax{}

\def\initialof#1{#1\gobbleuntil}

\def\initialsof#1 #2\relax{%
    \expandafter\initialof#1\relax%
    \notblank{#2}{\initialsof#2 \relax}{}}

\newcommand*\initials[1]{\initialsof#1 \relax}

\newcommand*\second[1]{{\small \initials{#1}}}

% vim:ft=tex
\endinput
