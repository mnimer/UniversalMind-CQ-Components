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

<!-- twitter bootstrap hero unit -->
<%@include file="../../global.jsp"%>
<%@page session="false" %>
<%--cq:includeClientLib css="universalmind.bootstrap" /--%>
<div class="hero-unit <%= properties.get("cssClass", "")%>" style="<%= properties.get("cssClass", "")%>">

    <% if (properties.get("heading") != null ){ %>
        <h1><%= properties.get("heading")%></h1>
    <%}%>

    <% if (properties.get("tagline") != null ){ %>
        <p><%= properties.get("tagline")%></p>
    <%}%>

    <% if( properties.get("cq:isContainer", false) ) { %>
        <cq:include path="nestHeroContent" resourceType="foundation/components/parsys"/>
    <%}%>
</div>