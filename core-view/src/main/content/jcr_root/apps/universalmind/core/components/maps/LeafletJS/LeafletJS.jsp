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
<%@ page import="com.day.cq.wcm.api.WCMMode,
                 com.day.cq.wcm.api.components.Toolbar,
                 com.day.cq.i18n.I18n,
                 com.day.cq.wcm.foundation.Paragraph,
                 com.day.cq.commons.Doctype"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.sling.commons.json.JSONObject" %>
<cq:defineObjects/>
<cq:includeClientLib categories="cq.jquery" />
<%
    String _mapCenter = properties.get("mapCenter", "43.834 , -31.464");
    int _zoom = properties.get("zoom", 4);
    String _width = properties.get("width", "100%");
    String _height = properties.get("height", "300px");
    String _markerType = properties.get("markerType", "default");
    String[] _layers = properties.get("layers", String[].class);
    String[] _markers = properties.get("markers", String[].class);

    String _iconUrl = properties.get("iconPath", String.class);
    String _shadowUrl = properties.get("iconShadowPath", String.class);
    String _shadowSize = properties.get("shadowSize", String.class);
    String _shadowShadowSize = properties.get("shadowShadowSize", String.class);
    String _iconAnchor = properties.get("iconAnchor", String.class);
    String _iconShadowAnchor = properties.get("shadowAnchor", String.class);

    JSONObject iconOptions = new JSONObject();
    if( _markerType.equals("image") )
    {
        if( _iconUrl != null )
        {
            iconOptions.put("iconUrl", _iconUrl);
        }
        if( _shadowUrl != null )
        {
            iconOptions.put("shadowUrl", _shadowUrl);
        }
        if( _shadowSize != null )
        {
            iconOptions.put("shadowSize", "[" +_shadowSize +"]");
        }
        if( _shadowShadowSize != null )
        {
            iconOptions.put("shadowShadowSize", "[" +_shadowShadowSize +"]");
        }
        if( _iconAnchor != null )
        {
            iconOptions.put("iconAnchor", "[" +_iconAnchor +"]");
        }
        if( _iconShadowAnchor != null )
        {
            iconOptions.put("iconShadowAnchor","[" +_iconShadowAnchor +"]");
        }
    }




    if (WCMMode.fromRequest(request) == WCMMode.EDIT)
    {
        if( _layers == null || _layers.length == 0 )
        {
            _layers = new String[]{"http://{s}.tile.cloudmade.com/f98a33d731464da2b799c320be037ada/3/256/{z}/{x}/{y}.png"};
        }
    }
%>
<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.5.1/leaflet.css" />
<!--[if lte IE 8]>
<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.5.1/leaflet.ie.css" />
<![endif]-->



<div id="map" style="width:<%=_width%>; height:<%=_height%>"></div>

<script src="http://cdn.leafletjs.com/leaflet-0.5.1/leaflet-src.js"></script>
<script type="text/javascript">
    var map = L.map('map', {
        center: [<%=_mapCenter%>],
        zoom: <%=_zoom%>,
        scrollWheelZoom: false
    });

    /* add layers */
    <c:forEach var="layer" varStatus="layerLoop" items="<%= _layers %>">
        L.tileLayer('${layer}', {
            maxZoom: 18,
            attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
        }).addTo(map);
    </c:forEach>


    /* add simple markers: <%=_markerType%> */
    <% if( _markerType.equalsIgnoreCase("image") ){%>
        var _icon = L.icon(<%=iconOptions.toString()%>);
        <c:forEach var="marker" varStatus="markerLoop" items="<%= _markers %>">
            L.marker([${marker}], {icon:_icon}).addTo(map);
        </c:forEach>
    <%}else if( _markerType.equalsIgnoreCase("circle") ){%>
        <c:forEach var="marker" varStatus="markerLoop" items="<%= _markers %>">
            L.circle([${marker}], ${properties.circleRadius}, {
                color: '${properties.circleColor}',
                fillColor: '${properties.circleFillColor}',
                fillOpacity: ${properties.circleFillOpacity}
            }).addTo(map);
        </c:forEach>
    <%}else{%>
        <c:forEach var="marker" varStatus="markerLoop" items="<%= _markers %>">
            L.marker([${marker}]).addTo(map);
        </c:forEach>
    <%}%>


</script>
<cq:include path="leafletJSMarkers" resourceType="foundation/components/parsys"/>

