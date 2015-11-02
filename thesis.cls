\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\LoadClass[twoside, titlepage, DIV=8, BCOR=8.5mm, open=right]{scrreprt}

\RequirePackage{fixltx2e}
\RequirePackage{xltxtra}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{pifont}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{setspace}
\RequirePackage[markcase=lower]{scrlayer-scrpage}
\RequirePackage{xcolor}
\RequirePackage{marginnote}
\RequirePackage{float}
\RequirePackage[inline]{enumitem}
\RequirePackage{wrapfig}
\RequirePackage{microtype}
\RequirePackage{tocstyle}
\RequirePackage{polyglossia}
\RequirePackage[natbib, backend=biber, style=authoryear, maxnames=2, useprefix]{biblatex}
\RequirePackage{booktabs}
\RequirePackage{tabu}
\RequirePackage{longtable}
\RequirePackage{collcell}
\RequirePackage[all]{onlyamsmath}
\RequirePackage{siunitx}
\RequirePackage{nth}
\RequirePackage{textcase}
\RequirePackage[english, iso]{isodate}
\RequirePackage{xspace}
\RequirePackage[version=3]{mhchem}
\RequirePackage{minted}
\RequirePackage[explicit]{titlesec}
\RequirePackage{scalefnt}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{ragged2e}
\RequirePackage{ifoddpage}
\RequirePackage[xindy, toc, nopostdot]{glossaries}
\RequirePackage{hyperref}
% “… cleveref must be loaded *last*”
\RequirePackage[nameinlink, noabbrev]{cleveref}

% General settings

\setmainlanguage[variant=uk]{english}
\graphicspath{{gfx/}{gfx/supplements/}}

% General formatting

\setmainfont[Ligatures=TeX, Numbers=OldStyle]{TeX Gyre Pagella}
\setsansfont[
    Ligatures=TeX,
    UprightFont={* Light},
    BoldFont={*},
    ItalicFont={* Light Italic},
    BoldItalicFont={* Italic},
    Scale=MatchLowercase
]{Gill Sans}
\setmonofont[Scale=MatchLowercase]{WenQuanYi Zen Hei Mono}
\setmathfont[
    Extension=.otf,
    BoldFont=*bold,
]{xits-math}

% Small caps used in abbreviations – should only be enabled for Roman family.

\newif\ifthesis@roman
\thesis@romantrue
% Needs to be robust, see http://tex.stackexchange.com/q/239940/42
\DeclareRobustCommand*\abbrsc[1]{%
    \ifthesis@roman%
        \texorpdfstring{\textsc{\MakeTextLowercase{#1}}}{#1}%
    \else
        #1%
    \fi}
% Lower-case letters in small caps abbreviations.
\DeclareRobustCommand*\lowsc[1]{%
    \ifthesis@roman%
        \texorpdfstring{\protect\scalebox{0.8}{#1}}{#1}%
    \else
        #1%
    \fi}

% Adjust font settings.

\let\thesis@old@rm\rmfamily
\renewcommand*\rmfamily{%
    \thesis@old@rm%
    \thesis@romantrue}

\let\thesis@old@sf\sffamily
\renewcommand*\sffamily{%
    \thesis@old@sf%
    \thesis@romanfalse}

% Adjust bibliography styling.

\AtEveryCite{%
    \let\bibopenparen=\bibopenbracket%
    \let\bibcloseparen=\bibclosebracket}

\DefineBibliographyStrings{english}{andothers = {\&~al\adddot}}

\setkomafont{title}{\rmfamily\Huge}
\setkomafont{subject}{\normalfont\normalcolor}
\isodash{\ensuremath{\cdot}}% Replacement for `‧` = U+‧2027 HYPHENATION POINT

\definecolor{cambridgeblue}{RGB}{163, 193, 173}
\definecolor{cambridgebluedark}{RGB}{17, 94, 103}

% rgb(66,158,182)
% rgb(222,137,80)
% rgb(77,185,102)
% rgb(243,181,251)
% rgb(231,190,5)
\definecolor{primary}{HTML}{429EB6}
\definecolor{secondary}{HTML}{DE8950}
\definecolor{tertiary}{HTML}{4DB966}
\definecolor{quarternary}{HTML}{F3B5FB}
\definecolor{quinary}{HTML}{E7BE05}
\newcommand*\primaryname{blue}
\newcommand*\secondaryname{orange}
\newcommand*\tertiaryname{green}
\newcommand*\quarternaryname{purple}
\newcommand*\quinaryname{yellow}

\colorlet{thesis@toccolor}{black}
\colorlet{thesis@linkcolor}{black!70}

\definecolor{codenormal}{HTML}{404040}
\AtBeginEnvironment{minted}{\color{codenormal}}
\usemintedstyle{klmrthesis}

\hypersetup{
    hypertexnames=false,
    linktoc=all,
    colorlinks,
    citecolor=thesis@linkcolor,
    linkcolor=thesis@linkcolor,
    filecolor=thesis@linkcolor,
    urlcolor=thesis@linkcolor
}

\usetocstyle{nopagecolumn}
%\settocstylefeature[0]{pagenumberbox}{\@gobble}
\setkomafont{partentry}{\bfseries\addfontfeature{LetterSpace=10}}
\setkomafont{chapterentry}{\bfseries}
\settocstylefeature[-1]{pagenumberbox}{\@gobble}

\let\old@amp\&
\def\&{\textit{\old@amp}}

\captionsetup{%
    format=plain,
    font={sf,small},
    labelfont={bf},
    labelformat=simple,
    labelsep=colon,
    justification=justified}

\renewcommand*\thefootnote{\fnsymbol{footnote}}

\pagestyle{scrheadings}
\automark[chapter]{chapter}
\renewcommand*\headfont{%
    \small%
    \scshape%
    \thesis@romanfalse%
    \addfontfeature{LetterSpace=10}}

% FIXME Does not work.
\renewcommand*\partformat{\Huge\addfontfeature{LetterSpace=10}\MakeTextUppercase{\partname}}

\newcommand*\thesis@chapternumber{%
    \rmfamily%
    \fontsize{72}{72}%
    \color{black!50}%
    %\color{cambridgeblue}%
    \mdseries%
    \selectfont}

\setkomafont{chapter}{%
    \rmfamily%
    \fontsize{28}{32}%
    \color{black}%
    \selectfont}

\newlength\thesis@chapter@width
\newlength\thesis@chapter@orig

\titleformat{\chapter}
{\gdef\chapterlabel{}}
{\begingroup%
    \usekomafont{chapter}%
    \gdef\chapterlabel{\thechapter}%
\endgroup}% label
{0pt}% Sep
{\begingroup%
    \usekomafont{chapter}%
    \setlength\thesis@chapter@orig{\textwidth}%
    \setlength\thesis@chapter@width{\textwidth}%
    \addtolength\thesis@chapter@width{\marginparwidth}%
    \addtolength\thesis@chapter@width{\marginparsep}%
    \makebox[\textwidth][l]{%
        \begin{minipage}{\thesis@chapter@width}
            \begin{minipage}[t]{\thesis@chapter@orig}
                \hyphenpenalty=10000%
                \exhyphenpenalty=10000%
                \raggedright#1%
            \end{minipage}%
            \hspace{\marginparsep}%
            {\thesis@chapternumber\addfontfeature{Numbers=Lining}{\chapterlabel}}
        \end{minipage}}
    \endgroup%
    \setbox0\vbox{\use@preamble{chapter@u}%
    \vskip-\parskip}%
    \setlength\@tempdimb{\ht0}%
    \addtolength\@tempdimb{\dp0}%
    \box0%
\vskip-\@tempdimb}% Before

\titlespacing*{\chapter}{0pt}{0pt}{*15}

\newcommand\thesis@heading[1]{%
    \MakeTextLowercase{#1}}
\renewcommand\chaptermark[1]{\markboth{\thesis@heading{#1}}{\thesis@heading{#1}}}

\sisetup{detect-all}

\onehalfspacing

\renewcommand*\dictumwidth{0.75\textwidth}
\renewcommand*\dictumauthorformat[1]{---~#1}

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

\definecolor{todocolor@box}{HTML}{FFCCCC}
\definecolor{todocolor@text}{HTML}{A00000}
\definecolor{refcolor@box}{HTML}{DDFFBB}
\definecolor{refcolor@text}{HTML}{00A000}

\newcommand\todo@inline[1]{%
    \noindent\kern-0.5ex
    \colorbox{todocolor@box}{\parbox{\textwidth}{%
        \color{todocolor@text}\sffamily\textbf{To do:} #1}}}

\newcommand\todo@side[1]{\todo@side@do{#1}{todocolor}}

\newcommand\todo@ref[1]{%
    \ifstrequal{#1}{}{\def\ref@text{reference}}{\def\ref@text{#1}}%
    \todo@side@do{\ref@text}{refcolor}}

\newcommand\todo@side@do[2]{%
    \textcolor{#2@text}{\kern-0.2em\textbf{|}\kern-0.2em}%
    \ifinner%
        \let\mp\marginnote%
    \else
        \ifmmode%
            \let\mp\marginnote%
        \else
            \IfFloat{\let\mp\marginnote}{\let\mp\marginpar}%
        \fi
    \fi
    \mp{
        \colorbox{#2@box}{\parbox{\marginparwidth}{%
            \RaggedRight%
            \vskip2pt
            \leftskip2pt\rightskip2pt
            \textcolor{#2@text}{\textsf{\textbf{To do:}\\#1}}
            \vskip2pt}}}}

\newcommand\todo[2][side]{\@nameuse{todo@#1}{#2}}

\let\labelfont\textbf

\newcommand*\figcap[3]{\caption[#2]{\label{fig:#1}\labelfont{#2} #3}}
\newcommand*\figcapof[3]{\captionof{figure}[#2]{\label{fig:#1}\labelfont{#2} #3}}

\newcommand*\tabcap[3]{%
    \begingroup%
    \def\@captype{table}
    \caption[#2]{\label{tab:#1}\labelfont{#2} #3}
    \endgroup}

\newcommand*\tabcapof[3]{\captionof{table}[#2]{\label{tab:#1}\labelfont{#2} #3}}

\newcommand*\floatpos{!ht}

\newcommand\align@body[2]{%
    % http://tex.stackexchange.com/a/11342/42
    \expandafter\figure\expandafter[\floatpos]%
        #1%
        #2%
    \endfigure}

\newlength\fig@align@width

\newcommand\align@spill[2]{%
    % http://tex.stackexchange.com/a/11342/42
    \expandafter\figure\expandafter[\floatpos]%
        % Use <http://tex.stackexchange.com/a/10507/42> to align properly.
        \checkoddpage%
        \edef\side{\ifoddpage l\else r\fi}%
        \setlength\fig@align@width{\textwidth}
        \addtolength\fig@align@width{\marginparwidth}
        \addtolength\fig@align@width{\marginparsep}
        \makebox[\textwidth][\side]{%
            \begin{minipage}{\fig@align@width}
                #1%
            \end{minipage}}
            #2%
    \endfigure}

\newcommand\alignwrap@impl[3][]{
    \setlength\wrapoverhang{\marginparwidth}
    \addtolength\wrapoverhang\marginparsep
    \setlength\fig@align@width{\wrapoverhang}
    \addtolength\fig@align@width{#2}
    \begin{wrapfigure}[#1]{o}{\fig@align@width}
        #3%
    \end{wrapfigure}}

\newcommand\align@wrap[2]{\alignwrap@impl{0.5\textwidth}{#1#2}}

% Thin wrapper around align@wrap, for use in the document instead of
% textfloat(bare), when the width needs to be set explicitly.

\let\alignwrap\alignwrap@impl

\newcommand\textfloat[5]{
    % #1: label
    % #2: alignment command
    % #3: content
    % #4: figure caption
    % #5: figure description
    \csuse{align@#2}{#3}{\figcap{#1}{#4}{#5}}}

\newcommand\textfloatbare[3]{
    % #1: alignment command
    % #2: content
    % #3: non-spilled content
    \csuse{align@#1}{#2}{#3}}

\newcommand\textfig[6][]{%
    % #1: content inside figure (optional)
    % #2: label
    % #3: alignment command
    % #4: width
    % #5: figure caption
    % #6: figure description
    \textfloat{#2}{#3}{\centering\includegraphics[width=#4]{#2}#1}{#5}{#6}}

\newcommand*\textfigtwo[6]{%
    % #1 label 1
    % #2 figure caption 1
    % #3 figure description 1
    % #4 label 2
    % #5 figure caption 2
    % #6 figure description 2
    \textfloatbare{spill}{%
        \begin{minipage}[b]{0.48\textwidth}
            \centering
            \includegraphics[width=\textwidth]{#1}
        \end{minipage}
        \hspace{0.04\textwidth}%
        \begin{minipage}[b]{0.48\textwidth}
            \centering
            \includegraphics[width=\textwidth]{#4}
        \end{minipage}\\[-\baselineskip]
        \begin{minipage}[t]{0.48\textwidth}
            \figcap{#1}{#2}{#3}
        \end{minipage}
        \hspace{0.04\textwidth}%
        \begin{minipage}[t]{0.48\textwidth}
            \figcap{#4}{#5}{#6}
        \end{minipage}}}

\newcommand*\marginfig[1]{\includegraphics[width=\marginparwidth]{#1}}

\newcommand*\toverline[1]{\ensuremath{\overline{\hbox{#1}}\m@th}}
\newcommand*\periodic[1]{{\mbox{(#1)}}}

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
\newspecies{dmel}{Drosophila melanogaster}
\newspecies{cel}{Caenorhabditis elegans}
\newspecies{eco}{Escherichia coli}
\newspecies{scer}{Saccharomyces cerevisiae}

\newcommand*\abbr[1]{\csuse{abbr@#1}}

% The following needs global versions of (re)newcommand.
% This implementation is form http://tex.stackexchange.com/a/51750/42.
\def\gnewcommand{\g@star@or@long\gnew@command}
\def\grenewcommand{\g@star@or@long\grenew@command}
\def\g@star@or@long#1{%
  \@ifstar{\let\l@ngrel@x\global#1}{\def\l@ngrel@x{\long\global}#1}}
\def\gnew@command#1{\@testopt{\@gnewcommand#1}0}
\def\@gnewcommand#1[#2]{%
  \kernel@ifnextchar [{\@gxargdef#1[#2]}%
                {\@argdef#1[#2]}}
\let\@gxargdef\@xargdef
\patchcmd{\@gxargdef}{\def}{\gdef}{}{}
\let\grenew@command\renew@command
\patchcmd{\grenew@command}{\new@command}{\gnew@command}{}{}

\newcommand*\abbrev[3][]{%
    % #1 [optional] long description
    % #2 macro name
    % #3 expanded abbreviation
    \csdef{abbr@#2}{#3}
    \ifblank{#1}{}{\newacronym{#2}{#3}{#1}}%
    \expandafter\gnewcommand\csname abbrev@#2\endcsname[1]{%
        \expandafter\grenewcommand\csname abbrev@#2\endcsname[1]{\abbr{#2}####1}%
        \ifblank{#1}{\define{\abbr{#2}}##1}{#1##1 (\define{\abbr{#2}})}}%
    \expandafter\newrobustcmd\expandafter*\csname #2\endcsname[1][]{%
        \csuse{abbrev@#2}{##1}\xspace}}

% List of abbreviations.
\newcommand*\listofabbrevs{%
    % Work around limitation in glossaries in setting page heading.
    % See <http://tex.stackexchange.com/a/34291/42>, in particular:
    % “If more than one \markboth happens on the same page, then Latex takes the
    % last left mark and the first right mark.”
    \markboth{list of abbreviations}{list of abbreviations}%
    \printglossary[title={List of abbreviations},type=\acronymtype,nonumberlist]%
    \markboth{list of abbreviations}{list of abbreviations}}

\newcommand\define[2][]{\emph{\hashtag{#2}}\showdefinition{#1}}
\newcommand*\defineword[1]{\textbf{#1}\quad}
\newcommand\showdefinition[1]{%
    \ifstrequal{#1}{}{}{{\marginpar{\RaggedRight\footnotesize\itshape #1}}}}

% From <http://tex.stackexchange.com/a/74469/42>
\newcommand*\reducedstrut{%
    \vrule width 0pt height .9\ht\strutbox depth .9\dp\strutbox\relax}

\newcommand*\texttitle[1]{\textit{“#1”}}

\newcommand*\name[1]{\textsf{#1}}

\newcommand*\identifier[1]{\texttt{#1}}

\newcommand*\dfn[1]{\emph{#1}}

\newcommand*\gene@hsa[1]{\textsc{\MakeTextLowercase{\textit{#1}}}}
\newcommand*\gene@mmu[1]{\textit{#1}}
\newcommand*\gene[2]{\csuse{gene@#1}{#2}}

\newcommand*\protein@hsa[1]{\textrm{\textsc{\MakeTextLowercase{#1}}}}
\newcommand*\protein@mmu[1]{\textrm{\textsc{\MakeTextLowercase{#1}}}}
\newcommand*\protein[2]{\csuse{protein@#1}{#2}}

% Formatting of biological sequences

\newcommand*\seq[1]{\mbox{\texttt{#1}}}

\newcommand*\codon[1]{\seq{#1}}

\newcommand*\anticodon[1]{\ensuremath{\overline{\text{\MakeTextLowercase{%
    \seq{#1}}}}}}

\newcommand*\fwdstrand[1]{\fivep-#1-\threep}
\newcommand*\revstrand[1]{\threep-#1-\fivep}

\newcommand*\mismatch[1]{%
    % Fix for spacing from <http://tex.stackexchange.com/a/74469/42>
    \begingroup
    \setlength\fboxsep{0pt}%
    \colorbox{primary}{\reducedstrut#1\/}%
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

\makeglossaries
\input{abbreviations.tex}
\glsaddall[types=\acronymtype]

% Organisation

\newcommand*\chapterfile[1]{\input{#1.tex}}

\newcommand*\parrule[1][\ding{118}]{%
    \vspace{\baselineskip}
    \noindent\hfill{#1}\hfill
    \vspace{\baselineskip}%
    \@afterindentfalse%
    \@afterheading}

% Titles

\newcommand*\second[1]{#1}

% Fixes

% Pandoc output produces `\endhead` in longtables, which we don’t use.
\let\endhead\relax

% vim:ft=tex
\endinput
