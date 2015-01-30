\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\LoadClass[twoside, titlepage]{scrreprt}

\RequirePackage{fixltx2e}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{xcolor}
\RequirePackage{microtype}
\RequirePackage{polyglossia}
\RequirePackage[natbib, style=authoryear, maxnames=2]{biblatex}
\RequirePackage{booktabs}
\RequirePackage[all]{onlyamsmath}
\RequirePackage{siunitx}
\RequirePackage[english,iso]{isodate}
\RequirePackage{xspace}
\RequirePackage{scalefnt}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{ragged2e}
\RequirePackage{ifoddpage}
\RequirePackage{hyperref}
% “… cleveref must be loaded *last*”
\RequirePackage[nameinlink,noabbrev]{cleveref}

% General settings

\setmainlanguage[variant=uk]{english}
\graphicspath{{gfx/}}

% General formatting

\setmainfont[Ligatures=TeX, Numbers=OldStyle]{TeX Gyre Pagella}
\setsansfont[Ligatures=TeX, Numbers=OldStyle]{Linux Biolinum}
\isodash{\ensuremath{\cdot}}% Replacement for `‧` = U+‧2027 HYPHENATION POINT

\DefineBibliographyStrings{english}{andothers = {\&~al\adddot}}

\captionsetup{%
    format=plain,
    font={sf,small},
    labelfont={bf},
    labelformat=simple,
    labelsep=colon,
    justification=justified}

\renewcommand*\thefootnote{\fnsymbol{footnote}}

% General programming tools

\def\gobbleuntil#1\relax{}

\def\initialof#1{#1\gobbleuntil}

\def\initialsof#1 #2\relax{%
    \expandafter\initialof#1\relax%
    \notblank{#2}{\initialsof#2 \relax}{}}

\newcommand*\initials[1]{\initialsof#1 \relax}

\def\secondword#1 #2{#2}

% General helper commands

\newcommand*\todo[1]{%
    \textcolor[HTML]{A00000}{\textbf{|}}%
    \marginpar{
        \colorbox{pink}{\parbox{\marginparwidth}{%
            \RaggedRight%
            \vskip2pt
            \leftskip2pt\rightskip2pt
            \textcolor[HTML]{A00000}{\textsf{\textbf{To do:}\\#1}}
            \vskip2pt}}}}

\let\labelfont\textbf

\newcommand*\figcap[3]{\caption{\label{fig:#1}\labelfont{#2} #3}}

\newcommand\spillfigure[2][]{%
    % #1: alignment (default: float)
    % #2: figure contents
    % TODO: Implement proper positioning
    % By default, we spill into the outer margin. Because we can.
    % Use <http://tex.stackexchange.com/a/10507/42> to align properly.
    \begin{figure}[h]
        \checkoddpage%
        \edef\side{\ifoddpage l\else r\fi}%
        \makebox[\textwidth][\side]{#2}%
    \end{figure}}

\newcommand\textfigure[5][float]{%
    % #1: alignment (default: float)
    % #2: figure label
    % #3: figure contents
    % #4: figure caption
    % #5: figure description
    \spillfigure{%
        \begin{minipage}{1.2\textwidth}
            #3\figcap{#2}{#4}{#5}
        \end{minipage}}}

\newcommand\textfig[4][float]{%
    % #1: alignment (default: float)
    % #2: figure name (equals label)
    % #3: figure caption
    % #4: figure description
    \textfigure[#1]{#2}{\includegraphics[width=\textwidth]{#2}}{#3}{#4}}

\newcommand*\hashtag[1]{%
    {\mbox{\scalefont{0.75}\textcolor[HTML]{808080}{\#}\kern0.1em}#1}}

\newcommand*\newspecies[2]{%
    % #1: species label
    % #2: species name to print
    \csdef{species@#1}{%
        \global\csdef{species@#1}{\initialof#2\relax.~\secondword#2}%
        #2}}

\newcommand*\species[1]{\textit{\csuse{species@#1}}\xspace}

\newspecies{mmu}{Mus musculus}
\newspecies{hsa}{Homo sapiens}

\newcommand*\abbrev[3][]{%
    % #1 [optional] long description
    % #2 macro name
    % #3 expanded abbreviation
    \csdef{abbrev@#2}##1{%
        % FIXME Why does the following command definition only require two
        % `#`s to define its arguments, and not three?
        \global\csdef{abbrev@#2}##1{#3##1}%
        \ifblank{#1}{\hashtag{#3}##1}{#1##1 (\hashtag{#3})}}%
    \expandafter\newrobustcmd\expandafter*\csname #2\endcsname[1][]{%
        \csuse{abbrev@#2}{##1}\xspace}}

\input{abbreviations.tex}

% From <http://tex.stackexchange.com/a/74469/42>
\newcommand*\reducedstrut{%
    \vrule width 0pt height .9\ht\strutbox depth .9\dp\strutbox\relax}

\newcommand*\name[1]{\textsf{#1}}

\newcommand*\dfn[1]{\emph{#1}}

\newcommand*\gene[1]{\textit{#1}}

\newcommand*\protein[1]{\textrm{#1}}

% Formatting of biological sequences

\newcommand*\seq[1]{\mbox{\texttt{#1}}}

\newcommand*\mismatch[1]{%
    % Fix for spacing from <http://tex.stackexchange.com/a/74469/42>
    \begingroup
    \setlength\fboxsep{0pt}%
    \colorbox[HTML]{FFA0A0}{\reducedstrut#1\/}%
    \endgroup}

% Organisation

\newcommand*\chapterfile[1]{\input{#1.tex}}

% Titles

\newcommand*\second[1]{{\initials{#1}}}

% vim:ft=tex
\endinput
