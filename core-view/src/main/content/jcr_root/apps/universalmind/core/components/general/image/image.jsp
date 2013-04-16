<%--
  Copyright 1997-2008 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Image component

  Draws an image. 

--%><%@ page import="com.day.cq.commons.Doctype,
    com.day.cq.wcm.api.components.DropTarget,
    com.day.cq.wcm.foundation.Image" 
%><%@include file="../../global.jsp"%><%
    Image image = new Image(resource);

    String  cssClass =  properties.get("cssClass",  "");
    String  cssStyle  =  properties.get("cssStyle",  "");

    //drop target css class = dd prefix + name of the drop target in the edit config
    image.addCssClass(DropTarget.CSS_CLASS_PREFIX + "image");
    image.loadStyleData(currentStyle);
    image.setSelector(".img"); // use image script
    image.setDoctype(Doctype.fromRequest(request));
    // add design information if not default (i.e. for reference paras)
    if (!currentDesign.equals(resourceDesign)) {
        image.setSuffix(currentDesign.getId());
    }
    String divId = "cq-image-jsp-" + resource.getPath();
    %><div id="<%= divId %>" class="<%=cssClass%>" style="<%=cssStyle%>"><% image.draw(out); %></div><%
    %><cq:text property="jcr:description" placeholder="" tagName="small" escapeXml="true"/>
    
    <%@include file="/libs/foundation/components/image/tracking-js.jsp"%>
