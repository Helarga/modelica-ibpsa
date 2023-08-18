within IBPSA.Fluid.Geothermal.Aquifer;
model MultiWell "Model of a single well for aquifer thermal energy storage"
 replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation (choices(
        choice(redeclare package Medium = IBPSA.Media.Water "Water")));
  parameter Integer nVol(min=1)=10 "Number of volumes" annotation (
      Dialog(group="Domain discretization"));
  parameter Modelica.Units.SI.Height h=200 "Aquifer thickness";
  parameter Real phi=0.2 "Reservoir porosity";
  parameter Real nCoo=1 "Number of cold wells";
  parameter Real nHot=1 "Number of warm wells";
  parameter Modelica.Units.SI.Radius r_wb=0.1 "Wellbore radius" annotation (
      Dialog(group="Domain discretization"));
  parameter Modelica.Units.SI.Radius r_max=2400 "Domain radius" annotation (
      Dialog(group="Domain discretization"));
  parameter Real griFac(min=1) = 1.15 "Grid factor for spacing" annotation (
      Dialog(group="Domain discretization"));
  parameter Modelica.Units.SI.Temperature T_ini_coo=273.15+10 "Initial temperature of cold well" annotation (
      Dialog(group="Domain discretization"));
  parameter Modelica.Units.SI.Temperature T_ini_hot=273.15+10 "Initial temperature of warm well" annotation (
      Dialog(group="Domain discretization"));
  parameter Modelica.Units.SI.Temperature TGroCoo=273.15+12 "Undisturbed ground temperature (cold well)" annotation (
      Dialog(group="Properties of ground"));
  parameter Modelica.Units.SI.Temperature TGroHot=273.15+12 "Undisturbed ground temperature (warm well)" annotation (
      Dialog(group="Properties of ground"));
  parameter IBPSA.Fluid.Geothermal.Aquifer.Data.Template aquDat "Aquifer thermal properties" annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal "Nominal mass flow rate" annotation (
      Dialog(group="Hydraulic circuit"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal_aquifer(displayUnit="Pa") "Pressure drop at nominal mass flow rate in the aquifer" annotation (
      Dialog(group="Hydraulic circuit"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal_well(displayUnit="Pa") "Pressure drop at nominal mass flow rate in the well" annotation (
      Dialog(group="Hydraulic circuit"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal_hex(displayUnit="Pa") "Pressure drop at nominal mass flow rate in the heat exchanger" annotation (
      Dialog(group="Hydraulic circuit"));

  IBPSA.Fluid.MixingVolumes.MixingVolume volCoo[nVol](
    redeclare final package Medium = Medium,
    each T_start=T_ini_coo,
    each m_flow_nominal=m_flow_nominal,
    V=VWat*nCoo,
    each nPorts=2)
    "Array of fluid volumes representing the fluid flow in the cold side of the aquifer"
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare final package Medium=Medium)
    "Fluid connector"
    annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapCoo[nVol](C=C*nCoo,
      each T(start=T_ini_coo, fixed=true))
    "Array of thermal capacitor in the cold side of the aquifer"
    annotation (Placement(transformation(extent={{-22,-60},{-2,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor theResCoo[nVol](R=R/nCoo)
    "Array of thermal resistances in the cold side of the aquifer"
    annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groTemCoo(T=TGroCoo)
    "Boundary condition ground temperature in the cold side of the aquifer"
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  Airflow.Multizone.Point_m_flow powCoo(redeclare final package Medium = Medium,
    m=1,
    dpMea_nominal=dp_nominal_aquifer,
    mMea_flow_nominal=m_flow_nominal) "Pressure drop in the cold side of the aquifer"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-80,-10})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare final package Medium =
        Medium)
    "Fluid connector"
    annotation (Placement(transformation(extent={{40,90},{60,110}})));
  MixingVolumes.MixingVolume volHot[nVol](
    redeclare final package Medium = Medium,
    each T_start=T_ini_hot,
    each m_flow_nominal=m_flow_nominal,
    V=VWat*nHot,
    each nPorts=2)
    "Array of fluid volumes representing the fluid flow in the warm side of the aquifer"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCapHot[nVol](C=C*nHot,
      each T(start=T_ini_hot, fixed=true))
    "Array of thermal capacitor in the warm side of the aquifer"
    annotation (Placement(transformation(extent={{22,-60},{2,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor theResHot[nVol](R=R/nHot)
    "Array of thermal resistances in the warm side of the aquifer"
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groTemHot(T=TGroHot)
    "Boundary condition ground temperature in the warm side of the aquifer"
    annotation (Placement(transformation(extent={{90,-70},{70,-50}})));
  FixedResistances.PressureDrop resCoo(
    redeclare final package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal_well)
                           "Pressure drop in the cold well" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-80,50})));
  Airflow.Multizone.Point_m_flow       powHot(redeclare final package Medium =
        Medium,
    m=1,
    dpMea_nominal=dp_nominal_aquifer,
    mMea_flow_nominal=m_flow_nominal)
                "Pressure drop in the warm side of the aquifer" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={80,-10})));
  FixedResistances.PressureDrop resHot(
    redeclare final package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal_well)
                           "Pressure drop in the warm well" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={80,50})));
  Movers.Preconfigured.SpeedControlled_y
                           mov(redeclare final package Medium =
        Medium, addPowerToMedium=false,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal_aquifer*2 + dp_nominal_well*2 + dp_nominal_hex)
                               annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,20})));
  Movers.Preconfigured.SpeedControlled_y
                           mov1(redeclare final package Medium =
        Medium, addPowerToMedium=false,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal_aquifer*2 + dp_nominal_well*2 + dp_nominal_hex)
                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,20})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-8,40},{12,60}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
protected
  parameter Modelica.Units.SI.Radius r[nVol + 1](each fixed=false)
    "Radius to the boundary of the i-th domain";
  parameter Modelica.Units.SI.Radius rC[nVol](each fixed=false)
    "Radius to the center of the i-th domain";
  parameter Modelica.Units.SI.SpecificHeatCapacity cpWat(fixed=false)
    "Water specific heat capacity";
  parameter Modelica.Units.SI.Density rhoWat(fixed=false)
    "Water density";
  parameter Modelica.Units.SI.ThermalConductivity kWat(fixed=false)
    "Water thermal conductivity";
  parameter Modelica.Units.SI.HeatCapacity C[nVol](each fixed=false)
    "Heat capacity of segment";
  parameter Modelica.Units.SI.Volume VWat[nVol](each fixed=false)
    "Volumes of water";
  parameter Modelica.Units.SI.ThermalResistance R[nVol+1](each fixed=false)
    "Thermal resistances between nodes";
  parameter Real cAqu(each fixed=false)
    "Heat capacity normalized with volume for aquifer";
  parameter Real kVol(each fixed=false)
    "Heat conductivity normalized with volume";

initial equation
  assert(r_wb < r_max, "Error: Model requires r_wb < r_max");
  assert(0 < r_wb,   "Error: Model requires 0 < r_wb");

  cAqu=aquDat.dSoi*aquDat.cSoi*(1-phi);
  kVol=kWat*phi+aquDat.kSoi*(1-phi);

  cpWat=Medium.specificHeatCapacityCp(Medium.setState_pTX(
    Medium.p_default,
    Medium.T_default,
    Medium.X_default));
  rhoWat=Medium.density(Medium.setState_pTX(
    Medium.p_default,
    Medium.T_default,
    Medium.X_default));
  kWat=Medium.thermalConductivity(Medium.setState_pTX(
    Medium.p_default,
    Medium.T_default,
    Medium.X_default));

  r[1] = r_wb;
  for i in 2:nVol+1 loop
    r[i]= r[i-1] + (r_max - r_wb)  * (1-griFac)/(1-griFac^(nVol)) * griFac^(i-2);
  end for;
  for i in 1:nVol loop
    rC[i] = (r[i]+r[i+1])/2;
  end for;
  for i in 1:nVol loop
    C[i] = cAqu*h*3.14*(r[i+1]^2-r[i]^2);
  end for;
  for i in 1:nVol loop
    VWat[i] = phi*h*3.14*(r[i+1]^2-r[i]^2);
  end for;
  R[1]=Modelica.Math.log(rC[1]/r_wb)/(2*Modelica.Constants.pi*kVol*h);
  R[nVol+1]=Modelica.Math.log(r_max/rC[nVol])/(2*Modelica.Constants.pi*kVol*h);
  for i in 2:nVol loop
  R[i] = Modelica.Math.log(rC[i]/rC[i-1])/(2*Modelica.Constants.pi*kVol*h);
  end for;

equation

  if nVol > 1 then
    for i in 1:(nVol - 1) loop
      connect(volCoo[i].ports[2], volCoo[i + 1].ports[1]);
    end for;
  end if;

  if nVol > 1 then
    for i in 1:(nVol - 1) loop
      connect(volHot[i].ports[2], volHot[i + 1].ports[1]);
    end for;
  end if;

  if nVol > 1 then
    for i in 1:(nVol - 1) loop
      connect(heaCapCoo[i + 1].port, theResCoo[i].port_b);
    end for;
  end if;

  if nVol > 1 then
    for i in 1:(nVol - 1) loop
      connect(heaCapHot[i + 1].port, theResHot[i].port_b);
    end for;
  end if;

  connect(groTemCoo.port, theResCoo[nVol].port_b)
    annotation (Line(points={{-70,-60},{-60,-60}}, color={191,0,0}));

  connect(volCoo.heatPort, heaCapCoo.port) annotation (Line(points={{-40,0},{-28,
          0},{-28,-60},{-12,-60}},  color={191,0,0}));
  connect(theResCoo.port_a, volCoo.heatPort) annotation (Line(points={{-40,-60},
          {-28,-60},{-28,0},{-40,0}},   color={191,0,0}));
  connect(groTemHot.port, theResHot[nVol].port_b)
    annotation (Line(points={{70,-60},{60,-60}}, color={191,0,0}));
  connect(volHot.heatPort, heaCapHot.port) annotation (Line(points={{40,0},{30,0},
          {30,-60},{12,-60}},     color={191,0,0}));
  connect(theResHot.port_a, volHot.heatPort) annotation (Line(points={{40,-60},{
          30,-60},{30,0},{40,0}},   color={191,0,0}));
  connect(resCoo.port_b, port_a)
    annotation (Line(points={{-80,60},{-80,86},{-50,86},{-50,100}},
                                                  color={0,127,255}));
  connect(resHot.port_b, port_a1)
    annotation (Line(points={{80,60},{80,86},{50,86},{50,100}},
                                                color={0,127,255}));
  connect(powCoo.port_a, volCoo[1].ports[1]) annotation (Line(points={{-80,-20},
          {-80,-34},{-49,-34},{-49,-10}},
                                  color={0,127,255}));
  connect(powHot.port_a, volHot[1].ports[1]) annotation (Line(points={{80,-20},{
          80,-34},{49,-34},{49,-10}},
                            color={0,127,255}));
  connect(volCoo[nVol].ports[2], volHot[nVol].ports[2]) annotation (Line(points={{-51,-10},
          {-48,-10},{-48,-22},{51,-22},{51,-10}},
                                         color={0,127,255}));
  connect(powCoo.port_b, mov.port_a)
    annotation (Line(points={{-80,0},{-80,10}},  color={0,127,255}));
  connect(mov.port_b, resCoo.port_a)
    annotation (Line(points={{-80,30},{-80,40}}, color={0,127,255}));
  connect(resHot.port_a, mov1.port_b)
    annotation (Line(points={{80,40},{80,30}}, color={0,127,255}));
  connect(powHot.port_b, mov1.port_a)
    annotation (Line(points={{80,0},{80,10}},  color={0,127,255}));
  connect(limiter.y, mov.y) annotation (Line(points={{-39,50},{-30,50},{-30,20},
          {-68,20}}, color={0,0,127}));
  connect(gain.y, limiter1.u)
    annotation (Line(points={{13,50},{28,50}}, color={0,0,127}));
  connect(limiter1.y, mov1.y) annotation (Line(points={{51,50},{60,50},{60,20},{
          68,20}}, color={0,0,127}));
  connect(gain.u, u) annotation (Line(points={{-10,50},{-20,50},{-20,70},{-120,70}},
        color={0,0,127}));
  connect(limiter.u, u) annotation (Line(points={{-62,50},{-68,50},{-68,70},{-120,
          70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-20,100},{20,-2}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{20,2},{-20,-6}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={211,168,137},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-100,20},{100,-48}},
          fillColor={241,241,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,100},{100,82}},
          lineColor={0,0,0},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,100},{-24,-14}},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-24,-6},{-72,-22}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-147,-108},{153,-148}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{26,100},{74,-14}},
          fillColor={238,22,26},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{74,-6},{26,-22}},
          lineColor={0,0,0},
          fillColor={182,12,18},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        defaultComponentName="aquWel",
        Documentation(info="<html>
<p>
This model simulates aquifer thermal energy storage.
</p>
<p>
To calculate aquifer temperature at different locations over time, the model applies 
theoretical principles of water flow and heat transfer phenomena. The model is based on 
the partial differential equation (PDE) for 1D conductive-convective transient 
radial heat transport in porous media
</p>
<p align=\"center\" style=\"font-style:italic;\">
&rho; c (&part; T(r,t) &frasl; &part;t) =
k (&part;&sup2; T(r,t) &frasl; &part;r&sup2;) - &rho;<sub>w</sub> c<sub>w</sub> u(&part; T(r,t) &frasl; &part;t),
</p>
<p>
where
<i>&rho;</i>
is the mass density,
<i>c</i>
is the specific heat capacity per unit mass,
<i>T</i>
is the temperature at location <i>r</i> and time <i>t</i>,
<i>u</i> is water velocity and
<i>k</i> is the heat conductivity. The subscript <i>w</i> indicates water.
The first term on the right hand side of the equation describes the effect of conduction, while
the second term describes the fluid flow.
</p>
<h4>Spatial discretization</h4>
<p>
To discretize the conductive-convective equation, the domain is divided into a series 
of thermal capacitances and thermal resistances along the radial direction. The 
implementation uses an array of 
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a>
and <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">Modelica.Thermal.HeatTransfer.Components.ThermalResistor</a>
Fluid flow was modelled by adding a series of fluid volumes, which are connected 
to the thermal capacitances via heat ports. The fluid stream was developed using 
the model <a href=\"modelica://IBPSA.Fluid.MixingVolumes.MixingVolume\">IBPSA.Fluid.MixingVolumes.MixingVolume</a>.
The geometric representation of the model is illustrated in the figure below. 
</p>
<p align=\"center\">
<img  alt=\"image\" src=\"modelica://IBPSA/Resources/Images/Fluid/Geothermal/Aquifer/Geometry.png\" width=\"800\">
</p>
<h4>Typical use and important parameters</h4>
<p>
By default, the component consists of a cold well and a warm well. The number of wells can be increased by modifing the parameters <code>nCoo</code> and <code>nHot</code>. 
The effect is a proportional increase of thermal capacity. 
</p>
<p>
To ensure conservation of energy, the two wells are connected via fluid ports. To avoid thermal interferences, make sure that the aquifer domain radius <code>r_max</code> is large enough for your specific use case. 
</p>
<p>
Circulation pumps are included in the model and they can be controlled by acting on the input connector. The input must vary between [1,-1]. A positive value will circulate water
clockwise (extraction from the cold well and injection into the warm well). A negative value will circulate water anticlockwise (extraction from the warm well and injection into the cold well). 
</p>
</html>", revisions="<html>
<ul>
<li>
May 2023, by Alessandro Maccarini:<br/>
First Implementation.
</li>
</ul>
</html>"));
end MultiWell;