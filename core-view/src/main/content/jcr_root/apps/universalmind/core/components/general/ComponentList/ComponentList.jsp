<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@include file="../../global.jsp"%>
<%@ page session="false" %>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<cq:defineObjects/>
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
<%
    Integer listSize = properties.get("listSize", 1);
    String _cssClass = properties.get("cssClass", "component-list");
    String _cssStyle = properties.get("cssStyle", " ");

    // 1st default edit mode
    if( WCMMode.fromRequest(request) == WCMMode.EDIT )
    {
        _cssStyle += "min-height:100px; min-width:100px;";
    }
%>


<ul class="<%=_cssClass%>" style="<%=_cssStyle%>" data-list="<%=listSize%>">
<!-- start -->
    <% for(int i=0; i< listSize; i++) { %>
    <li><cq:include path="<%="container_" + i%>" resourceType="foundation/components/parsys"/></li>
    <% } %>
<!-- end -->
</ul>