\name{NEWS}
\title{spaMM News}
\encoding{UTF-8}
% cf ?news for the format and usage of this file
%
\section{CHANGES IN VERSION 1.5.1}{
\subsection{USER-LEVEL CHANGES}{
\itemize{
\item New example_maxtime package option for controlling execution of examples.
}
}
\subsection{TESTS}{
\itemize{
\item Tests are now controlled by a local environment variable _LOCAL_TESTS_ so that they are not run on CRAN.
}
}
}
%
\section{CHANGES IN VERSION 1.5.0}{
\subsection{NEW FEATURES}{\itemize{
\item Faster code for (some) sparse models with a single random effect on large data sets. It is also possible (by using \code{spaMM.options(QRmethod=Matrix::qr)}) to use sparse matrix algorithhms in other models, but this will be slow in many applications.
Various other changes were made to speed up computation in dense models (by about 10\% in the tests).

\item The non-Euclidean distance functions implemented in the \code{proxy} package (e.g. Geodesic) can now be used (although only Geodesic was tested, and the Matern correlation function with arbitrary rho and nu is not mathematically feasible for all distance functions). See \code{control.dist} argument of \code{HLCor} and \code{corrHLfit}.
}}
\subsection{USER-LEVEL CHANGES}{\itemize{
\item Reorganized graphic functions, with new \code{spaMMplot2D} function and new \code{envir} argument for \code{mapMM.HLfit}.
\item \code{predict.HLfit} modified for better consistency with other widely used predict methods: added \code{newdata} argument and modified default behaviour of \code{binding} argument. 
\item New \code{getDistMat} extractor for extracting the distance matrix used in the Matérn model 
\item This NEWS.Rd file is created
}}
\subsection{BUG FIXES}{\itemize{
\item Correction of a bug that caused incorrect prediction on new data for 1D (only) spatial model. 
}}
}