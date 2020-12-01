(* ::Package:: *)

(*
This file is for internal handling and is used to create
pdf printouts of the main code notebook ComplexFocus.nb 

It can be run directly from the terminal with the command
   MathKernel -script PDFexporter.m
or it can be run directly from Mathematica.
*)


directory=Quiet[Check[NotebookDirectory[],DirectoryName[$InputFileName]],{FrontEndObject::notavail}];


Export[
FileNameJoin[{directory,"ComplexFocus.pdf"}],
Import[FileNameJoin[{directory,"ComplexFocus.nb"}]]/.{Closed->Open}
];
