\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\LoadClass{scrreprt}

\RequirePackage{fixltx2e}
\RequirePackage{fontspec}
\RequirePackage{microtype}
\RequirePackage{polyglossia}
\RequirePackage{biblatex}
\RequirePackage{booktabs}
\RequirePackage[all]{onlyamsmath}
\RequirePackage{siunitx}
\usepackage[english,iso]{isodate}
\RequirePackage{hyperref}

\setmainlanguage[variant=uk]{english}
\isodash{‧}

\newcommand*\chapterfile[1]{\input{#1.tex}}

% vim:ft=tex
\endinput
