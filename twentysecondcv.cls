\ProvidesClass{twentysecondcv}[2017/01/08 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{fontspec}
\setsansfont{Latin Modern Sans}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage{fontawesome}
\RequirePackage{xurl}
\RequirePackage{longtable}
\RequirePackage{enumitem}
\usepackage{etoolbox}
\AtBeginEnvironment{itemize}{\sloppy}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------


\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation
\hfuzz=0.5pt % Ignore negligible overfull hbox warnings

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.8pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\github}[1]{\renewcommand{\github}{#1}}
\newcommand{\linkedin}[1]{\renewcommand{\linkedin}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars
\newcommand\skills[1]{
	\renewcommand{\skills}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
					\draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
					\draw[fill=white,mainblue](0,\i) rectangle (\y,\i+0.4);
					\node [above right] at (0,\i+0.4) {\x};
				}
		\end{tikzpicture}
	}
}

% Command for printing skills text
\newcommand\skillstext[1]{
	\renewcommand{\skillstext}{
		\begin{flushleft}
			\foreach [count=\i] \x/\y in {#1}{
					\x$ \star $\y
				}
		\end{flushleft}
	}
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{
	\begin{tikzpicture}[remember picture,overlay]
		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}

	%------------------------------------------------

	\begin{textblock}{6}(0.5, 0.2)

		%------------------------------------------------

		\ifthenelse{\equal{\profilepic}{}}{}{
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
					\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
				\end{tikzpicture}
			\end{center}
		}

		%------------------------------------------------

		{\Huge\color{mainblue}\cvname}

		%------------------------------------------------

		{\Large\color{black!80}\cvjobtitle}

		%------------------------------------------------

		\renewcommand{\arraystretch}{1.6}
		\setlength{\tabcolsep}{0pt}
		\begin{tabular}{@{}p{0.75cm}@{\hskip 0.35cm}p{\dimexpr\linewidth-1.12cm\relax}@{}}
			\ifthenelse{\equal{\cvdate}{}}{}{{\Large\icon{\Info}}           & \cvdate\\}
			\ifthenelse{\equal{\cvaddress}{}}{}{{\Large\icon{\Letter}}      & \cvaddress\\}
			\ifthenelse{\equal{\cvnumberphone}{}}{}{{\Large\icon{\Telefon}} & \cvnumberphone\\}
			\ifthenelse{\equal{\cvmail}{}}{}{{\large\icon{@}}               & \href{mailto:\cvmail}{\nolinkurl{\cvmail}}\\}
			\ifthenelse{\equal{\github}{}}{}{{\large\icon{\faGithub}}       & \href{https://\github}{\nolinkurl{\github}}\\}
			\ifthenelse{\equal{\linkedin}{}}{}{{\large\icon{\faLinkedin}}   & \href{https://\linkedin}{\nolinkurl{\linkedin}}\\}
		\end{tabular}

		%------------------------------------------------

		\ifthenelse{\equal{\aboutme}{}}{}{
			\profilesection{About me}
			\begin{flushleft}
				\aboutme
			\end{flushleft}
		}

		%------------------------------------------------

		\profilesection{Skills}

		\skills
		\skillstext
		\scriptsize
		% (*)[The skill scale is from 0 (Fundamental Awareness) to 6 (Expert).]

		%------------------------------------------------

	\end{textblock}
}

%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
	\tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle, rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=#2,#2,text=white](char){#1};%
}

\newcounter{colorCounter}
\newcommand{\sectioncolor}[1]{%
	{%
			\round{#1}{
				\ifcase\value{colorCounter}%
					maingray\or%
					mainblue\or%
					maingray\or%
					mainblue\or%
					maingray\or%
					mainblue\or%
					maingray\or%
					mainblue\or%
					maingray\or%
					mainblue\else%
					maingray\fi%
			}%
		}%
	\stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
	{%
			\color{gray}%
			\Large\sectioncolor{#1}%
		}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\large\color{gray} #1%
	}
	\par\vspace{.25\parskip}%
}

%----------------------------------------------------------------------------------------
%	 LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{twenty}{%
	\begin{longtable}{@{} p{1.7cm} @{\hskip 0.2cm} l @{}}
		}{%
	\end{longtable}
}

\newcommand{\twentyitem}[4]{%
	#1:&\parbox[t]{\dimexpr\textwidth-2.3cm\relax}{%
		\RaggedRight
		\textbf{#2}
		\ifstrempty{#3}{}{%
			{\color{black}\footnotesize\itshape\enspace--\enspace#3}%
		}\\%
		#4\vspace{\parsep}%
	}\\
}

\setlist[itemize]{rightmargin=0.2cm, leftmargin=*}

\newcommand{\twentyentry}[4]{%
	\noindent
	\begin{minipage}[t]{1.7cm}
		\vspace{0pt}
		\RaggedRight #1:
	\end{minipage}%
	\hspace{0.2cm}
	\begin{minipage}[t]{\dimexpr\textwidth- 2cm\relax}
		\RaggedRight
		{\color{black}\bfseries #2}
		\ifstrempty{#3}{}{%
			{\color{black!70}\footnotesize\itshape\enspace--\enspace#3}%
		}
	\end{minipage}

	\nopagebreak \vspace{0.2em}

	% Use a simple quote-like indentation that is breakable
	\begin{itemize}[label={}, leftmargin=2cm, rightmargin=0.5cm, nosep, after=\vspace{0.4em}]
		\item \sloppy #4
	\end{itemize}
	\par
}

%----------------------------------------------------------------------------------------
%	 SMALL LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{twentyshort}{%
	\begin{tabular}{@{}ll@{}}
		}{%
	\end{tabular}
}

\newcommand{\twentyitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\RaggedRight
		\textbf{#2}%
	}\\
}

%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\RequirePackage{hyperref}
