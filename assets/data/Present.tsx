<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.2" tiledversion="1.2.1" name="Present" tilewidth="32" tileheight="32" tilecount="105" columns="15">
 <image source="../images/Present.png" width="480" height="224"/>
 <terraintypes>
  <terrain name="Terreno Helado" tile="2"/>
  <terrain name="Puente" tile="35"/>
 </terraintypes>
 <tile id="0" terrain="0,0,0,0"/>
 <tile id="1" terrain=",0,,0">
  <properties>
   <property name="walljump" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="2" terrain="0,,0,">
  <properties>
   <property name="walljump" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="3" terrain=",,0,0"/>
 <tile id="4" terrain=",,0,0"/>
 <tile id="5">
  <properties>
   <property name="facing" value="sw"/>
   <property name="slope" value="gt"/>
  </properties>
 </tile>
 <tile id="6">
  <properties>
   <property name="facing" value="sw"/>
   <property name="slope" value="gT"/>
  </properties>
 </tile>
 <tile id="7">
  <properties>
   <property name="facing" value="se"/>
   <property name="slope" value="gT"/>
  </properties>
 </tile>
 <tile id="8">
  <properties>
   <property name="facing" value="se"/>
   <property name="slope" value="gt"/>
  </properties>
 </tile>
 <tile id="9">
  <properties>
   <property name="facing" value="ne"/>
   <property name="slope" value="st"/>
  </properties>
 </tile>
 <tile id="10">
  <properties>
   <property name="facing" value="sw"/>
   <property name="slope" value="sT"/>
  </properties>
 </tile>
 <tile id="11">
  <properties>
   <property name="facing" value="se"/>
   <property name="slope" value="sT"/>
  </properties>
 </tile>
 <tile id="12">
  <properties>
   <property name="facing" value="nw"/>
   <property name="slope" value="st"/>
  </properties>
 </tile>
 <tile id="13" terrain=",0,,">
  <properties>
   <property name="facing" value="sw"/>
  </properties>
 </tile>
 <tile id="14" terrain="0,,,">
  <properties>
   <property name="facing" value="se"/>
  </properties>
 </tile>
 <tile id="15" terrain="0,0,0,0"/>
 <tile id="16" terrain=",0,,0">
  <properties>
   <property name="walljump" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="17" terrain="0,,0,">
  <properties>
   <property name="walljump" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="18" terrain="0,0,,"/>
 <tile id="19" terrain="0,0,,"/>
 <tile id="20">
  <properties>
   <property name="facing" value="ne"/>
   <property name="slope" value="gT"/>
  </properties>
 </tile>
 <tile id="21">
  <properties>
   <property name="facing" value="ne"/>
   <property name="slope" value="gt"/>
  </properties>
 </tile>
 <tile id="22">
  <properties>
   <property name="facing" value="nw"/>
   <property name="slope" value="gt"/>
  </properties>
 </tile>
 <tile id="23">
  <properties>
   <property name="facing" value="nw"/>
   <property name="slope" value="gT"/>
  </properties>
 </tile>
 <tile id="24">
  <properties>
   <property name="facing" value="ne"/>
   <property name="slope" value="sT"/>
  </properties>
 </tile>
 <tile id="25">
  <properties>
   <property name="facing" value="sw"/>
   <property name="slope" value="st"/>
  </properties>
 </tile>
 <tile id="26">
  <properties>
   <property name="facing" value="se"/>
   <property name="slope" value="st"/>
  </properties>
 </tile>
 <tile id="27">
  <properties>
   <property name="facing" value="nw"/>
   <property name="slope" value="sT"/>
  </properties>
 </tile>
 <tile id="28" terrain=",,,0">
  <properties>
   <property name="facing" value="nw"/>
  </properties>
 </tile>
 <tile id="29" terrain=",,0,">
  <properties>
   <property name="facing" value="ne"/>
  </properties>
 </tile>
 <tile id="30" terrain="0,,0,0"/>
 <tile id="31" terrain=",0,0,0"/>
 <tile id="32" terrain="0,0,0,"/>
 <tile id="33" terrain="0,0,,0"/>
 <tile id="34" terrain=",1,,1">
  <properties>
   <property name="cloud" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="35" terrain="1,1,1,1">
  <properties>
   <property name="cloud" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="36" terrain="1,,1,">
  <properties>
   <property name="cloud" type="bool" value="true"/>
  </properties>
 </tile>
</tileset>
