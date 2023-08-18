within IBPSA.Fluid.Geothermal.Aquifer.Validation;
model NumberWells
  "Test model for aquifer thermal energy storage with multiple wells"
  extends Modelica.Icons.Example;
  MultiWell aquWel1(
    redeclare package Medium = IBPSA.Media.Water,
    nVol=50,
    h=10,
    T_ini_hot=303.15,
    TGroCoo=273.15,
    TGroHot=303.15,
    aquDat=IBPSA.Fluid.Geothermal.Aquifer.Data.Rock(),
    m_flow_nominal=0.1,
    dp_nominal_aquifer=10,
    dp_nominal_well=10,
    dp_nominal_hex=0) "ATES with one pair of wells"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  MultiWell aquWel2(
    redeclare package Medium = IBPSA.Media.Water,
    nVol=50,
    h=10,
    nCoo=2,
    nHot=2,
    T_ini_hot=303.15,
    TGroCoo=273.15,
    TGroHot=303.15,
    aquDat=IBPSA.Fluid.Geothermal.Aquifer.Data.Rock(),
    m_flow_nominal=0.2,
    dp_nominal_aquifer=10,
    dp_nominal_well=10,
    dp_nominal_hex=0) "ATES with two pairs of wells"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant mWat(k=1)
    "Constat value of water mass flow rate"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sources.Boundary_pT bou(redeclare package Medium = IBPSA.Media.Water, nPorts=2) "Sink"
           annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression temWel1(y=aquWel1.heaCapHot[10].T)
    "Temperature output from aquifer model with one pair of wells"
    annotation (Placement(transformation(extent={{20,72},{40,92}})));
  Modelica.Blocks.Sources.RealExpression temWel2(y=aquWel2.heaCapHot[10].T)
    "Temperature output from aquifer model with two pairs of wells"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Utilities.Diagnostics.CheckEquality  cheEqu
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(mWat.y, aquWel1.u) annotation (Line(points={{-59,0},{-40,0},{-40,37},
          {-22,37}}, color={0,0,127}));
  connect(aquWel2.u, mWat.y) annotation (Line(points={{-22,-43},{-40,-43},{-40,
          0},{-59,0}}, color={0,0,127}));
  connect(aquWel2.port_a,aquWel2. port_a1) annotation (Line(points={{-15,-40},{
          -14,-40},{-14,-20},{-5,-20},{-5,-40}}, color={0,127,255}));
  connect(aquWel1.port_a, aquWel1.port_a1) annotation (Line(points={{-15,40},{-14,
          40},{-14,60},{-5,60},{-5,40}}, color={0,127,255}));
  connect(bou.ports[1], aquWel1.port_a1) annotation (Line(points={{40,-1},{6,-1},
          {6,60},{-5,60},{-5,40}}, color={0,127,255}));
  connect(bou.ports[2], aquWel2.port_a1) annotation (Line(points={{40,1},{26,1},
          {26,0},{6,0},{6,-20},{-5,-20},{-5,-40}}, color={0,127,255}));
  connect(cheEqu.u1, temWel1.y) annotation (Line(points={{58,76},{46,76},{46,82},
          {41,82}}, color={0,0,127}));
  connect(cheEqu.u2, temWel2.y) annotation (Line(points={{58,64},{46,64},{46,50},
          {41,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=31536000, Tolerance=1e-6),
    __Dymola_Commands(file=
  "modelica://IBPSA/Resources/Scripts/Dymola/Fluid/Geothermal/Aquifer/Validation/SimulationTest.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Example that verifies the scalability of <a href=\"modelica://IBPSA.Fluid.Geothermal.Aquifer.MultiWell\">IBPSA.Fluid.Geothermal.Aquifer.MultiWell</a> when multiple wells are used. T
</p>
</html>", revisions="<html>
<ul>
<li>
May 2023, by Alessandro Maccarini:<br/>
First Implementation.
</li>
</ul>
</html>"));
end NumberWells;
