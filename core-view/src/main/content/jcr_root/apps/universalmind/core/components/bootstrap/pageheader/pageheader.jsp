<%@include file="../../global.jsp"%>
<%@page session="false" %>
<%--cq:includeClientLib css="universalmind.bootstrap" /--%>
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

<!--
http://www.splatf.com/2013/01/responsive-design-text/
-->

<%
    String largeText = "";
    String largeSubText = "";
    String mediumText = "";
    String mediumSubText = "";
    String smallText = "";
    String smallSubText = "";

    if (properties.get("largeText") != null )
    {
        largeText = (String)properties.get("largeText");
    }
    if (properties.get("largeSubText") != null )
    {
        largeSubText = (String)properties.get("largeSubText");
    }
    // default the other two, to the large in case they are null
    mediumText = largeText;
    smallText = largeText;

    if (properties.get("mediumText") != null )
    {
        mediumText = (String)properties.get("mediumText");
    }
    if (properties.get("mediumSubText") != null )
    {
        mediumSubText = (String)properties.get("mediumSubText");
    }
    if (properties.get("smallText") != null )
    {
        smallText = (String)properties.get("smallText");
    }
    if (properties.get("smallSubText") != null )
    {
        smallSubText = (String)properties.get("smallSubText");
    }
%>


<div class="page-header visible-desktop <%=properties.get("cssClass", "")%>" style="<%=properties.get("cssStyle", "")%>">
    <h1><%=largeText%> <small><%=largeSubText%></small></h1>
</div>
<div class="page-header visible-tablet <%=properties.get("cssClass", "")%>" style="<%=properties.get("cssStyle", "")%>">
    <h1><%=mediumText%> <small><%=mediumSubText%></small></h1>
</div>
<div class="page-header visible-phone <%=properties.get("cssClass", "")%>" style="<%=properties.get("cssStyle", "")%>">
    <h1><%=smallText%> <small><%=smallSubText%></small></h1>
</div>

