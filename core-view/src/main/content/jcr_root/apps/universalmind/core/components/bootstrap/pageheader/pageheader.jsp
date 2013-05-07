<%@ page import="com.day.cq.wcm.api.WCMMode" %>
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
    String _largeText = "";
    String _largeSubText = "";
    String _mediumText = "";
    String _mediumSubText = "";
    String _smallText = "";
    String _smallSubText = "";
    String cssStyle = properties.get("cssStyle", "");
    String cssClass = properties.get("cssClass", "");
    String largeText = properties.get("largeText", String.class);
    String largeSubText = properties.get("largeSubText", String.class);
    String mediumText = properties.get("mediumText", String.class);
    String mediumSubText = properties.get("mediumSubText", String.class);
    String smallText = properties.get("smallText", String.class);
    String smallSubText = properties.get("smallSubText", String.class);

    if (largeText != null )
    {
        _largeText = largeText;
    }
    if (largeSubText != null )
    {
        _largeSubText = largeSubText;
    }
    // default the other two, to the large in case they are null
    mediumText = _largeText;
    smallText = _largeText;

    if (mediumText != null )
    {
        _mediumText = mediumText;
    }
    if (mediumSubText != null )
    {
        _mediumSubText = mediumSubText;
    }
    if (smallText != null )
    {
        _smallText = smallText;
    }
    if (smallSubText != null )
    {
        _smallSubText = smallSubText;
    }

    if( WCMMode.fromRequest(request) == WCMMode.EDIT )
    {
        cssStyle += "min-height:50px;";

        if( _largeText.length() == 0 )
        {
            _largeText = "{HEADER}";
        }
        if( _mediumText.length() == 0 )
        {
            _mediumText = "{HEADER}";
        }
        if( _smallText.length() == 0 )
        {
            _smallText = "{HEADER}";
        }
    }
%>


<div class="page-header visible-desktop <%=cssClass%>" style="<%=cssStyle%>">
    <h1><%=_largeText%> <small><%=_largeSubText%></small></h1>
</div>
<div class="page-header visible-tablet <%=cssClass%>" style="<%=cssStyle%>">
    <h1><%=_mediumText%> <small><%=_mediumSubText%></small></h1>
</div>
<div class="page-header visible-phone <%=cssClass%>" style="<%=cssStyle%>">
    <h1><%=_smallText%> <small><%=_smallSubText%></small></h1>
</div>

