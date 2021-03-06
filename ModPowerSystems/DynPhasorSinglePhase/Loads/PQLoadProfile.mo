within ModPowerSystems.DynPhasorSinglePhase.Loads;
model PQLoadProfile
  "Constant power load changing according to absolute P and Q profile"
  extends ModPowerSystems.Base.Interfaces.ComplexPhasor.SinglePhase.OnePortGroundedInit;

  parameter String profileFileName = "NoName" "File where matrix is stored"
    annotation (Dialog(
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  parameter String profileName = "NoName" "Table name on file";
  parameter Boolean enableOutputPload = false  annotation (Dialog(group="Data in/out"),choices(checkBox=true));

  parameter Modelica.Blocks.Types.Smoothness smoothnessSetting=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation";

  SI.ActivePower Pref=LoadProfile.y[1] "active power reference";
  SI.ReactivePower Qref=LoadProfile.y[2] "reactive power reference";


   Modelica.Blocks.Sources.CombiTimeTable LoadProfile(
    tableOnFile=true,
    tableName=profileName,
    fileName=profileFileName,
    table = fill(0.0, 0, 3),
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    smoothness= smoothnessSetting);

  Modelica.Blocks.Interfaces.RealOutput P_loadOut=P if enableOutputPload
    annotation (Placement(transformation(extent={{60,-20},{100,20}}),
        iconTransformation(extent={{46,-20},{76,10}})));
equation
  P = Pref;
  Q = Qref;

annotation (Documentation(info="<html>
<p>
This load model should not be used in transient mode yet.
</p>

</html>"),
   Icon(
     coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}),
      graphics={
        Line(
          points={{0,100},{0,20}},
          color={0,0,0}),
        Polygon(
          points={{0,-40},{-20,20},{20,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,0}),
        Text(
          extent={{-100,-100},{100,-60}},
          textString="%name",
          lineColor={0,0,0})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end PQLoadProfile;
