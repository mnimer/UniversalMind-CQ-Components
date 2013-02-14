<%@include file="../../global.jsp"%>
<cq:includeClientLib css="universalmind.bootstrap" />
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
    String[]  columns  =  properties.get("columns", String[].class);
    if( columns == null )
    {
        columns = new String[]{"12"};
    }
    if( columns.length == 1 )
    {
        // double-check a special edge case the use entered a comma-separated list in the 1st field, instead of using the multifield editor.
        columns = columns[0].split(",");
    }

%>

<div class="row-fluid <%=properties.get("cssClass", "")%>" style="<%=properties.get("cssStyle", "")%>" role="<%=properties.get("role", "")%>">

    <% for(int i=0; i< columns.length; i++) {
           String[] colSplit = columns[i].trim().split(":");
           String span = "12";
           String offset = "0";
           if( colSplit.length == 2 )
           {
               span = colSplit[0].trim();
               offset = colSplit[1].trim();
           }else{
               span = colSplit[0].trim();
           }
    %>
    <% if( offset.equals("0") ) { %>
        <div class="<%=" span" + span%>" style="margin-left: 0px;">
    <% } else { %>
            <div class="<%=" span" + span%>  <%=" offset" + offset%>" >
    <% } %>
            <cq:include path="<%="cell_" + i%>" resourceType="foundation/components/parsys"/>
        </div>
    <% } %>

</div>