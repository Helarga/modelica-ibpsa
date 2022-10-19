within IBPSA.Fluid.Movers.BaseClasses.Validation;
model EulerCurve "Displays the curve of the Euler number's correlation"
  extends Modelica.Icons.Example;
  Real x "log10(Eu/Eu_peak)";
  Real etaRat "eta/eta_peak";
initial equation
  x = -4;
equation
  der(x)=1;
  etaRat = IBPSA.Fluid.Movers.BaseClasses.Euler.correlation(x);

  annotation (experiment(Tolerance=1e-6, StopTime=10.0),
__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Fluid/Movers/BaseClasses/Validation/EulerCurve.mos"
 "Simulate and plot"),
 Documentation(
info="<html>
<p>
This validation model plots out the correlation function of Euler number
as shown below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://IBPSA/Resources/Images/Fluid/Movers/BaseClasses/Euler/EulerCurve.png\"/>
</p>
<p>
See details of this function in the documentation of
<a href=\"modelica://IBPSA.Fluid.Movers.BaseClasses.Euler.correlation\">
IBPSA.Fluid.Movers.BaseClasses.Euler.correlation</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 23, 2021, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
</ul>
</html>"));
end EulerCurve;
