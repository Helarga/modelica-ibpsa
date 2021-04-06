within IBPSA.Fluid.Sources.Examples;
model Outside_CpData
  "Test model for source and sink with outside weather data and wind pressure using user-defined Cp values"
  extends Modelica.Icons.Example;
  package Medium = IBPSA.Media.Air "Medium model for air";
  IBPSA.Fluid.Sources.Outside_CpData    west(
    redeclare package Medium = Medium,
    azi=IBPSA.Types.Azimuth.W)
             "Model with outside conditions"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IBPSA.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=Modelica.Utilities.Files.loadResource("modelica://IBPSA/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  IBPSA.Fluid.Sources.Outside_CpData    north(
    redeclare package Medium = Medium,
    azi=IBPSA.Types.Azimuth.N)
             "Model with outside conditions"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  IBPSA.Fluid.Sources.Outside_CpData    south(
    redeclare package Medium = Medium,
    azi=IBPSA.Types.Azimuth.S)
             "Model with outside conditions"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  IBPSA.Fluid.Sources.Outside_CpData    east(
    redeclare package Medium = Medium,
    azi=IBPSA.Types.Azimuth.E)
             "Model with outside conditions"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation
  connect(weaDat.weaBus, west.weaBus)     annotation (Line(
      points={{-60,10},{-40,10},{-40,10.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaDat.weaBus, north.weaBus) annotation (Line(
      points={{-60,10},{-50,10},{-50,50.2},{-20,50.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaDat.weaBus, south.weaBus) annotation (Line(
      points={{-60,10},{-50,10},{-50,-29.8},{-20,-29.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaDat.weaBus, east.weaBus) annotation (Line(
      points={{-60,10},{-50,10},{-50,-10},{30,-10},{30,10.2},{40,10.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Fluid/Sources/Examples/Outside_CpLowRise.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of a source for ambient conditions that computes
the wind pressure on a facade of a low-rise building.
Weather data are used for San Francisco, for a period of a week
where the wind blows primarily from North-West.
The plot shows that the wind pressure on the north- and west-facing
facade is positive,
whereas it is negative for the south- and east-facing facades.
</p>
</html>", revisions="<html>
<ul>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-Buildings/issues/311\">#311</a>.
</li>
<li>
October 26, 2011 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StartTime=1.728e+07,
      StopTime=1.78848e+07,
      Tolerance=1e-6));
end Outside_CpData;
