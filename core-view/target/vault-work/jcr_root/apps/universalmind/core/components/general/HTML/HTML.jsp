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

<%--

  HTML component.

  HTML component that allows for free text html on a page

--%>
<%@include file="../../global.jsp"%>
<%@page session="false" %><%
%><%
    String  html  =  properties.get("html",  "");
    String  cssClass =  properties.get("cssClass",  "");
    String  cssStyle  =  properties.get("cssStyle",  "");

    // 1st default edit mode
    if( html.length() == 0 )
    {
        html = "{HTML}";
        cssStyle += "min-height:100px";
    }
%>
<div class="<%=cssClass%>" style="<%=cssStyle%>"><%= html %></div>