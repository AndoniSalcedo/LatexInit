#!/bin/bash

#Default parameters
title="/*Nombre*/"
subject="/*Asignatura*/"
date="/*Date*/"
author="/*Author*/"

manual=0
index="Y"
bibliografia="Y"

while [[ $# -gt 0 ]] 
do
  case "$1" in
    -m | --manual )
        manual=1
        shift;
        exit;
        ;;
    -t | --title)
        title=$2
        shift 2
        ;;
    -s | --subject)
        subject=$2
        shift 2
        ;;
    -d | --date)
        date = $2
        shift 2
        ;;
    -a | --author)
        author=$2
        shift 2
        ;;
    *) 
        shift; 
        echo  "Usage: $(basename $0) [-t titulo] [-s asignatura] [-d fecha] "
        exit 1
        ;;
  esac
done

if [ $manual -eq 0 ]
then
    echo -n "Titulo: "
    read title
    echo -n "Asignatura: "
    read subject
    echo -n "Fecha: "
    read date
    echo -n "Author: "
    read author
    echo -n "Añadir indice [Y/n]: "
    read index
    echo -n "Añadir bibliografía [Y/n]: "
    read bibliografia
fi

if [[ $index != "n" ]]
then
tableofcontents="
\thispagestyle{empty}

\vspace*{\fill}

\hspace*{\fill}
\textit{This page is intentionally blank}
\hspace*{\fill}
\vspace*{\fill}
\pagebreak
\tableofcontents
\pagebreak
\thispagestyle{empty}
\vspace*{\fill}
\hspace*{\fill}
\textit{This page is intentionally blank}
\hspace*{\fill}
\vspace*{\fill}
\pagebreak"
fi

if [[ $bibliografia != "n" ]]
then
bibliografyHeader="
\usepackage[backend=biber,style=numeric,sorting=none]{biblatex}
\addbibresource{bibliography.bib}"
bibliography="\printbibliography"
fi

mkdir memoria

cd memoria

mkdir tex
mkdir images

cd tex

echo "
*.*
!*.pdf
!*.tex
!*.bib
!*.gitignore
" > .gitignore

echo "
@misc{h264,
  title        = {title},
  year         = {year},
  howpublished = {\url{https://es.wikipedia.org}}
}
" > bibliography.bib

echo "
\documentclass{article}
\usepackage[utf8]{inputenc}
\usepackage{graphicx}
\usepackage{float}
\usepackage{adjustbox}
\usepackage[compact]{titlesec}       
\usepackage{geometry}
\usepackage{listings}
\usepackage{multicol}
\usepackage{color}
\usepackage{subcaption}
\usepackage{hyperref}
 
\geometry{
    a4paper,
    total={170mm,257mm},
    left=40mm,
    right=40mm,
    top=30mm,
    bottom=40mm,
}
\setlength{\parindent}{2em}
\setlength{\parskip}{1em}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}
\setlength\abovedisplayskip{0pt}
\setlength\belowdisplayskip{0pt}

\lstdefinestyle{customc}{
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    frame=L,
    language=C,
    showstringspaces=false,
    basicstyle=\footnotesize\ttfamily,
    keywordstyle=\bfseries\color{green!40!black},
    commentstyle=\itshape\color{purple!40!black},
    identifierstyle=\color{black},
    stringstyle=\color{orange},
}
\lstset{escapechar=@,style=customc}

"$bibliografyHeader"

\title{" $title "}

\author{" $subject "\\\\\\\\
" $author " }

\date{" $date "}

\begin{document}

\maketitle
\pagebreak

"$tableofcontents"
"$bibliography"
\end{document}" > memoria.tex
