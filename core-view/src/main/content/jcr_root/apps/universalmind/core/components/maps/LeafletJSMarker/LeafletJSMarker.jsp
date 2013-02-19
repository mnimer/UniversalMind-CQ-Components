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
<%@page session="false" %>
<%
    String _markerLat = properties.get("markerLat", "43.834");
    String _markerLng = properties.get("markerLng", "-31.464");
    String _popupHtml = properties.get("popupHtml", String.class);

%>
<script type="text/javascript">
    var m<%=currentNode.getIdentifier().hashCode()%> = L.marker([<%=_markerLat%>,<%=_markerLng%>]).addTo(map);
    <% if( _popupHtml != null ){%>
        m<%=currentNode.getIdentifier().hashCode()%>.bindPopup("<%=_popupHtml%>");
    <%}%>
</script>

