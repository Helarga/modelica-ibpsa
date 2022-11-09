within IBPSA.BoundaryConditions.SolarIrradiation;
block GlobalTiltedSurfacePerez
  "Global solar irradiation on a tilted surface with diffuse irradiation calculation following Perez"
  extends
    IBPSA.BoundaryConditions.SolarIrradiation.BaseClasses.PartialSolarIrradiation;
  parameter Modelica.Units.SI.Angle azi "Surface azimuth";
  parameter Real rho=0.2 "Ground reflectance";
  parameter Boolean outSkyCon=false
    "Output contribution of diffuse irradiation from sky";
  parameter Boolean outGroCon=false
    "Output contribution of diffuse irradiation from ground";
  DiffusePerez HDifTil(
    til=til,
    rho=rho,
    azi=azi,
    outSkyCon=outSkyCon,
    outGroCon=outGroCon)
    annotation (Placement(transformation(extent={{-40,20},{0,60}})));
  DirectTiltedSurface HDirTil(til=til, azi=azi)
    annotation (Placement(transformation(extent={{-40,-60},{0,-20}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

equation
  connect(weaBus, HDifTil.weaBus) annotation (Line(
      points={{-100,0},{-100,40},{-40,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus, HDirTil.weaBus) annotation (Line(
      points={{-100,0},{-100,-40},{-40,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(HDifTil.H, add.u1) annotation (Line(points={{2,40},{26,40},{26,6},{38,
          6}},            color={0,0,127}));
  connect(HDirTil.H, add.u2) annotation (Line(points={{2,-40},{26,-40},{26,-6},
          {38,-6}}, color={0,0,127}));
  connect(add.y, H) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This component computes the hemispherical direct and diffuse irradiation on a tilted surface and combines it to the global irradiation.</p>
<p>It uses an anisotropic sky model proposed by Perez for the diffuse irradiation computation. </p>
<p>For a definition of the parameters, see the User&apos;s Guide. </p>
</html>"));
end GlobalTiltedSurfacePerez;
