<%--
  ~ Copyright 2012 Mike Nimer & Universal Mind
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~    Unless required by applicable law or agreed to in writing, software
  ~    distributed under the License is distributed on an "AS IS" BASIS,
  ~    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~    See the License for the specific language governing permissions and
  ~    limitations under the License.
  --%>

<!-- TODO add support for http://lorempixel.com/ -->

<%@include file="../../global.jsp"%>
<%@page session="false" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>

<%
    String  width  =  properties.get("width",  "200");
    String  height  =  properties.get("height",  "200");   
    String  imageService  =  properties.get("imageservice",  "lorempixel.com");
    String  colorType  =  "black & white";//properties.get("colorType",  "black & white");  
    String  tooltip  =  properties.get("tooltip",  "");


    tooltip = xssAPI.filterHTML("(" +width +"px X " +height +"px ) " +tooltip);
%>

<div class="placeholder" style="max-width:<%=width%>px; height:auto;">
<% if( imageService.equalsIgnoreCase("placehold.it") ){ %>
    <img src="http://www.placehold.it/<%=width%>x<%=height%>" alt="<%=tooltip%>"/>

<%} else if( imageService.equalsIgnoreCase("lorempixel.com")){ %>
    <img src="http://lorempixel.com/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>

<%} else if( imageService.equalsIgnoreCase("dummyimage.com")){ %>
    <img src="http://dummyimage.com/<%=width%>x<%=height%>&text=<%=tooltip%>" alt="<%=tooltip%>"/>

<%} else if( imageService.equalsIgnoreCase("baconmockup.com")){ %>
    <img src="http://baconmockup.com/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>

<%} else if( imageService.equalsIgnoreCase("hhhhold.com")){ %>
    <img src="http://hhhhold.com/<%=width%>x<%=height%>" alt="<%=tooltip%>"/>


<%} else if( imageService.equalsIgnoreCase("placebear.com") && colorType.equalsIgnoreCase("black & white") ){ %>
    <img src="http://placebear.com/g/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>
<%} else if( imageService.equalsIgnoreCase("placebear.com") && colorType.equalsIgnoreCase("color") ){ %>
    <img src="http://placebear.com/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>

<%} else if( imageService.equalsIgnoreCase("placekitten.com") && colorType.equalsIgnoreCase("black & white") ){ %>
    <img src="http://placekitten.com/g/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>
<%} else if( imageService.equalsIgnoreCase("placekitten.com") && colorType.equalsIgnoreCase("color") ){ %>
    <img src="http://placekitten.com/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>

<%} else if( imageService.equalsIgnoreCase("placedog.com") && colorType.equalsIgnoreCase("black & white") ){ %>
    <img src="http://placedog.com/g/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>
<%} else if( imageService.equalsIgnoreCase("placedog.com") && colorType.equalsIgnoreCase("color") ){ %>
    <img src="http://placedog.com/<%=width%>/<%=height%>" alt="<%=tooltip%>"/>

<% } %>
</div>