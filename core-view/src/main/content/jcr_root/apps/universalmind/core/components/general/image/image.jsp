<%@ page import="com.day.cq.wcm.api.WCMMode" %>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<%@include file="../../global.jsp"%><%
    Boolean  isAdaptive =  properties.get("useAdaptive",  false);
    String  cssClass =  properties.get("cssClass",  "");
    String  imageCssClass =  properties.get("imageCssClass",  "");
    String  cssStyle  =  properties.get("cssStyle",  "");
    String  imageCssStyle  =  properties.get("imageCssStyle",  "");
    String  width =  properties.get("width",  String.class);
    String  height =  properties.get("height",  String.class);
    String  linkURL =  properties.get("linkURL",  String.class);
    String[]  dataAttributes  =  (String[])properties.get("dataAttributes",  String[].class);
    String dataAttrString = "";

    String path = properties.get("fileReference", String.class);
    String alt = "";
    String size = "";

    if( width != null )
    {
        size += " width='" +width +"'";
    }
    if( height != null )
    {
        size += " height='" +height +"'";
    }

    if (properties.get("fileReference", "").length() != 0 || resource.getChild("file") != null)
    {
        alt = xssAPI.encodeForHTMLAttr( properties.get("alt", ""));

        if( dataAttributes != null )
        {
            for (String attribute : dataAttributes)
            {
                String[] attrs = attribute.split("=");
                if( attrs.length == 2)
                {
                    dataAttrString += " data-" +attrs[0] +"='" +xssAPI.encodeForHTMLAttr(attrs[1]) +"'";
                }
            }
        }
    }

    if( isAdaptive )
    {
        path = request.getContextPath() + resource.getPath();
%>
<% if( linkURL != null ){ %><a href="<%=linkURL%>"><%}%>
<div data-picture data-alt='<%= alt %>'   class="<%=cssClass%>" style="<%=cssStyle%>" <%=dataAttrString%>>
    <div data-src='<%= path + ".adapt.320.low.jpg" %>'></div>                                        <%-- Small mobile --%>
    <div data-src='<%= path + ".adapt.320.medium.jpg" %>'    data-media="(min-width: 320px)"></div>  <%-- Portrait mobile --%>
    <div data-src='<%= path + ".adapt.480.medium.jpg" %>'    data-media="(min-width: 321px)"></div>  <%-- Landscape mobile --%>
    <div data-src='<%= path + ".adapt.476.high.jpg" %>'     data-media="(min-width: 481px)"></div>   <%-- Portrait iPad --%>
    <div data-src='<%= path + ".adapt.620.high.jpg" %>'     data-media="(min-width: 769px)"></div>  <%-- Landscape iPad --%>
    <div data-src='<%= path + ".adapt.full.high.jpg" %>'     data-media="(min-width: 1025px)"></div> <%-- Desktop --%>

    <%-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. --%>
    <noscript>
        <img src="<%= path + ".adapt.320.low.jpg" %>"
             alt="<%= alt %>"  <%=size%>
             class="<%=imageCssClass%>" style="<%=imageCssStyle%>"
            <%=dataAttrString%>>
    </noscript>
</div>
<% if( linkURL != null ){ %></a><%}%>
<cq:includeClientLib js="apps.geometrixx-media"/>
<cq:includeClientLib js="apps.geometrixx-media.adaptive-image"/>

<%  } else if( path != null ) { %>
    <div  class="<%=cssClass%>" style="<%=cssStyle%>">
        <% if( linkURL != null ){ %><a href="<%=linkURL%>"><%}%>
        <img src="<%= path %>"
             alt="<%= alt %>" <%=size%>
             class="<%=imageCssClass%>" style="<%=imageCssStyle%>"
                <%=dataAttrString%>/>
        <% if( linkURL != null ){ %></a><%}%>
    </div>
<%
    } else if (WCMMode.fromRequest(request) == WCMMode.EDIT) {
        out.write("<img class='cq-dd-image cq-image-placeholder' src='/etc/designs/default/0.gif'>");
    }
%>
<cq:includeClientLib js="universalmind.widgets.dataAttributeMultifield"/>

