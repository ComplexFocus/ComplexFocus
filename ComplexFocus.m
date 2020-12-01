(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
(*
This is the ComplexFocus package, \[Copyright] Rodrigo Guti\[EAcute]rrez-Cuevas& Emilio Pisanty (2020). For the notebook that generated this package file and additional documentaion, see https://github.com/ComplexFocus/ComplexFocus.
*)


(* ::Input::Initialization:: *)
BeginPackage["ComplexFocus`"];


(* ::Input::Initialization:: *)
$ComplexFocusVersion::usage="$ComplexFocusVersion prints the current version of the ComplexFocus package in use and its timestamp.";
$ComplexFocusTimestamp::usage="$ComplexFocusTimestamp prints the timestamp of the current version of the ComplexFocus package.";


(* ::Input::Initialization:: *)
Begin["`Private`"];
$ComplexFocusVersion:="ComplexFocus v1.0, "<>$ComplexFocusTimestamp;


(* ::Input::Initialization:: *)
$ComplexFocusTimestamp="Tue 1 Dec 2020 22:39:54";
End[];


(* ::Input::Initialization:: *)
$ComplexFocusDirectory::usage="$ComplexFocusDirectory is the directory where the current ComplexFocus package instance is located.";


(* ::Input::Initialization:: *)
Begin["`Private`"];
With[{softLinkTestString=StringSplit[StringJoin[ReadList["! ls -la "<>StringReplace[$InputFileName,{" "->"\\ "}],String]]," -> "]},
If[Length[softLinkTestString]>1,(*Testing in case $InputFileName is a soft link to the actual directory.*)
$ComplexFocusDirectory=StringReplace[DirectoryName[softLinkTestString[[2]]],{" "->"\\ "}],
$ComplexFocusDirectory=StringReplace[DirectoryName[$InputFileName],{" "->"\\ "}];
]];
End[];


(* ::Input::Initialization:: *)
$ComplexFocusCommit::usage="$ComplexFocusCommit returns the git commit log at the location of the ComplexFocus package if there is one.";
$ComplexFocusCommit::OS="$ComplexFocusCommit has only been tested on Linux.";


(* ::Input::Initialization:: *)
Begin["`Private`"];
$ComplexFocusCommit:=(If[$OperatingSystem!="Unix",Message[$ComplexFocusCommit::OS]];
StringJoin[Riffle[ReadList["!cd "<>$ComplexFocusDirectory<>" && git log -1",String],{"\n"}]]);
End[];


(* ::Input::Initialization:: *)
SolidHarmonicS::usage="SolidHarmonicS[l,m,x,y,z] calculates the solid harmonic \!\(\*SubscriptBox[\(S\), \(lm\)]\)(x,y,z)=\!\(\*SuperscriptBox[\(r\), \(l\)]\)\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(x,y,z).

SolidHarmonicS[l,m,{x,y,z}] does the same.";
Begin["`Private`"];
SolidHarmonicS[\[Lambda]_Integer,\[Mu]_Integer,x_,y_,z_]/;\[Lambda]>=Abs[\[Mu]]:=Sqrt[(2 \[Lambda]+1)/(4 \[Pi])] Sqrt[Gamma[\[Lambda]-Abs[\[Mu]]+1]/Gamma[\[Lambda]+Abs[\[Mu]]+1]] 2^-\[Lambda] (-1)^((\[Mu]-Abs[\[Mu]])/2)*
If[Rationalize[\[Mu]]==0,1,(x+Sign[\[Mu]]I y)^Abs[\[Mu]]]*
Sum[
(-1)^(\[Mu]+k) Binomial[\[Lambda],k] Binomial[2 \[Lambda]-2 k,\[Lambda]] Pochhammer[\[Lambda]-Abs[\[Mu]]-2 k+1,Abs[\[Mu]]] *
If[TrueQ[Pochhammer[\[Lambda]-Abs[\[Mu]]-2 k+1,Abs[\[Mu]]]==0],1,
If[Rationalize[k]==0,1,(x^2+y^2+z^2)^k]If[Rationalize[\[Lambda]-Abs[\[Mu]]-2 k]==0,1,z^(\[Lambda]-Abs[\[Mu]]-2 k)]
]
,{k,0,Quotient[\[Lambda],2]}]
SolidHarmonicS[\[Lambda]_Integer,\[Mu]_Integer,{x_,y_,z_}]/;\[Lambda]>=Abs[\[Mu]]:=SolidHarmonicS[\[Lambda],\[Mu],x,y,z]
End[];


(* ::Input::Initialization:: *)
AnalyticalBesselJ::usage="AnalyticalBesselJ[m,{x,y,z}] gives the analytical form of the spherical Bessel function, \!\(\*SubscriptBox[\(aj\), \(m\)]\)(r)=\!\(\*SubscriptBox[\(j\), \(m\)]\)(r)/\!\(\*SuperscriptBox[\(r\), \(m\)]\).";

Begin["`Private`"];
AnalyticalBesselJ[m_,{x_?NumericQ,y_?NumericQ,z_?NumericQ}]:=SphericalBesselJ[Abs[m],Sqrt[x^2+y^2+z^2]]/(x^2+y^2+z^2)^(Abs[m]/2)
AnalyticalBesselJ[m_,{x_?NumericQ,y_?NumericQ,z_?NumericQ}/;(x^2+y^2+z^2==0||x^2+y^2+z^2==0.)]:=1/(2m+1)!!

Derivative[0,{1,0,0}][AnalyticalBesselJ][m_,{x_,y_,z_}]:=(-1)x AnalyticalBesselJ[m+1,{x,y,z}]
Derivative[0,{0,1,0}][AnalyticalBesselJ][m_,{x_,y_,z_}]:=(-1)y AnalyticalBesselJ[m+1,{x,y,z}]
Derivative[0,{0,0,1}][AnalyticalBesselJ][m_,{x_,y_,z_}]:=(-1)z AnalyticalBesselJ[m+1,{x,y,z}]

End[];


(* ::Input::Initialization:: *)
Multipole\[CapitalLambda]::usage="Multipole\[CapitalLambda][l,m,{x,y,z}] calculates the multipole function \!\(\*SubscriptBox[\(\[CapitalLambda]\), \(l, m\)]\)(x,y,z)=4\!\(\*SuperscriptBox[\(\[Pi]i\), \(l\)]\)\!\(\*SubscriptBox[\(j\), \(l\)]\)(r)\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(\[Theta],\[Phi])=4\!\(\*SuperscriptBox[\(\[Pi]i\), \(l\)]\)\!\(\*SubscriptBox[\(aj\), \(l\)]\)(r)\!\(\*SubscriptBox[\(S\), \(lm\)]\)(x,y,z).";

Begin["`Private`"];

Multipole\[CapitalLambda][l_,m_,{x_,y_,z_}]:=4\[Pi] I^l AnalyticalBesselJ[l,{x,y,z}]SolidHarmonicS[l,m,x,y,z]

End[];


(* ::Input::Initialization:: *)
UnitE::usage="UnitE[s] gives the unit vectors \!\(\*SubscriptBox[\(e\), \(s\)]\) for s=-1,0,1, equal to (1,-i,0)/\!\(\*SqrtBox[\(2\)]\), (0,0,1) and (1,i,0)/\!\(\*SqrtBox[\(2\)]\), respectively.";UnitU::usage="UnitU[\[Theta],\[Phi]] gives the radial unit vector (sin(\[Theta])cos(\[Phi]),sin(\[Theta])sin(\[Phi]),cos(\[Theta])) at spherical polar coordinates (\[Theta],\[Phi]).";
Unit\[Theta]::usage="Unit\[Theta][\[Theta],\[Phi]] gives the polar unit vector (cos(\[Theta])cos(\[Phi]),cos(\[Theta])sin(\[Phi]),-sin(\[Theta])) at spherical polar coordinates (\[Theta],\[Phi]).";
Unit\[Phi]::usage="Unit\[Phi][\[Theta],\[Phi]] gives the azimuthal unit vector (-sin(\[Phi]),cos(\[Phi]),0) at spherical polar coordinates (\[Theta],\[Phi]).";


Begin["`Private`"];
UnitE[s:(1|-1)]:=1/Sqrt[2] {1,s I,0}
UnitE[0]:={0,0,1}


UnitU[\[Theta]_,\[Phi]_]:={Cos[\[Phi]]Sin[\[Theta]],Sin[\[Phi]]Sin[\[Theta]],Cos[\[Theta]]}

Unit\[Theta][\[Theta]_,\[Phi]_]:={Cos[\[Phi]]Cos[\[Theta]],Sin[\[Phi]]Cos[\[Theta]],-Sin[\[Theta]]}
Unit\[Phi][\[Theta]_,\[Phi]_]:={-Sin[\[Phi]],Cos[\[Phi]],0}

End[];


(* ::Input::Initialization:: *)
PolarizationVElectric::usage="PolarizationVElectric[v,f[x,y,z],{x,y,z}] gives the electric-type polarization operator \!\(\*SubsuperscriptBox[\(V\), \(v\), \((E)\)]\)f=-\[Del]\[Times](\[Del]\[Times](v f)) for a vector v and a scalar function f.
PolarizationVElectric[v,f] gives the functional form of \!\(\*SubsuperscriptBox[\(V\), \(v\), \((E)\)]\)f. The vector v can be a fixed object or an explicit Function object.";
PolarizationVMagnetic::usage="PolarizationVMagnetic[v,f[x,y,z],{x,y,z}] gives the magnetic-type polarization operator \!\(\*SubsuperscriptBox[\(V\), \(v\), \((M)\)]\)f=-i\[Del]\[Times](v f) for a vector v and a scalar function f.
PolarizationVMagnetic[v,f] gives the functional form of \!\(\*SubsuperscriptBox[\(V\), \(v\), \((M)\)]\)f. The vector v can be a fixed object or an explicit Function object.";
PolarizationVHelicity::usage="PolarizationVHelicity[\[Sigma],f[x,y,z],{x,y,z}] gives the helicity-type polarization operator \!\(\*SuperscriptBox[\(V\), \((\[PlusMinus])\)]\)f=\!\(\*SubsuperscriptBox[\(V\), SubscriptBox[\(e\), \(\[PlusMinus]\)], \((E)\)]\)f\[PlusMinus]\!\(\*SubsuperscriptBox[\(iV\), SubscriptBox[\(e\), \(\[PlusMinus]\)], \((M)\)]\)f for a helicity \[Sigma]=\[PlusMinus]1 and a scalar function f.
PolarizationVHelicity[\[Sigma],f] gives the functional form of \!\(\*SuperscriptBox[\(V\), \((\[PlusMinus])\)]\)f.";

Begin["`Private`"];

PolarizationVElectric[vector_,scalarFunction_,variables_]:=-Curl[Curl[Times[vector,scalarFunction],variables],variables]
PolarizationVMagnetic[vector_,scalarFunction_,variables_]:=-I Curl[Times[vector,scalarFunction],variables]
PolarizationVHelicity[s:(1|-1),scalarFunction_,variables_]:=PolarizationVElectric[UnitE[s],scalarFunction,variables]-I s PolarizationVMagnetic[UnitE[s],scalarFunction,variables]

PolarizationVElectric[vector_,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVElectric[vector,scalarFunction[x,y,z],{x,y,z}]
]]
]
PolarizationVElectric[vector_Function,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVElectric[vector[x,y,z],scalarFunction[x,y,z],{x,y,z}]
]]
]

PolarizationVMagnetic[vector_,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVMagnetic[vector,scalarFunction[x,y,z],{x,y,z}]
]]
]
PolarizationVMagnetic[vector_Function,scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVMagnetic[vector[x,y,z],scalarFunction[x,y,z],{x,y,z}]
]]
]

PolarizationVHelicity[s:(1|-1),scalarFunction_]:=Block[{x,y,z},
Function[{x,y,z},Evaluate[
PolarizationVElectric[UnitE[s],scalarFunction[x,y,z],{x,y,z}]+I s PolarizationVMagnetic[UnitE[s],scalarFunction[x,y,z],{x,y,z}]
]]
]

End[];


(* ::Input::Initialization:: *)
Polarization\[ScriptCapitalV]Electric::usage="Polarization\[ScriptCapitalV]Electric[v,u] gives the electric-type polarization vector \!\(\*SubsuperscriptBox[\(\[ScriptCapitalV]\), \(v\), \((E)\)]\)= u\[Cross](u\[Cross]v) in Fourier space, in terms of the unit direction vector u={ux,uy,uz}.
Polarization\[ScriptCapitalV]Electric[v,\[Theta],\[Phi]] gives the electric-type polarization vector \!\(\*SubsuperscriptBox[\(\[ScriptCapitalV]\), \(v\), \((E)\)]\)= u\[Cross](u\[Cross]v) in Fourier space, in terms of the polar coordinates (\[Theta],\[Phi]) of the unit direction vector u.";

Polarization\[ScriptCapitalV]Magnetic::usage="Polarization\[ScriptCapitalV]Magnetic[v,u] gives the electric-type polarization vector \!\(\*SubsuperscriptBox[\(\[ScriptCapitalV]\), \(v\), \((E)\)]\)= u\[Cross]v in Fourier space, in terms of the unit direction vector u={ux,uy,uz}.
Polarization\[ScriptCapitalV]Magnetic[v,\[Theta],\[Phi]] gives the electric-type polarization vector \!\(\*SubsuperscriptBox[\(\[ScriptCapitalV]\), \(v\), \((E)\)]\)= u\[Cross]v in Fourier space, in terms of the polar coordinates (\[Theta],\[Phi]) of the unit direction vector u.";

Polarization\[ScriptCapitalV]Helicity::usage="Polarization\[ScriptCapitalV]Helicity[v,u] gives the electric-type polarization vector \!\(\*SubsuperscriptBox[\(\[ScriptCapitalV]\), \(v\), \((E)\)]\)= u\[Cross]v in Fourier space, in terms of the unit direction vector u={ux,uy,uz}.
Polarization\[ScriptCapitalV]Helicity[v,\[Theta],\[Phi]] gives the electric-type polarization vector \!\(\*SubsuperscriptBox[\(\[ScriptCapitalV]\), \(v\), \((E)\)]\)= u\[Cross]v in Fourier space, in terms of the polar coordinates (\[Theta],\[Phi]) of the unit direction vector u.";

Begin["`Private`"];

Polarization\[ScriptCapitalV]Electric[v_List,u_List]:=Cross[u,Cross[u,v]]
Polarization\[ScriptCapitalV]Electric[v_List,\[Theta]_,\[Phi]_]:=Cross[UnitU[\[Theta],\[Phi]],Cross[UnitU[\[Theta],\[Phi]],v]]

Polarization\[ScriptCapitalV]Magnetic[v_List,u_List]:=Cross[u,v]
Polarization\[ScriptCapitalV]Magnetic[v_List,\[Theta]_,\[Phi]_]:=Cross[UnitU[\[Theta],\[Phi]],v]

Polarization\[ScriptCapitalV]Helicity[s:(1|-1),u_List]:=Polarization\[ScriptCapitalV]Electric[UnitE[s],u]-I s Polarization\[ScriptCapitalV]Magnetic[UnitE[s],u]
Polarization\[ScriptCapitalV]Helicity[s:(1|-1),\[Theta]_,\[Phi]_]:=Polarization\[ScriptCapitalV]Electric[UnitE[s],UnitU[\[Theta],\[Phi]]]-I s Polarization\[ScriptCapitalV]Magnetic[UnitE[s],UnitU[\[Theta],\[Phi]]]

End[];


(* ::Input::Initialization:: *)
CFnormTEM::usage="CFnormTEM[l,m,q] returns the normalization integral \[Integral]|\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(\[Theta],\[Phi])\!\(\*SuperscriptBox[\(|\), \(2\)]\)\!\(\*SuperscriptBox[\(e\), \(2  q\\\ cos \((\[Theta])\)\)]\)sin(\[Theta]\!\(\*SuperscriptBox[\()\), \(2\)]\)d\[CapitalOmega] for the TEM complex-focus fields.";

\[Alpha]TEM::usage="\[Alpha]TEM[l,m,q] returns the normalization constant CFnormTEM[l,m,q\!\(\*SuperscriptBox[\(]\), \(\(-1\)/2\)]\) for the TEM complex-focus fields.";

Begin["`Private`"];
\[Alpha]TEM[l_,m_,q_]:=CFnormTEM[l,m,q]^(-1/2)
\[Alpha]TEM[l_,m_,0]:=\[Alpha]TEM[l,m,0]=CFnormTEM[l,m,0]^(-1/2)

CFnormTEM[l_,m_,q_]:=Block[{qInt},
CFnormTEM[l,m,qInt_]=Simplify[Integrate[SphericalHarmonicY[l,m,\[Theta],\[Phi]]SphericalHarmonicY[l,-m,\[Theta],\[Phi]]Exp[2qInt Cos[\[Theta]]](Sin[\[Theta]])^2 Sin[\[Theta]],{\[Theta],0,\[Pi]},{\[Phi],0,2\[Pi]}]];
CFnormTEM[l,m,q]
]
CFnormTEM[l_,m_,0]:=CFnormTEM[l,m,0]=Limit[CFnormTEM[l,m,q],q->0]
End[];


(* ::Input::Initialization:: *)
(*This cell is auto-generated. Any changes will be over-ridden if the cell above is evaluated.*)
Begin["`Private`"];
CFnormTEM[0,0,q_]:=(2*q*Cosh[2*q] - Sinh[2*q])/(4*q^3)
CFnormTEM[1,-1,q_]:=(18*q*Cosh[2*q] - 3*(3 + 4*q^2)*Sinh[2*q])/(8*q^5)
CFnormTEM[1,0,q_]:=(6*q*(3 + q^2)*Cosh[2*q] - 3*(3 + 5*q^2)*Sinh[2*q])/(4*q^5)
CFnormTEM[1,1,q_]:=(18*q*Cosh[2*q] - 3*(3 + 4*q^2)*Sinh[2*q])/(8*q^5)
CFnormTEM[2,-2,q_]:=(45*(2*q*(15 + 4*q^2)*Cosh[2*q] - 3*(5 + 8*q^2)*Sinh[2*q]))/(64*q^7)
CFnormTEM[2,-1,q_]:=(15*(18*q*(5 + 2*q^2)*Cosh[2*q] - (45 + 78*q^2 + 8*q^4)*Sinh[2*q]))/(16*q^7)
CFnormTEM[2,0,q_]:=(5*(2*q*(405 + 180*q^2 + 8*q^4)*Cosh[2*q] - (405 + 720*q^2 + 104*q^4)*Sinh[2*q]))/(32*q^7)
CFnormTEM[2,1,q_]:=(15*(18*q*(5 + 2*q^2)*Cosh[2*q] - (45 + 78*q^2 + 8*q^4)*Sinh[2*q]))/(16*q^7)
CFnormTEM[2,2,q_]:=(45*(2*q*(15 + 4*q^2)*Cosh[2*q] - 3*(5 + 8*q^2)*Sinh[2*q]))/(64*q^7)
CFnormTEM[3,-3,q_]:=(105*(10*q*(21 + 8*q^2)*Cosh[2*q] - (105 + 180*q^2 + 16*q^4)*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,-2,q_]:=(315*(2*q*(210 + 95*q^2 + 4*q^4)*Cosh[2*q] - (210 + 375*q^2 + 56*q^4)*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,-1,q_]:=(21*(6*q*(2625 + 1300*q^2 + 96*q^4)*Cosh[2*q] - (7875 + 64*q^2*(225 + 42*q^2 + q^4))*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,0,q_]:=(7*(2*q*(15750 + 8025*q^2 + 684*q^4 + 8*q^6)*Cosh[2*q] - (15750 + 29025*q^2 + 5784*q^4 + 200*q^6)*Sinh[2*q]))/(32*q^9)
CFnormTEM[3,1,q_]:=(21*(6*q*(2625 + 1300*q^2 + 96*q^4)*Cosh[2*q] - (7875 + 64*q^2*(225 + 42*q^2 + q^4))*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,2,q_]:=(315*(2*q*(210 + 95*q^2 + 4*q^4)*Cosh[2*q] - (210 + 375*q^2 + 56*q^4)*Sinh[2*q]))/(64*q^9)
CFnormTEM[3,3,q_]:=(105*(10*q*(21 + 8*q^2)*Cosh[2*q] - (105 + 180*q^2 + 16*q^4)*Sinh[2*q]))/(64*q^9)
End[];


(* ::Input::Initialization:: *)
CFnormQuasiCircular::usage="CFnormQuasiCircular[l,m,q] returns the normalization integral \[Integral]|\!\(\*SubscriptBox[\(Y\), \(lm\)]\)(\[Theta],\[Phi])\!\(\*SuperscriptBox[\(|\), \(2\)]\)\!\(\*SuperscriptBox[\(e\), \(2  q\\\ cos \((\[Theta])\)\)]\)(1+cos(\[Theta])\!\(\*SuperscriptBox[\()\), \(2\)]\)d\[CapitalOmega] for the quasi-circular complex-focus fields.";

\[Alpha]QC::usage="\[Alpha]QC[l,m,q] returns the normalization constant CFnormQuasiCircular[l,m,q\!\(\*SuperscriptBox[\(]\), \(\(-1\)/2\)]\) for the quasi-circular complex-focus fields.";

Begin["`Private`"];
\[Alpha]QC[l_,m_,q_]:=CFnormQuasiCircular[l,m,q]^(-1/2)
\[Alpha]QC[l_,m_,0]:=\[Alpha]QC[l,m,0]=CFnormQuasiCircular[l,m,0]^(-1/2)

CFnormQuasiCircular[l_,m_,q_]:=Block[{qInt},
CFnormQuasiCircular[l,m,qInt_]=Simplify[Integrate[SphericalHarmonicY[l,m,\[Theta],\[Phi]]SphericalHarmonicY[l,-m,\[Theta],\[Phi]]Exp[2qIntCos[\[Theta]]](1+Cos[\[Theta]])^2 Sin[\[Theta]],{\[Theta],0,\[Pi]},{\[Phi],0,2\[Pi]}]];
CFnormQuasiCircular[l,m,q]
]
CFnormQuasiCircular[l_,m_,0]:=CFnormQuasiCircular[l,m,0]=Limit[CFnormQuasiCircular[l,m,q],q->0]
End[];


(* ::Input::Initialization:: *)
(*This cell is auto-generated. Any changes will be over-ridden if the cell above is evaluated.*)
Begin["`Private`"];
CFnormQuasiCircular[0,0,q_]:=(-1 + E^(4*q)*(1 - 4*q + 8*q^2))/(8*E^(2*q)*q^3)
CFnormQuasiCircular[1,-1,q_]:=(-3*(3*(1 + q) + E^(4*q)*(-3 + 9*q - 12*q^2 + 8*q^3)))/(16*E^(2*q)*q^5)
CFnormQuasiCircular[1,0,q_]:=(3*(-3 - 3*q - q^2 + E^(4*q)*(3 - 9*q + 13*q^2 - 12*q^3 + 8*q^4)))/(8*E^(2*q)*q^5)
CFnormQuasiCircular[1,1,q_]:=(-3*(3*(1 + q) + E^(4*q)*(-3 + 9*q - 12*q^2 + 8*q^3)))/(16*E^(2*q)*q^5)
CFnormQuasiCircular[2,-2,q_]:=(15*(-3*(15 + 20*q + 8*q^2) + E^(4*q)*(45 - 120*q + 144*q^2 - 96*q^3 + 32*q^4)))/(128*E^(2*q)*q^7)
CFnormQuasiCircular[2,-1,q_]:=(-15*(45 + 60*q + 30*q^2 + 6*q^3 + E^(4*q)*(-45 + 120*q - 150*q^2 + 114*q^3 - 56*q^4 + 16*q^5)))/(32*E^(2*q)*q^7)
CFnormQuasiCircular[2,0,q_]:=(5*(-405 - 4*q*(135 + 2*q*(36 + q*(9 + q))) + E^(4*q)*(405 + 8*q*(-135 + q*(171 + q*(-135 + q*(73 + 4*q*(-7 + 2*q))))))))/(64*E^(2*q)*q^7)
CFnormQuasiCircular[2,1,q_]:=(-15*(45 + 60*q + 30*q^2 + 6*q^3 + E^(4*q)*(-45 + 120*q - 150*q^2 + 114*q^3 - 56*q^4 + 16*q^5)))/(32*E^(2*q)*q^7)
CFnormQuasiCircular[2,2,q_]:=(15*(-3*(15 + 20*q + 8*q^2) + E^(4*q)*(45 - 120*q + 144*q^2 - 96*q^3 + 32*q^4)))/(128*E^(2*q)*q^7)
CFnormQuasiCircular[3,-3,q_]:=(-525*(42 + q*(63 + 4*q*(9 + 2*q))) - 105*E^(4*q)*(-210 + q*(525 + 8*q*(-75 + 2*q*(25 + 2*(-5 + q)*q)))))/(256*E^(2*q)*q^9)
CFnormQuasiCircular[3,-2,q_]:=(105*(-3*(210 + q*(315 + q*(195 + 60*q + 8*q^2))) + E^(4*q)*(630 + q*(-1575 + q*(1845 + 8*q*(-165 + 2*q*(39 + 2*(-6 + q)*q)))))))/(128*E^(2*q)*q^9)
CFnormQuasiCircular[3,-1,q_]:=(-63*(5250 + q*(7875 + 4*q*(1275 + 2*q*(225 + 4*q*(11 + q))))) - 21*E^(4*q)*(-15750 + q*(39375 + 16*q*(-2925 + q*(2175 + 4*q*(-279 + 2*q*(51 + q*(-13 + 2*q))))))))/(256*E^(2*q)*q^9)
CFnormQuasiCircular[3,0,q_]:=(-55125*(2 + 3*q) - 7*q^2*(15525 + 4*q*(1425 + 2*q*(153 + q*(18 + q)))) + 7*E^(4*q)*(15750 + q*(-39375 + q*(47025 + 8*q*(-4425 + q*(2328 + q*(-894 + q*(253 - 52*q + 8*q^2))))))))/(64*E^(2*q)*q^9)
CFnormQuasiCircular[3,1,q_]:=(-63*(5250 + q*(7875 + 4*q*(1275 + 2*q*(225 + 4*q*(11 + q))))) - 21*E^(4*q)*(-15750 + q*(39375 + 16*q*(-2925 + q*(2175 + 4*q*(-279 + 2*q*(51 + q*(-13 + 2*q))))))))/(256*E^(2*q)*q^9)
CFnormQuasiCircular[3,2,q_]:=(105*(-3*(210 + q*(315 + q*(195 + 60*q + 8*q^2))) + E^(4*q)*(630 + q*(-1575 + q*(1845 + 8*q*(-165 + 2*q*(39 + 2*(-6 + q)*q)))))))/(128*E^(2*q)*q^9)
CFnormQuasiCircular[3,3,q_]:=(-525*(42 + q*(63 + 4*q*(9 + 2*q))) - 105*E^(4*q)*(-210 + q*(525 + 8*q*(-75 + 2*q*(25 + 2*(-5 + q)*q)))))/(256*E^(2*q)*q^9)
End[];


(* ::Input::Initialization:: *)
ComplexFocusHelicityE::usage="ComplexFocusHelicityE[l,m,\[Sigma],{x,y,z},\[Zeta]] gives the complex-focus field of helicity type, with complex-focus parameter \[Zeta], angular momentum numbers l,m and helicity \[Sigma]=\[PlusMinus]1.";
ComplexFocusElectricE::usage="ComplexFocusElectricE[l,m,v,{x,y,z},\[Zeta]] gives the complex-focus field of electric type, with complex-focus parameter \[Zeta], angular momentum numbers l,m and seed polarization vector v.";
ComplexFocusMagneticE::usage="ComplexFocusMagneticE[l,m,v,{x,y,z},\[Zeta]] gives the complex-focus field of magnetic type, with complex-focus parameter \[Zeta], angular momentum numbers l,m and seed polarization vector v.";

Begin["`Private`"];
ComplexFocusHelicityE[l_,m_,s:(1|-1),{x_,y_,z_},\[Zeta]_]:=Block[{xInt,yInt,zInt,\[Zeta]Int},
ComplexFocusHelicityE[l,m,s,{xInt_,yInt_,zInt_},\[Zeta]Int_]=Simplify[PolarizationVHelicity[s,Multipole\[CapitalLambda][l,m,{xInt,yInt,zInt-I \[Zeta]Int}],{xInt,yInt,zInt}]];
ComplexFocusHelicityE[l,m,s,{x,y,z},\[Zeta]]
]
ComplexFocusElectricE[l_,m_,vector_,{x_,y_,z_},\[Zeta]_]:=Block[{xInt,yInt,zInt,\[Zeta]Int},
ComplexFocusElectricE[l,m,vector,{xInt_,yInt_,zInt_},\[Zeta]Int_]=Simplify[PolarizationVElectric[vector,Multipole\[CapitalLambda][l,m,{xInt,yInt,zInt-I \[Zeta]Int}],{xInt,yInt,zInt}]];
ComplexFocusElectricE[l,m,vector,{x,y,z},\[Zeta]]
]
ComplexFocusMagneticE[l_,m_,vector_,{x_,y_,z_},\[Zeta]_]:=Block[{xInt,yInt,zInt,\[Zeta]Int},
ComplexFocusMagneticE[l,m,vector,{xInt_,yInt_,zInt_},\[Zeta]Int_]=Simplify[PolarizationVMagnetic[vector,Multipole\[CapitalLambda][l,m,{xInt,yInt,zInt-I \[Zeta]Int}],{xInt,yInt,zInt}]];
ComplexFocusMagneticE[l,m,vector,{x,y,z},\[Zeta]]
]
End[];


(* ::Input::Initialization:: *)
JonesPhase::usage="JonesPhase[v] gives the Jones phase of the vector v, \!\(\*FractionBox[\(1\), \(2\)]\)arg(v\[CenterDot]v).";

Begin["`Private`"];

JonesPhase[vec_]:=Arg[Dot[vec,vec]]/2;

End[];


(* ::Input::Initialization:: *)
JonesMajorAxisA::usage="JonesMajorAxisA[v] gives the major-axis vector of the polarization ellipse marked by the complex vector v.
JonesMajorAxisA[v,normFunction] normalizes the ellipse by normFunction[v].";

Begin["`Private`"];

JonesMajorAxisA[vec_,normFunction_:(1&)]:=Block[{vecF},
vecF=vec Exp[-I JonesPhase[vec]];
Re[vecF]/normFunction[vecF]
]

End[];


(* ::Input::Initialization:: *)
JonesMinorAxisB::usage="JonesMinorAxisB[v] gives the minor-axis vector of the polarization ellipse marked by the complex vector v.
JonesMinorAxisB[v,normFunction] normalizes the ellipse by normFunction[v].";

Begin["`Private`"];

JonesMinorAxisB[vec_,normFunction_:(1&)]:=Block[{vecF},
vecF=vec Exp[-I JonesPhase[vec]];
Im[vecF]/normFunction[vecF]
]

End[];


(* ::Input::Initialization:: *)
SpinE::usage="SpinE[E] gives the electric spin angular momentum vector \!\(\*FractionBox[\(1\), \(\(|\)\(E\)\*SuperscriptBox[\(|\), \(2\)]\)]\)Im(E\[Conjugate]\[Cross]E) for a complex electric-field amplitude E.";

Begin["`Private`"];

SpinE[vec_]:=Im[Cross[Conjugate[vec],vec]]/Norm[vec]^2

End[];


(* ::Input::Initialization:: *)
Poincarana::usage="Poincarana[E] gives the Poincarana-representation vectors {\!\(\*SubscriptBox[OverscriptBox[\(u\), \(\[RightArrow]\)], \(1\)]\),\!\(\*SubscriptBox[OverscriptBox[\(u\), \(\[RightArrow]\)], \(2\)]\)} for the electric-field complex amplitude E=\!\(\*OverscriptBox[\(E\), \(\[RightArrow]\)]\)={Ex,Ey,Ez}=\!\(\*SuperscriptBox[\(e\), \(\[ImaginaryI]\[CurlyPhi]\)]\)(\!\(\*OverscriptBox[\(A\), \(\[RightArrow]\)]\)+\[ImaginaryI]\!\(\*OverscriptBox[\(B\), \(\[RightArrow]\)]\)) (in the Jones decomposition), given by \!\(\*SubscriptBox[OverscriptBox[\(u\), \(\[RightArrow]\)], \(i\)]\)=\[PlusMinus]\!\(\*SuperscriptBox[\(f\), \(2\)]\)\!\(\*OverscriptBox[\(a\), \(\[RightArrow]\)]\)+\!\(\*OverscriptBox[\(S\), \(\[RightArrow]\)]\), where \!\(\*OverscriptBox[\(S\), \(\[RightArrow]\)]\)=Im(\!\(\*OverscriptBox[\(E\), \(\[RightArrow]\)]\)\[Conjugate]\[Cross]\!\(\*OverscriptBox[\(E\), \(\[RightArrow]\)]\))/|\!\(\*OverscriptBox[\(E\), \(\[RightArrow]\)]\)\!\(\*SuperscriptBox[\(|\), \(2\)]\) is the spin angular momentum, \!\(\*SuperscriptBox[\(f\), \(2\)]\)=|\!\(\*OverscriptBox[\(A\), \(\[RightArrow]\)]\)|-|\!\(\*OverscriptBox[\(B\), \(\[RightArrow]\)]\)| is the focal distance of the intensity-normalized ellipse, and \!\(\*OverscriptBox[\(a\), \(\[RightArrow]\)]\)=\!\(\*OverscriptBox[\(A\), \(\[RightArrow]\)]\)/|\!\(\*OverscriptBox[\(A\), \(\[RightArrow]\)]\)| is the normalized major-axis direction.";

Begin["`Private`"];

Poincarana[vectorE_]:=Module[{vectorF,comp,\[Alpha],\[Beta],avec,jvec},
vectorF=-Exp[-I JonesPhase[vectorE]]vectorE;
\[Alpha]=Chop[vectorF.vectorF/Norm[vectorF]^2];
\[Beta]=Sqrt[1-\[Alpha]^2];
avec=Re[vectorF]/Norm[Re[vectorF]];
jvec=If[Norm[Im[vectorF]]==0,0,Cross[avec,Im[vectorF]/Norm[Im[vectorF]]]];

{\[Alpha] avec+\[Beta] jvec,-\[Alpha] avec+\[Beta] jvec}
]

End[];


(* ::Input::Initialization:: *)
UniformRadialGrid::usage="UniformRadialGrid[n] produces a uniform radial grid with n rings.
UniformRadialGrid[n,m] produces a uniform radial grid with n rings and m points on the first ring.
UniformRadialGrid[n,m,\[CapitalDelta]r] produces a uniform radial grid with n rings, m points on the first ring, and spacing of \[CapitalDelta]r between the rings.";

Begin["`Private`"];

UniformRadialGrid[nRings_?IntegerQ,nCircle_?IntegerQ,\[CapitalDelta]r_]:=Times[\[CapitalDelta]r,
Join[{{0,0}},
Flatten[
Table[
Table[
{n Cos[\[Phi]],n Sin[\[Phi]]}
,{\[Phi],Most[Subdivide[0,2\[Pi],(nCircle-1)n+1]]}]
,{n,1,nRings}]
,1]
]
]

UniformRadialGrid[nRings_?IntegerQ,nCircle_?IntegerQ]:=UniformRadialGrid[nRings,nCircle,1]
UniformRadialGrid[nRings_?IntegerQ]:=UniformRadialGrid[nRings,7,1]

End[];


(* ::Input::Initialization:: *)
If[
$VersionNumber<10.1,

Subdivide::usage=\!\(\*
TagBox[
StyleBox["\"\<\\!\\(\\*RowBox[{\\\"Subdivide\\\", \\\"[\\\", StyleBox[\\\"n\\\", \\\"TI\\\"], \\\"]\\\"}]\\) generates the list \\!\\(\\*RowBox[{\\\"{\\\", RowBox[{\\\"0\\\", \\\",\\\", RowBox[{\\\"1\\\", \\\"/\\\", StyleBox[\\\"n\\\", \\\"TI\\\"]}], \\\",\\\", RowBox[{\\\"2\\\", \\\"/\\\", StyleBox[\\\"n\\\", \\\"TI\\\"]}], \\\",\\\", StyleBox[\\\"\\[Ellipsis]\\\", \\\"TR\\\"], \\\",\\\", \\\"1\\\"}], \\\"}\\\"}]\\).\\n\\!\\(\\*RowBox[{\\\"Subdivide\\\", \\\"[\\\", RowBox[{SubscriptBox[StyleBox[\\\"x\\\", \\\"TI\\\"], StyleBox[\\\"max\\\", \\\"TI\\\"]], \\\",\\\", StyleBox[\\\"n\\\", \\\"TI\\\"]}], \\\"]\\\"}]\\) generates the list of values obtained by subdividing the interval 0 to \\!\\(\\*SubscriptBox[StyleBox[\\\"x\\\", \\\"TI\\\"], StyleBox[\\\"max\\\", \\\"TI\\\"]]\\) into \\!\\(\\*StyleBox[\\\"n\\\", \\\"TI\\\"]\\) equal parts.\\n\\!\\(\\*RowBox[{\\\"Subdivide\\\", \\\"[\\\", RowBox[{SubscriptBox[StyleBox[\\\"x\\\", \\\"TI\\\"], StyleBox[\\\"min\\\", \\\"TI\\\"]], \\\",\\\", SubscriptBox[StyleBox[\\\"x\\\", \\\"TI\\\"], StyleBox[\\\"max\\\", \\\"TI\\\"]], \\\",\\\", StyleBox[\\\"n\\\", \\\"TI\\\"]}], \\\"]\\\"}]\\) generates the list of values from subdividing the interval \\!\\(\\*SubscriptBox[StyleBox[\\\"x\\\", \\\"TI\\\"], StyleBox[\\\"min\\\", \\\"TI\\\"]]\\) to \\!\\(\\*SubscriptBox[StyleBox[\\\"x\\\", \\\"TI\\\"], StyleBox[\\\"max\\\", \\\"TI\\\"]]\\).\>\"",
ShowSpecialCharacters->False,
ShowStringCharacters->True,
NumberMarks->True],
FullForm]\);

Begin["`Private`"];

Subdivide[xmin_,xmax_,n_]:=xmin+(xmax-xmin)Range[0,n]/n;
Subdivide[xmax_,n_]:=Subdivide[0,xmax,n];
Subdivide[n_]:=Subdivide[0,1,n];

End[];
]


(* ::Input::Initialization:: *)
FieldArrow::usage="FieldArrow[kind,f,{x,y,z}] produces a field arrow associated with the field function f at the position (x,y,z), where the kind can be \"major\" (for a major-axis arrow) or \"spin\" (for the electric spin vector).
FieldArrow[kind,f,{x,y,z},A] multiplies the arrow length by an amplitude A.
FieldArrow[kind,f,{x,y,z},A,zoom] magnifies the position by the specified zoom factor.
FieldArrow[kind,f,{x,y,z},A,zoom,{tx,ty,tz}] translates the position of the arrow by an offset {tx,ty,tz}.";

FieldArrowheadFunction::usage="FieldArrowheadFunction is an option for FieldArrow and PlotFieldArrows that specifies a function of the norm of the arrow vector that should output the size of arrowheads to use.";
FieldArrowThicknessFunction::usage="FieldArrowThicknessFunction is an option for FieldArrow and PlotFieldArrows that specifies a function of the norm of the arrow vector that should output the tube diameter of the arrows.";

Begin["`Private`"];
Protect[FieldArrowThicknessFunction,FieldArrowheadFunction];

Options[FieldArrow]={NormFunction->Norm,PlotStyle->{},FieldArrowThicknessFunction->None,FieldArrowheadFunction->None};

FieldArrow[kind_,fieldFunction_,{x_,y_,z_},opts:OptionsPattern[]]:=FieldArrow[kind,fieldFunction,{x,y,z},1,1,{0,0,0},opts]
FieldArrow[kind_,fieldFunction_,{x_,y_,z_},amplitude_,opts:OptionsPattern[]]:=FieldArrow[kind,fieldFunction,{x,y,z},amplitude,1,{0,0,0},opts]
FieldArrow[kind_,fieldFunction_,{x_,y_,z_},amplitude_,zoom_,opts:OptionsPattern[]]:=FieldArrow[kind,fieldFunction,{x,y,z},amplitude,zoom,{0,0,0},opts]

FieldArrow[kind_,fieldFunction_,{x_,y_,z_},amplitude_,zoom_,translation_,opts:OptionsPattern[]]:=Block[{vect},
vect=Which[
kind=="major",JonesMajorAxisA[fieldFunction[x,y,z],OptionValue[NormFunction]],
kind=="minor",JonesMinorAxisB[fieldFunction[x,y,z],OptionValue[NormFunction]],
kind=="spin",SpinE[fieldFunction[x,y,z]]
];
{
If[
Not[OptionValue[FieldArrowheadFunction]===None],
Arrowheads[OptionValue[FieldArrowheadFunction][amplitude Norm[vect]]],
{}],

ColorData[If[kind=="major","SolarColors","Rainbow"]][(-Re[vect[[3]]]+1)/(2Norm[vect])],
OptionValue[PlotStyle],

Arrow[Tube[
Chop[{
zoom{x,y,z}+translation,
zoom{x,y,z}+translation+amplitude*vect
}],
If[
Not[OptionValue[FieldArrowThicknessFunction]===None],
OptionValue[FieldArrowThicknessFunction][amplitude Norm[vect]],
##&[]]
]]
}
]

End[];


(* ::Input::Initialization:: *)
PlotFieldArrows::usage="PlotFieldArrows[f,kind,rmax] plots a field-arrow plot (for arrows of the chosen kind, either \"major\" axis or \"spin\" vector) for the vector field function f, for radial coordinate from 0 to rmax. 
PlotFieldArrows[f,kind,sm,A] plots a field-arrow plot with amplitude A multiplying each arrow.
PlotFieldArrows[f,kind,sm,A,zoom] plots a field-arrow plot with a magnification zoom on the arrow positions.
PlotFieldArrows[f,kind,sm,A,zoom,{tx,ty,tz}] plots a field-arrow plot with an offset of {tx,ty,tz}.";

Begin["`Private`"];
Options[PlotFieldArrows]={RadialPoints->10,FirstRingPoints->4,PlotStyle->{},NormFunction->Norm,FieldArrowThicknessFunction->None,FieldArrowheadFunction->None};

PlotFieldArrows[fieldFunction_,kind_,rmax_,opts:OptionsPattern[]]:=PlotFieldArrows[fieldFunction,kind,rmax,1,1,{0,0,0},opts]
PlotFieldArrows[fieldFunction_,kind_,rmax_,amplitude_,opts:OptionsPattern[]]:=PlotFieldArrows[fieldFunction,kind,rmax,amplitude,1,{0,0,0},opts]
PlotFieldArrows[fieldFunction_,kind_,rmax_,amplitude_,zoom_,opts:OptionsPattern[]]:=PlotFieldArrows[fieldFunction,kind,rmax,amplitude,zoom,{0,0,0},opts]

PlotFieldArrows[fieldFunction_,kind_,rmax_,amplitude_,zoom_,translation_,opts:OptionsPattern[]]:=Block[{},
Graphics3D[{
Arrowheads[0.02],
Thickness[0.005],
Table[
FieldArrow[kind,fieldFunction,Join[point,{0}],amplitude,zoom,translation,Sequence@@FilterRules[{opts},Options[FieldArrow]]]
,{point,UniformRadialGrid[OptionValue[RadialPoints],OptionValue[FirstRingPoints],rmax/OptionValue[RadialPoints]]}]
}]
]

End[];


(* ::Input::Initialization:: *)
FieldEllipse::usage="FieldEllipse[f,{x,y,z},a] plots the polarization ellipse of the vector field function f at position (x,y,z), with amplitude multiplier a.
FieldEllipse[f,{x,y,z},a,normFunction] normalizes the field values by the maximum of normFunction over a period. The default is (1&) and is inactive; for unit normalization, set to Norm.
FieldEllipse[f,{x,y,z},a,normFunction,zoom] magnifies the position by the specified zoom factor.
FieldEllipse[f,{x,y,z},a,normFunction,zoom,{tx,ty,tz}] translates the position of the ellipse by an offset {tx,ty,tz}.";

Begin["`Private`"];
Options[FieldEllipse]={PlotPoints->72+1};

FieldEllipse[fieldFunction_,{x_,y_,z_},amplitude_,normFunction_:(1&),zoom_:1,translation_:{0,0,0},opts:OptionsPattern[]]:=Block[{field,points,norm},
field=fieldFunction[x,y,z];
points=Table[ Re[E^(-I \[Omega]t) field],{\[Omega]t,0.,360\[Degree],(360\[Degree])/(OptionValue[PlotPoints]-1)}];
norm=Max[normFunction/@points];
{
Polygon[
Map[Function[translation+zoom{x,y,0}+amplitude/norm #],points]
]
}
]

End[];


(* ::Input::Initialization:: *)
PlotFieldEllipses::usage="PlotFieldEllipses[f,amplitude,rmax] plots a field-ellipse plot for the vector field function f, for radial coordinate from 0 to rmax. 
PlotFieldEllipses[f,amplitude,rmax,normFunction] uses the given normFunction to normalize the ellipses.
PlotFieldEllipses[f,amplitude,rmax,normFunction,zoom] uses a magnification zoom on the ellipse positions.
PlotFieldEllipses[f,amplitude,rmax,normFunction,zoom,{tx,ty,tz}] translates the ellipses by an offset {tx,ty,tz}.";

RadialPoints::usage="RadialPoints is an option for PlotFieldArrows and PlotFieldEllipses that indicates how many radial points to use.";
FirstRingPoints::usage="FirstRingPoints is an option for PlotFieldArrows and PlotFieldEllipses that indicates how many points to use on the first ring.";

Begin["`Private`"];
Protect[RadialPoints];
Options[PlotFieldEllipses]={PlotStyle->{},PlotPoints->72+1,RadialPoints->10,FirstRingPoints->4};

PlotFieldEllipses[fieldFunction_,amplitude_,rmax_,opts:OptionsPattern[]]:=PlotFieldEllipses[fieldFunction,amplitude,rmax,Norm,1,{0,0,0},opts]
PlotFieldEllipses[fieldFunction_,amplitude_,rmax_,normFunction_,opts:OptionsPattern[]]:=PlotFieldEllipses[fieldFunction,amplitude,rmax,normFunction,1,{0,0,0},opts]
PlotFieldEllipses[fieldFunction_,amplitude_,rmax_,normFunction_,zoom_,opts:OptionsPattern[]]:=PlotFieldEllipses[fieldFunction,amplitude,rmax,normFunction,zoom,{0,0,0},opts]

PlotFieldEllipses[fieldFunction_,amplitude_,rmax_,normFunction_,zoom_,translation_,opts:OptionsPattern[]]:=Block[{},
Graphics3D[{
EdgeForm[{Thick,Black}],
FaceForm[{RGBColor[0.25, 0.75, 0.75],Specularity[0]}],
OptionValue[PlotStyle],
Table[
FieldEllipse[fieldFunction,Join[point,{0}],amplitude,normFunction,zoom,translation,Sequence@@FilterRules[{opts},Options[FieldEllipse]]]
,{point,UniformRadialGrid[OptionValue[RadialPoints],OptionValue[FirstRingPoints],rmax/OptionValue[RadialPoints]]}]
}]
]

End[];


(* ::Input::Initialization:: *)
EndPackage[];


(* ::Input::Initialization:: *)
DistributeDefinitions["ComplexFocus`"];
