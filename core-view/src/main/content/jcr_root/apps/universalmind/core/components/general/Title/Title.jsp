<%@include file="../../global.jsp"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils,
        com.day.cq.commons.Doctype,
        com.day.cq.commons.DiffInfo,
        com.day.cq.commons.DiffService,
        org.apache.sling.api.resource.ResourceUtil,
        com.day.cq.wcm.api.NameConstants" %>

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
    // first calculate the correct title - look for our sources if not set in paragraph
    String title = properties.get("title", String.class);
    if (title == null || title.equals("")) {
        title = resourcePage.getPageTitle();
    }
    if (title == null || title.equals("")) {
        title = resourcePage.getTitle();
    }
    if (title == null || title.equals("")) {
        title = resourcePage.getName();
    }

    // escape title
    title = xssAPI.filterHTML(title);
    String titleSize = properties.get("titleSize", String.class);
    String cssClass = properties.get("cssClass", String.class);
    String cssStyle = properties.get("cssStyle", String.class);


    // check if we need to compute a diff
    String diffOutput = null;
    DiffInfo diffInfo = resource.adaptTo(DiffInfo.class);
    if (diffInfo != null) {
        DiffService diffService = sling.getService(DiffService.class);
        ValueMap map = ResourceUtil.getValueMap(diffInfo.getContent());
        String diffText = map.get(NameConstants.PN_TITLE, "");
        // if the paragraph has no own title, we use the current page title(!)
        if (diffText == null || diffText.equals("")) {
            diffText = title;
        } else {
            diffText = xssAPI.filterHTML(diffText);
        }
        diffOutput = diffInfo.getDiffOutput(diffService, title, diffText, false);
        if (title.equals(diffOutput)) {
            diffOutput = null;
        }
    }

%>

<div class="<%=cssClass%>" style="<%=cssStyle%> border:1px solid; height:50px;" role="heading">
    <% if (diffOutput == null) { %>
        <<%=titleSize%>><%= title %></<%=titleSize%>>
    <% } else { %>
        <<%=titleSize%>><%= diffOutput %></<%=titleSize%>>
    <% } %>
</div>