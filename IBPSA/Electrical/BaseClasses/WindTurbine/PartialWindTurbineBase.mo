within IBPSA.Electrical.BaseClasses.WindTurbine;
partial model PartialWindTurbineBase
  "Base class for turbine model that contains basic parameters"
  final parameter Modelica.Units.SI.Velocity vIn=table[1, 1]
    "Cut-in steady wind speed";
  final parameter Modelica.Units.SI.Velocity vOut=table[size(table, 1), 1]
    "Cut-out steady wind speed";
  parameter Real scale(min=0)=1
    "Scaling factor, used to allow adjusting the power output without changing the table";

  parameter Real h "Height over ground"
    annotation (Dialog(group="Wind correction"));
  parameter Modelica.Units.SI.Height hRef=10
    "Reference height for wind measurement"
    annotation (Dialog(group="Wind correction"));
 parameter Real nWin(min=0) = 0.4
    "Height exponent for wind profile calculation"
   annotation (Dialog(group="Wind correction"));

  parameter Boolean tableOnFile=false
    "true, if table is defined on file or in function usertab";
  parameter Real table[:,2]=
          [3.5, 0;
           5.5, 0.1;
           12, 0.9;
           14, 1;
           25, 1]
    "Table of generated power (first column is wind speed, second column is power)";
  parameter String tableName="NoName"
    "Table name on file or in function usertab (see documentation)";
  parameter String fileName="NoName" "File where matrix is stored";
  parameter Modelica.Units.SI.Voltage V_nominal(min=0, start=110)
    "Nominal voltage (V_nominal >= 0)"
    annotation (Evaluate=true, Dialog(group="Nominal conditions"));
  Modelica.Blocks.Interfaces.RealInput vWin(unit="m/s") "Steady wind speed"
     annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput P(unit="W") "Generated power"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  annotation (Documentation(info="<html>
<p>
This partial model contains the minimum set of parameters necessary to describe
a wind turbine.
The model defines also an output <code>P</code> for the power generated by the wind turbine.
</p>
</html>", revisions="<html>
<ul>
<li>
January 10, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    preferredView="info",
    Documentation(info =                           "<html>
<p>
This package contains base classes that are used model the WindTurbine models.
</p>
</html>"));
end PartialWindTurbineBase;
