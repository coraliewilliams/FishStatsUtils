% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Vessel_Fn.R
\name{Vessel_Fn}
\alias{Vessel_Fn}
\title{Plot vessel effects}
\usage{
Vessel_Fn(TmbData, Sdreport, FileName_VYplot = NULL)
}
\arguments{
\item{TmbData}{Formatted data inputs, from `VAST::Data_Fn(...)`}

\item{Sdreport}{TMB output from `TMB::sdreport(Obj)`}

\item{FileName_VYplot}{Full filename (including directory) for center-of-gravity plot}
}
\value{
Return Tagged list of output
}
\description{
\code{Vessel_Fn} plots estimated vessel effects for model components
}
