within Annex60.Fluid.Interfaces.Examples;
model HumidifierPrescribed
  extends Modelica.Icons.Example;

 package Medium = Annex60.Media.Air;
 parameter Modelica.SIunits.MassFlowRate mWat_flow_nominal = 0.001
    "Nominal water mass flow rate";
  Humidifier hea1(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-54,92},{-34,112}}, rotation=0)));
  Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
    annotation (Placement(transformation(extent={{-200,92},{-180,112}},
          rotation=0)));
  Annex60.Fluid.Sources.Boundary_pT sou_1(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=4,
    p(displayUnit="Pa") = 101435,
    T=293.15)             annotation (Placement(transformation(extent={{-168,92},
            {-148,112}}, rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_11(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,92},{-80,112}},
          rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_12(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,134},{-80,154}},
          rotation=0)));
  Annex60.Fluid.Sources.Boundary_pT sin_1(
    redeclare package Medium = Medium,
    use_p_in=true,
    T=288.15,
    nPorts=4)             annotation (Placement(transformation(extent={{-168,
            134},{-148,154}}, rotation=0)));
    Modelica.Blocks.Sources.Constant POut(k=101325)
      annotation (Placement(transformation(extent={{-200,140},{-180,160}},
          rotation=0)));
    Modelica.Blocks.Sources.Ramp u(
    duration=3600,
    startTime=0,
    height=1,
    offset=0) "Control signal"
                 annotation (Placement(transformation(extent={{-148,174},{-128,
            194}}, rotation=0)));
  Humidifier hea2(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-12,134},{8,154}}, rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
          extent={{-50,174},{-30,194}}, rotation=0)));
  Humidifier hea3(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-54,12},{-34,32}}, rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_2(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,12},{-80,32}},
          rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_3(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,54},{-80,74}},
          rotation=0)));
  Humidifier hea4(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-12,54},{8,74}}, rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_4(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(
        origin={20,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Annex60.Fluid.MixingVolumes.MixingVolume mix1(
    redeclare package Medium = Medium,
    V=0.000001,
    nPorts=2,
    m_flow_nominal=0.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                 annotation (Placement(transformation(extent={{-20,22},{0,42}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass1(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,140},{180,160}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y1(y=hea2.staB.T)
    annotation (Placement(transformation(extent={{40,150},{140,170}}, rotation=
            0)));
  Modelica.Blocks.Sources.RealExpression y2(y=hea1.staB.T)
    annotation (Placement(transformation(extent={{40,130},{140,150}}, rotation=
            0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass2(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,100},{180,120}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y3(y=hea2.staA.T)
    annotation (Placement(transformation(extent={{40,110},{140,130}}, rotation=
            0)));
  Modelica.Blocks.Sources.RealExpression y4(y=hea1.staA.T)
    annotation (Placement(transformation(extent={{40,90},{140,110}}, rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass3(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,38},{180,58}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y5(y=hea4.staB.T)
    annotation (Placement(transformation(extent={{40,48},{140,68}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y6(y=hea3.staB.T)
    annotation (Placement(transformation(extent={{40,28},{140,48}}, rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass4(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-2},{180,18}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y7(y=hea4.staA.T)
    annotation (Placement(transformation(extent={{40,8},{140,28}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y8(y=hea3.staA.T)
    annotation (Placement(transformation(extent={{40,-12},{140,8}}, rotation=0)));
  Humidifier hea5(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-54,-110},{-34,-90}}, rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_1(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,-110},{-80,-90}},
          rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_5(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,-68},{-80,-48}},
          rotation=0)));
  Humidifier hea6(                               redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-12,-68},{8,-48}}, rotation=0)));
  Humidifier hea7(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-54,-190},{-34,-170}}, rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_6(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,-190},{-80,-170}},
          rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_7(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(extent={{-100,-148},{-80,-128}},
          rotation=0)));
  Humidifier hea8(                               redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    mWat_flow_nominal=mWat_flow_nominal,
    dp_nominal=50,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heater and cooler"                           annotation (Placement(
        transformation(extent={{-12,-148},{8,-128}}, rotation=0)));
    Annex60.Fluid.FixedResistances.FixedResistanceDpM res_8(
    redeclare package Medium = Medium,
    dp_nominal=5,
    m_flow_nominal=0.5)
             annotation (Placement(transformation(
        origin={20,-162},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Annex60.Fluid.MixingVolumes.MixingVolume mix2(
                                           redeclare package Medium = Medium, V=
       0.000001,
    nPorts=2,
    m_flow_nominal=0.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                 annotation (Placement(transformation(extent={{-20,-180},{0,
            -160}}, rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass5(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-62},{180,-42}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y9(y=hea6.staB.T)
    annotation (Placement(transformation(extent={{40,-50},{140,-30}}, rotation=
            0)));
  Modelica.Blocks.Sources.RealExpression y10(
                                            y=hea5.staB.T)
    annotation (Placement(transformation(extent={{40,-72},{140,-52}}, rotation=
            0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass6(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-102},{180,-82}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y11(
                                            y=hea6.staA.T)
    annotation (Placement(transformation(extent={{40,-92},{140,-72}}, rotation=
            0)));
  Modelica.Blocks.Sources.RealExpression y12(
                                            y=hea5.staA.T)
    annotation (Placement(transformation(extent={{40,-112},{140,-92}}, rotation=
           0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass7(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-164},{180,-144}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y13(
                                            y=hea8.staB.T)
    annotation (Placement(transformation(extent={{40,-154},{140,-134}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y14(
                                            y=hea7.staB.T)
    annotation (Placement(transformation(extent={{40,-174},{140,-154}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass8(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-204},{180,-184}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y15(
                                            y=hea8.staA.T)
    annotation (Placement(transformation(extent={{40,-194},{140,-174}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y16(
                                            y=hea7.staA.T)
    annotation (Placement(transformation(extent={{40,-214},{140,-194}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass9(
    startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-300},{180,-280}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y17(y=hea2.staB.T)
    annotation (Placement(transformation(extent={{40,-290},{140,-270}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y18(y=hea5.staB.T)
    annotation (Placement(transformation(extent={{40,-310},{140,-290}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass10(
     startTime=0.3,
    threShold=0.05)
    annotation (Placement(transformation(extent={{160,-260},{180,-240}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y19(y=hea4.staA.T)
    annotation (Placement(transformation(extent={{40,-250},{140,-230}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y20(y=hea7.staA.T)
    annotation (Placement(transformation(extent={{40,-270},{140,-250}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass11(
    threShold=1E-2,
    startTime=0.3)
    annotation (Placement(transformation(extent={{340,140},{360,160}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y21(y=hea2.staB.X[1])
    annotation (Placement(transformation(extent={{220,150},{320,170}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y22(y=hea1.staB.X[1])
    annotation (Placement(transformation(extent={{220,130},{320,150}}, rotation=
           0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass12(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,100},{360,120}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y23(
                                            y=hea2.staA.X[1])
    annotation (Placement(transformation(extent={{220,110},{320,130}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y24(
                                            y=hea1.staA.X[1])
    annotation (Placement(transformation(extent={{220,90},{320,110}}, rotation=
            0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass13(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,38},{360,58}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y25(
                                            y=hea4.staB.X[1])
    annotation (Placement(transformation(extent={{220,48},{320,68}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y26(
                                            y=hea3.staB.X[1])
    annotation (Placement(transformation(extent={{220,28},{320,48}}, rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass14(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-2},{360,18}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y27(
                                            y=hea4.staA.X[1])
    annotation (Placement(transformation(extent={{220,8},{320,28}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression y28(
                                            y=hea3.staA.X[1])
    annotation (Placement(transformation(extent={{220,-12},{320,8}}, rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass15(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-62},{360,-42}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y29(
                                            y=hea6.staB.X[1])
    annotation (Placement(transformation(extent={{220,-52},{320,-32}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y30(
                                            y=hea5.staB.X[1])
    annotation (Placement(transformation(extent={{220,-72},{320,-52}}, rotation=
           0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass16(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-102},{360,-82}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y31(
                                            y=hea6.staA.X[1])
    annotation (Placement(transformation(extent={{220,-92},{320,-72}}, rotation=
           0)));
  Modelica.Blocks.Sources.RealExpression y32(
                                            y=hea5.staA.X[1])
    annotation (Placement(transformation(extent={{220,-112},{320,-92}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass17(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-164},{360,-144}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y33(
                                            y=hea8.staB.X[1])
    annotation (Placement(transformation(extent={{220,-154},{320,-134}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y34(
                                            y=hea7.staB.X[1])
    annotation (Placement(transformation(extent={{220,-174},{320,-154}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass18(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-204},{360,-184}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y35(
                                            y=hea8.staA.X[1])
    annotation (Placement(transformation(extent={{220,-194},{320,-174}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y36(
                                            y=hea7.staA.X[1])
    annotation (Placement(transformation(extent={{220,-214},{320,-194}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass19(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-300},{360,-280}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y37(y=hea2.staB.X[1])
    annotation (Placement(transformation(extent={{220,-290},{320,-270}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y38(y=hea5.staB.X[1])
    annotation (Placement(transformation(extent={{220,-310},{320,-290}},
          rotation=0)));
  Annex60.Utilities.Diagnostics.AssertEquality ass20(threShold=1E-2, startTime=
        0.3)
    annotation (Placement(transformation(extent={{340,-260},{360,-240}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y39(y=hea4.staA.X[1])
    annotation (Placement(transformation(extent={{220,-250},{320,-230}},
          rotation=0)));
  Modelica.Blocks.Sources.RealExpression y40(y=hea7.staA.X[1])
    annotation (Placement(transformation(extent={{220,-270},{320,-250}},
          rotation=0)));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-180,-300},{-160,-280}})));
protected
  model Humidifier
    "Model for humidifier that adds a variable for the thermodynamic states at its ports"
    extends Annex60.Fluid.MassExchangers.HumidifierPrescribed;
   Medium.ThermodynamicState staA=
      Medium.setState_phX(port_a.p,
                          actualStream(port_a.h_outflow),
                          actualStream(port_a.Xi_outflow))
      "Thermodynamic state in port a";
   Medium.ThermodynamicState staB=
      Medium.setState_phX(port_b.p,
                          actualStream(port_b.h_outflow),
                          actualStream(port_b.Xi_outflow))
      "Thermodynamic state in port b";
  end Humidifier;
equation
  connect(POut.y,sin_1. p_in) annotation (Line(
      points={{-179,150},{-174.5,150},{-174.5,152},{-170,152}},
      color={0,0,127},
      pattern=LinePattern.None));
  connect(TDb.y,sou_1. T_in) annotation (Line(
      points={{-179,102},{-174.5,102},{-174.5,106},{-170,106}},
      color={0,0,127},
      pattern=LinePattern.None));
  connect(res_11.port_b, hea1.port_a)
                                     annotation (Line(points={{-80,102},{-54,
          102}}, color={0,127,255}));
  connect(u.y, hea1.u)
                      annotation (Line(points={{-127,184},{-64,184},{-64,108},{
          -56,108}}, color={0,0,127}));
  connect(gain.y, hea2.u) annotation (Line(points={{-29,184},{-22,184},{-22,150},
          {-14,150}}, color={0,0,127}));
  connect(u.y, gain.u) annotation (Line(points={{-127,184},{-52,184}}, color={0,
          0,127}));
  connect(res_12.port_b, hea2.port_a) annotation (Line(points={{-80,144},{-12,
          144}}, color={0,127,255}));
  connect(res_2.port_b, hea3.port_a) annotation (Line(points={{-80,22},{-54,22}},
        color={0,127,255}));
  connect(u.y, hea3.u)
                      annotation (Line(points={{-127,184},{-64,184},{-64,28},{
          -56,28}}, color={0,0,127}));
  connect(gain.y, hea4.u) annotation (Line(points={{-29,184},{-22,184},{-22,70},
          {-14,70}}, color={0,0,127}));
  connect(res_3.port_b, hea4.port_a) annotation (Line(points={{-80,64},{-12,64}},
        color={0,127,255}));
  connect(hea4.port_b, res_4.port_b) annotation (Line(points={{8,64},{20,64},{
          20,50}}, color={0,127,255}));
  connect(hea1.port_b, hea2.port_b) annotation (Line(points={{-34,102},{20,102},
          {20,144},{8,144}}, color={0,127,255}));
  connect(y1.y, ass1.u1) annotation (Line(points={{145,160},{154,160},{154,156},
          {158,156}}, color={0,0,127}));
  connect(y2.y, ass1.u2) annotation (Line(points={{145,140},{152,140},{152,144},
          {158,144}}, color={0,0,127}));
  connect(y3.y, ass2.u1) annotation (Line(points={{145,120},{154,120},{154,116},
          {158,116}}, color={0,0,127}));
  connect(y4.y, ass2.u2) annotation (Line(points={{145,100},{152,100},{152,104},
          {158,104}}, color={0,0,127}));
  connect(y5.y, ass3.u1) annotation (Line(points={{145,58},{154,58},{154,54},{
          158,54}}, color={0,0,127}));
  connect(y6.y, ass3.u2) annotation (Line(points={{145,38},{152,38},{152,42},{
          158,42}}, color={0,0,127}));
  connect(y7.y, ass4.u1) annotation (Line(points={{145,18},{154,18},{154,14},{
          158,14}}, color={0,0,127}));
  connect(y8.y, ass4.u2) annotation (Line(points={{145,-2},{152,-2},{152,2},{
          158,2}}, color={0,0,127}));
  connect(res_1.port_b, hea5.port_a) annotation (Line(points={{-80,-100},{-54,
          -100}}, color={0,127,255}));
  connect(res_5.port_b, hea6.port_a)  annotation (Line(points={{-80,-58},{-12,
          -58}}, color={0,127,255}));
  connect(res_6.port_b,hea7. port_a) annotation (Line(points={{-80,-180},{-54,
          -180}}, color={0,127,255}));
  connect(res_7.port_b,hea8. port_a) annotation (Line(points={{-80,-138},{-12,
          -138}}, color={0,127,255}));
  connect(hea8.port_b,res_8. port_b) annotation (Line(points={{8,-138},{20,-138},
          {20,-152}}, color={0,127,255}));
  connect(hea5.port_b,hea6. port_b) annotation (Line(points={{-34,-100},{20,
          -100},{20,-58},{8,-58}}, color={0,127,255}));
  connect(y9.y,ass5. u1) annotation (Line(points={{145,-40},{154,-40},{154,-46},
          {158,-46}}, color={0,0,127}));
  connect(y10.y, ass5.u2)
                         annotation (Line(points={{145,-62},{152,-62},{152,-58},
          {158,-58}}, color={0,0,127}));
  connect(y11.y, ass6.u1)
                         annotation (Line(points={{145,-82},{154,-82},{154,-86},
          {158,-86}}, color={0,0,127}));
  connect(y12.y, ass6.u2)
                         annotation (Line(points={{145,-102},{152,-102},{152,
          -98},{158,-98}}, color={0,0,127}));
  connect(y13.y, ass7.u1)
                         annotation (Line(points={{145,-144},{154,-144},{154,
          -148},{158,-148}}, color={0,0,127}));
  connect(y14.y, ass7.u2)
                         annotation (Line(points={{145,-164},{152,-164},{152,
          -160},{158,-160}}, color={0,0,127}));
  connect(y15.y, ass8.u1)
                         annotation (Line(points={{145,-184},{154,-184},{154,
          -188},{158,-188}}, color={0,0,127}));
  connect(y16.y, ass8.u2)
                         annotation (Line(points={{145,-204},{152,-204},{152,
          -200},{158,-200}}, color={0,0,127}));
  connect(y17.y,ass9. u1)
                         annotation (Line(points={{145,-280},{154,-280},{154,
          -284},{158,-284}}, color={0,0,127}));
  connect(y18.y,ass9. u2)
                         annotation (Line(points={{145,-300},{152,-300},{152,
          -296},{158,-296}}, color={0,0,127}));
  connect(y19.y, ass10.u1)
                         annotation (Line(points={{145,-240},{154,-240},{154,
          -244},{158,-244}}, color={0,0,127}));
  connect(y20.y, ass10.u2)
                         annotation (Line(points={{145,-260},{152,-260},{152,
          -256},{158,-256}}, color={0,0,127}));
  connect(u.y, hea6.u) annotation (Line(points={{-127,184},{-70,184},{-70,-52},
          {-14,-52}}, color={0,0,127}));
  connect(u.y, hea8.u) annotation (Line(points={{-127,184},{-70,184},{-70,-132},
          {-14,-132}}, color={0,0,127}));
  connect(gain.y, hea5.u) annotation (Line(points={{-29,184},{-26,184},{-26,-80},
          {-60,-80},{-60,-94},{-56,-94}}, color={0,0,127}));
  connect(gain.y, hea7.u) annotation (Line(points={{-29,184},{-26,184},{-26,
          -160},{-64,-160},{-64,-174},{-56,-174}}, color={0,0,127}));
  connect(y21.y, ass11.u1)
                         annotation (Line(points={{325,160},{334,160},{334,156},
          {338,156}}, color={0,0,127}));
  connect(y22.y, ass11.u2)
                         annotation (Line(points={{325,140},{332,140},{332,144},
          {338,144}}, color={0,0,127}));
  connect(y23.y, ass12.u1)
                         annotation (Line(points={{325,120},{334,120},{334,116},
          {338,116}}, color={0,0,127}));
  connect(y24.y, ass12.u2)
                         annotation (Line(points={{325,100},{332,100},{332,104},
          {338,104}}, color={0,0,127}));
  connect(y25.y, ass13.u1)
                         annotation (Line(points={{325,58},{334,58},{334,54},{
          338,54}}, color={0,0,127}));
  connect(y26.y, ass13.u2)
                         annotation (Line(points={{325,38},{332,38},{332,42},{
          338,42}}, color={0,0,127}));
  connect(y27.y, ass14.u1)
                         annotation (Line(points={{325,18},{334,18},{334,14},{
          338,14}}, color={0,0,127}));
  connect(y28.y, ass14.u2)
                         annotation (Line(points={{325,-2},{332,-2},{332,2},{
          338,2}}, color={0,0,127}));
  connect(y29.y, ass15.u1)
                         annotation (Line(points={{325,-42},{334,-42},{334,-46},
          {338,-46}}, color={0,0,127}));
  connect(y30.y, ass15.u2)
                         annotation (Line(points={{325,-62},{332,-62},{332,-58},
          {338,-58}}, color={0,0,127}));
  connect(y31.y, ass16.u1)
                         annotation (Line(points={{325,-82},{334,-82},{334,-86},
          {338,-86}}, color={0,0,127}));
  connect(y32.y, ass16.u2)
                         annotation (Line(points={{325,-102},{332,-102},{332,
          -98},{338,-98}}, color={0,0,127}));
  connect(y33.y, ass17.u1)
                         annotation (Line(points={{325,-144},{334,-144},{334,
          -148},{338,-148}}, color={0,0,127}));
  connect(y34.y, ass17.u2)
                         annotation (Line(points={{325,-164},{332,-164},{332,
          -160},{338,-160}}, color={0,0,127}));
  connect(y35.y, ass18.u1)
                         annotation (Line(points={{325,-184},{334,-184},{334,
          -188},{338,-188}}, color={0,0,127}));
  connect(y36.y, ass18.u2)
                         annotation (Line(points={{325,-204},{332,-204},{332,
          -200},{338,-200}}, color={0,0,127}));
  connect(y37.y, ass19.u1)
                         annotation (Line(points={{325,-280},{334,-280},{334,
          -284},{338,-284}}, color={0,0,127}));
  connect(y38.y, ass19.u2)
                         annotation (Line(points={{325,-300},{332,-300},{332,
          -296},{338,-296}}, color={0,0,127}));
  connect(y39.y, ass20.u1)
                         annotation (Line(points={{325,-240},{334,-240},{334,
          -244},{338,-244}}, color={0,0,127}));
  connect(y40.y, ass20.u2)
                         annotation (Line(points={{325,-260},{332,-260},{332,
          -256},{338,-256}}, color={0,0,127}));
  connect(sin_1.ports[1], res_12.port_a) annotation (Line(
      points={{-148,147},{-106,147},{-106,144},{-100,144}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sin_1.ports[2], res_3.port_a) annotation (Line(
      points={{-148,145},{-124,145},{-124,64},{-100,64}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_1.ports[1], res_11.port_a) annotation (Line(
      points={{-148,105},{-107,105},{-107,102},{-100,102}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_1.ports[2], res_2.port_a) annotation (Line(
      points={{-148,103},{-126,103},{-126,22},{-100,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sin_1.ports[3], res_1.port_a) annotation (Line(
      points={{-148,143},{-130,143},{-130,-100},{-100,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sin_1.ports[4], res_6.port_a) annotation (Line(
      points={{-148,141},{-132,141},{-132,-180},{-100,-180}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_1.ports[3], res_5.port_a) annotation (Line(
      points={{-148,101},{-140,101},{-140,-58},{-100,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_1.ports[4], res_7.port_a) annotation (Line(
      points={{-148,99},{-142,99},{-142,-138},{-100,-138}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hea3.port_b, mix1.ports[1]) annotation (Line(
      points={{-34,22},{-12,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mix1.ports[2], res_4.port_a) annotation (Line(
      points={{-8,22},{20,22},{20,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hea7.port_b, mix2.ports[1]) annotation (Line(
      points={{-34,-180},{-12,-180}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mix2.ports[2], res_8.port_a) annotation (Line(
      points={{-8,-180},{20,-180},{20,-172}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-200,
            -320},{360,200}}), graphics={
        Text(
          extent={{30,204},{158,162}},
          lineColor={0,0,255},
          textString="Asserts for temperture check"),
        Text(
          extent={{210,204},{338,162}},
          lineColor={0,0,255},
          textString="Asserts for humidity check"),
        Text(
          extent={{-198,-4},{-6,-38}},
          lineColor={0,0,255},
          textString="Same models as above, but flow is reversed")}),
experiment(StopTime=3600),
__Dymola_Commands(file="modelica://Annex60/Resources/Scripts/Dymola/Fluid/Interfaces/Examples/HumidifierPrescribed.mos"
        "Simulate and plot"),
Documentation(info="<html>
<p>
Model that tests the basic class that is used for the humidifier model.
It adds and removes water for forward and reverse flow.
The top and bottom models should give similar results, although 
the sign of the humidity difference over the components differ
because of the reverse flow.
The model uses assert statements that will be triggered if
results that are expected to be close to each other differ by more
than a prescribed threshold.</p>
</html>",
revisions="<html>
<ul>
<li>
May 30, 2014, by Michael Wetter:<br/>
Changed initialization of mass dynamics to avoid overspecified system
of equations if the medium model is incompressible.
</li>
<li>
October 9, 2013, by Michael Wetter:<br/>
Introduced protected model <code>Humidifier</code> so that states at
the fluid ports can be computed without having to use a conditionally
removed variable. This is required for the model to pass the model check in 
Dymola 2014 FD01 beta3 with <code>Advanced.PedanticModelica=true;</code>.
</li>
<li>
January 24, 2013, by Michael Wetter:<br/>
Set initial conditions to 
<code>Modelica.Fluid.Types.Dynamics.FixedInitial</code>.
</li>
<li>
July 11, 2011, by Michael Wetter:<br/>
Moved model to <code>Annex60.Fluid.Interfaces.Examples</code>.
</li>
<li>
April 18, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end HumidifierPrescribed;
