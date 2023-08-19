within IBPSA.Fluid.Geothermal.Aquifer.Examples;
model CoolingOffice
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.HeatFlowRate QCoo_flow_nominal=30000
    "Cooling power";
  parameter Modelica.Units.SI.TemperatureDifference deltaT=4 "Temperature difference at heat exchanger";
  parameter Modelica.Units.SI.SpecificHeatCapacity cpWat=4186 "Heat capacity of water";
  parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal=
    QCoo_flow_nominal/(deltaT*cpWat) "Nominal water mass flow rate";

  HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = IBPSA.Media.Water,
    m_flow_nominal=mWat_flow_nominal,
    dp_nominal=100,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=QCoo_flow_nominal) "Heat exchanger"
    annotation (Placement(transformation(extent={{-10,54},{10,74}})));
  Modelica.Blocks.Sources.Constant uPum(k=1) "Pump control signal"
    annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
  Modelica.Blocks.Sources.Constant uHea(k=1) "Heat load control signal"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  MultiWell aquWel(
    redeclare package Medium = IBPSA.Media.Water,
    nVol=80,
    h=20,
    r_max=500,
    TCoo_start=285.15,
    THot_start=285.15,
    aquDat=IBPSA.Fluid.Geothermal.Aquifer.Data.Rock(),
    m_flow_nominal=mWat_flow_nominal,
    dpAcquifer_nominal(displayUnit="Pa") = 10,
    dpWell_nominal(displayUnit="Pa") = 10,
    dpExt_nominal(displayUnit="Pa") = 100)
    "Acquifer well"
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Sources.Boundary_pT bou(
    redeclare package Medium = IBPSA.Media.Water,
    nPorts=1) "Pressure boundary condition" annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(uHea.y, hea.u)
    annotation (Line(points={{-39,70},{-12,70}}, color={0,0,127}));
  connect(aquWel.port_Hot, hea.port_b) annotation (Line(points={{6,0},{6,30},{20,
          30},{20,64},{10,64}},    color={0,127,255}));
  connect(aquWel.port_Col, hea.port_a) annotation (Line(points={{-6,0},{-6,0},{-6,
          30},{-20,30},{-20,64},{-10,64}},    color={0,127,255}));
  connect(bou.ports[1], hea.port_a) annotation (Line(points={{-60,30},{-20,30},
          {-20,64},{-10,64}},                  color={0,127,255}));
  connect(uPum.y, aquWel.u)
    annotation (Line(points={{-39,-4},{-12,-4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=7776000,Tolerance=1e-6),
    __Dymola_Commands(file=
  "modelica://IBPSA/Resources/Scripts/Dymola/Fluid/Geothermal/Aquifer/Examples/CoolingOffice.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example shows the application of the model
<a href=\"modelica://IBPSA.Fluid.Geothermal.Aquifer.SingleWell\">IBPSA.Fluid.Geothermal.Aquifer.SingleWell</a>.
</p>
<p>
The system consists of two wells, a warm well and a cold well. Water is extracted from the cold well at 12C and
after passing through a heat exchanger it is injected in the warm well at 16C. This may represent the operation of an
aquifer thermal energy storage system that cools an office building with a constant load of 30 kW.
</p>

</html>", revisions="<html>
<ul>
<li>
May 2023, by Alessandro Maccarini:<br/>
First Implementation.
</li>
</ul>
</html>"));
end CoolingOffice;
