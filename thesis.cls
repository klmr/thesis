\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\LoadClass[twoside, titlepage]{scrreprt}

\RequirePackage{fixltx2e}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{xcolor}
\RequirePackage{marginnote}
\RequirePackage{wrapfig}
\RequirePackage{microtype}
\RequirePackage{polyglossia}
\RequirePackage[natbib, style=authoryear, maxnames=2]{biblatex}
\RequirePackage{booktabs}
\RequirePackage[all]{onlyamsmath}
\RequirePackage{siunitx}
\RequirePackage{textcase}
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

%\newcommand\IfFloat[2]{\ifnum\@floatpenalty<0\relax#1\else#2\fi}

% From <http://tex.stackexchange.com/q/27172/42>
\newbool{detect@float}
\appto\@endfloatbox{\boolfalse{detect@float}}
\preto\@floatboxreset{\booltrue{detect@float}}
\newrobustcmd\IfFloat[2]{\ifbool{detect@float}{#1}{#2}}

\newcommand*\todo[1]{%
    \textcolor[HTML]{A00000}{\kern-0.2em\textbf{|}\kern-0.2em}%
    \ifmmode% for equations
        \let\mp\marginnote%
    \else
        \IfFloat{\let\mp\marginnote}{\let\mp\marginpar}
    \fi
    \mp{
        \colorbox{pink}{\parbox{\marginparwidth}{%
            \RaggedRight%
            \vskip2pt
            \leftskip2pt\rightskip2pt
            \textcolor[HTML]{A00000}{\textsf{\textbf{To do:}\\#1}}
            \vskip2pt}}}}

\let\labelfont\textbf

\newcommand*\figcap[3]{\caption{\label{fig:#1}\labelfont{#2} #3}}

\newcommand\align@body[1]{%
    \begin{figure}[h!]
        #1
    \end{figure}}

\newcommand\align@spill[1]{%
    % Use <http://tex.stackexchange.com/a/10507/42> to align properly.
    \begin{figure}[h!]
        \checkoddpage%
        \edef\side{\ifoddpage l\else r\fi}%
        \makebox[\textwidth][\side]{%
            \begin{minipage}{1.2\textwidth}
                #1
            \end{minipage}}
    \end{figure}}

\newcommand\align@wrap[1]{%
    \begin{wrapfigure}{o}{0.5\textwidth}
        #1
    \end{wrapfigure}}

\newcommand\textfloat[5]{
    % #1: label
    % #2: alignment command
    % #3: content
    % #4: figure caption
    % #5: figure description
    \csuse{align@#2}{%
        #3
        \figcap{#1}{#4}{#5}}}

\newcommand\textfloatbare[2]{
    % #1: alignment command
    % #2: content
    \csuse{align@#1}{#2}}

\newcommand\textfig[6][]{%
    % #1: label
    % #2: alignment command
    % #3: width
    % #4: figure caption
    % #5: figure description
    \textfloat{#2}{#3}{\centering\includegraphics[width=#4]{#2}#1}{#5}{#6}}

\newcommand*\textfigtwo[6]{%
    % #1 label 1
    % #2 figure caption 1
    % #3 figure description 1
    % #4 label 2
    % #5 figure caption 2
    % #6 figure description 2
    \textfloatbare{spill}{%
        \begin{minipage}{0.45\textwidth}
            \centering
            \includegraphics[width=\textwidth]{#1}
            \figcap{#1}{#2}{#3}
        \end{minipage}
        \hspace{0.1\textwidth}%
        \begin{minipage}{0.45\textwidth}
            \centering
            \includegraphics[width=\textwidth]{#4}
            \figcap{#4}{#5}{#6}
        \end{minipage}}}

%\newcommand*\hashtag[1]{%
%    {\mbox{\scalefont{0.75}\textcolor[HTML]{808080}{\#}\kern0.1em}#1}}
\newcommand*\hashtag[1]{#1}

\newcommand*\newspecies[2]{%
    % #1: species label
    % #2: species name to print
    \csdef{species@#1}{%
        \global\csdef{species@#1}{\initialof#2\relax.~\secondword#2}%
        #2}}

\newcommand*\species[1]{\textit{\csuse{species@#1}}\xspace}

\newspecies{mmu}{Mus musculus}
\newspecies{hsa}{Homo sapiens}

\newcommand*\abbr[1]{\csuse{abbr@#1}}

\newcommand*\abbrev[3][]{%
    % #1 [optional] long description
    % #2 macro name
    % #3 expanded abbreviation
    \csdef{abbr@#2}{#3}
    \csdef{abbrev@#2}##1{%
        % FIXME Why does the following command definition only require two
        % `#`s to define its arguments, and not three?
        \global\csdef{abbrev@#2}##1{\abbr{#2}##1}%
        \ifblank{#1}{\hashtag{\abbr{#2}}##1}{#1##1 (\hashtag{\abbr{#2}})}}%
    \expandafter\newrobustcmd\expandafter*\csname #2\endcsname[1][]{%
        \csuse{abbrev@#2}{##1}\xspace}}

\input{abbreviations.tex}

% From <http://tex.stackexchange.com/a/74469/42>
\newcommand*\reducedstrut{%
    \vrule width 0pt height .9\ht\strutbox depth .9\dp\strutbox\relax}

\newcommand*\name[1]{\textsf{#1}}

\newcommand*\identifier[1]{\texttt{#1}}

\newcommand*\dfn[1]{\emph{#1}}

\newcommand*\gene[1]{\textit{#1}}

\newcommand*\protein[1]{\textrm{#1}}

% Formatting of biological sequences

\newcommand*\seq[1]{\mbox{\texttt{#1}}}

\newcommand*\codon[1]{\seq{#1}}

\newcommand*\anticodon[1]{\MakeTextLowercase{\seq{#1}}}

\newcommand*\mismatch[1]{%
    % Fix for spacing from <http://tex.stackexchange.com/a/74469/42>
    \begingroup
    \setlength\fboxsep{0pt}%
    \colorbox[HTML]{FFA0A0}{\reducedstrut#1\/}%
    \endgroup}

\newenvironment{shortenumerate}{%
    \begin{enumerate}
        \setlength\itemsep{0pt}
        \setlength\parskip{0pt}
        \setlength\parsep{0pt}}
    {\end{enumerate}}

\newenvironment{shortitemize}{%
    \begin{itemize}
        \setlength\itemsep{0pt}
        \setlength\parskip{0pt}
        \setlength\parsep{0pt}}
    {\end{itemize}}

% Organisation

\newcommand*\chapterfile[1]{\input{#1.tex}}

% Titles

\newcommand*\second[1]{{\initials{#1}}}

% vim:ft=tex
\endinput
