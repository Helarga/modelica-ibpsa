within IBPSA.ThermalZones.ISO13790.Validation.BESTEST;
model Case600 "Case 600FF, but with dual-setpoint for heating and cooling"
  extends Case600FF;
  Modelica.Blocks.Math.Sum sumHeaCoo(nin=2)
    "Sum of heating and cooling heat flow rate"
                                              annotation (
    Placement(visible = true, transformation(extent={{54,56},{62,64}},      rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaCoo
    "Prescribed heat flow for heating and cooling"
    annotation (Placement(visible=true, transformation(extent={{68,54},{80,66}},
          rotation=0)));
  Modelica.Blocks.Math.Gain gaiHea(k=1E6) "Gain for heating"
                                          annotation (Placement(visible=true,
        transformation(
        origin={22,72},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  IBPSA.Controls.Continuous.LimPID conHeaPID(
    Ti=300,
    k=0.1,
    reverseActing=true,
    strict=true) "Controller for heating"
                 annotation (Placement(visible=true, transformation(
        origin={0,72},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant TSetHea(k=273.15 + 20)
    "Set-point for heating"                               annotation (Placement(
        visible=true, transformation(
        origin={-24,72},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant TSetCoo(k=273.15 + 27)
    "Set-point for cooling"                               annotation (Placement(
        visible=true, transformation(
        origin={-24,46},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  Modelica.Blocks.Routing.Multiplex2 multiplex2 annotation (
    Placement(visible = true, transformation(extent={{38,56},{46,64}},      rotation = 0)));
  Modelica.Blocks.Math.Gain gaiCoo(k=-1E6) "Gain for cooling"
                                           annotation (Placement(visible=true,
        transformation(
        origin={22,46},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  IBPSA.Controls.Continuous.LimPID conCooPID(
    Ti=300,
    k=0.1,
    reverseActing=false,
    strict=true) "Controller for cooling"
                 annotation (Placement(visible=true, transformation(
        origin={0,46},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir
    "Room air temperature"                                        annotation (
    Placement(visible = true, transformation(extent={{12,20},{20,28}},      rotation = 0)));
  Modelica.Blocks.Continuous.Integrator ECoo(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    u(unit="W"),
    y(unit="J")) "Cooling energy in Joules"
    annotation (Placement(transformation(extent={{54,34},{66,46}})));
  Modelica.Blocks.Continuous.Integrator EHea(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    u(unit="W"),
    y(unit="J")) "Heating energy in Joules"
    annotation (Placement(transformation(extent={{54,76},{66,88}})));
equation
  connect(sumHeaCoo.y,preHeaCoo. Q_flow)
    annotation (Line(points={{62.4,60},{68,60}}, color={0,0,127}));
  connect(conHeaPID.y,gaiHea. u)
    annotation (Line(points={{6.6,72},{14.8,72}}, color={0,0,127}));
  connect(TSetHea.y,conHeaPID. u_s)
    annotation (Line(points={{-17.4,72},{-7.2,72}},  color={0,0,127}));
  connect(gaiHea.y,multiplex2. u1[1]) annotation (Line(points={{28.6,72},{37.2,
          72},{37.2,62.4}}, color={0,0,127}));
  connect(multiplex2.y,sumHeaCoo. u) annotation (
    Line(points={{46.4,60},{53.2,60}},      color = {0, 0, 127}));
  connect(gaiCoo.y,multiplex2. u2[1]) annotation (Line(points={{28.6,46},{37.2,
          46},{37.2,57.6}}, color={0,0,127}));
  connect(conCooPID.u_s,TSetCoo. y)
    annotation (Line(points={{-7.2,46},{-17.4,46}},  color={0,0,127}));
  connect(conCooPID.y,gaiCoo. u)
    annotation (Line(points={{6.6,46},{14.8,46}}, color={0,0,127}));
  connect(conHeaPID.y,gaiHea. u)
    annotation (Line(points={{6.6,72},{14.8,72}}, color={0,0,127}));
  connect(gaiHea.y,multiplex2. u1[1]) annotation (Line(points={{28.6,72},{37.2,
          72},{37.2,62.4}}, color={0,0,127}));
  connect(gaiCoo.y,multiplex2. u2[1]) annotation (Line(points={{28.6,46},{37.2,
          46},{37.2,57.6}}, color={0,0,127}));
  connect(gaiCoo.u,conCooPID. y)
    annotation (Line(points={{14.8,46},{6.6,46}}, color={0,0,127}));
  connect(conCooPID.u_m, TRooAir.T) annotation (Line(points={{0,38.8},{0,34},{
          24,34},{24,24},{20.4,24}}, color={0,0,127}));
  connect(EHea.u, gaiHea.y) annotation (Line(points={{52.8,82},{44,82},{44,72},
          {28.6,72}}, color={0,0,127}));
  connect(ECoo.u, gaiCoo.y) annotation (Line(points={{52.8,40},{44,40},{44,46},
          {28.6,46}}, color={0,0,127}));
  connect(conHeaPID.u_m, TRooAir.T) annotation (Line(points={{0,64.8},{0,60},{
          10,60},{10,34},{24,34},{24,24},{20.4,24}}, color={0,0,127}));

  connect(TRooAir.port, zon5R1C.TAir)
    annotation (Line(points={{12,24},{4,24},{4,8}}, color={191,0,0}));
  connect(preHeaCoo.port, zon5R1C.TAir)
    annotation (Line(points={{80,60},{88,60},{88,8},{4,8}}, color={191,0,0}));
 annotation(experiment(Tolerance=1e-6, StopTime=3.1536e+007),
  __Dymola_Commands(file=
  "modelica://IBPSA/Resources/Scripts/Dymola/ThermalZones/ISO13790/Validation/BESTEST/Case600.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
This model is used for the basic test case 600 of the BESTEST validation suite. 
Case 600 is a light-weight building with room temperature control set to <i>20</i>&deg;C 
for heating and <i>27</i>&deg;C for cooling. The room has no shade and a window that faces south. 
</p>
</html>", revisions="<html><ul>
<li>
Mar 16, 2022, by Alessandro Maccarini:<br/>
First implementation.
</li>
</ul></html>"));
end Case600;
