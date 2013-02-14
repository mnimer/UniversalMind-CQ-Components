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


  Carousel component.

  Implementation of Twitter Bootstrap Carousel

--%>
<%@include file="../../global.jsp" %>
<%@page session="false" %>
<%@ page import="java.util.Iterator,
                 java.util.LinkedHashMap,
                 java.util.Map,
                 com.day.cq.commons.Doctype,
                 com.day.cq.wcm.api.WCMMode,
                 com.day.cq.wcm.api.components.DropTarget,
                 com.day.cq.wcm.foundation.Image,
                 com.day.cq.wcm.foundation.List,
                 com.day.text.Text,
                 com.day.cq.wcm.foundation.List,
                 com.day.cq.wcm.api.PageFilter,
                 com.day.cq.i18n.I18n,
                 com.day.cq.wcm.foundation.Paragraph,
                 com.day.cq.wcm.api.components.Toolbar"
        %>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<cq:includeClientLib css="universalmind.bootstrap" />

<%
    String xs = Doctype.isXHTML(request) ? "/" : "";
    int playSpeed = properties.get("playSpeed", 6000);
    int containerSlideCount = properties.get("containerSlideCount", 3);
    String listFrom = properties.get("listFrom", "container");


    Boolean _autoPlay = properties.get("autoPlay", false);
    Boolean _showControls = properties.get("showControls", false);
    Boolean _showIndicators = properties.get("showIndicators", false);
    Boolean _showOverlay = properties.get("showOverlay", false);
    Boolean _pauseHover = properties.get("pauseHover", false);


    // styling
    String _cssClass  = properties.get("cssClass", "");
    String _cssStyle = properties.get("cssStyle", "");
    String _slideCssClass  = properties.get("slideCssClass", "");
    String _slideCssStyle = properties.get("slideCssStyle", "");

    String slideStyle = "";
    int slideCount = 0;
    Map<String, Slide> slides = new LinkedHashMap<String, Slide>();


    /// add label to edit bar
    if (editContext != null
            && WCMMode.fromRequest(request) == WCMMode.EDIT
            && resource instanceof Paragraph)
    {
        Paragraph par = (Paragraph) resource;
        switch (par.getType()) {
            case START: {
                String text = I18n.get(slingRequest, "Carousel", null);
                editContext.getEditConfig().getToolbar().add(0, new Toolbar.Separator());
                editContext.getEditConfig().getToolbar().add(0, new Toolbar.Label(text));
                // disable ordering to get consistent behavior
                editContext.getEditConfig().setOrderable(false);
                break;
            }
            case END:
                break;
            case BREAK:
                break;
            case NORMAL:
                break;
        }
    }


    if (WCMMode.fromRequest(request) == WCMMode.EDIT)
    {
        // set some simple css, to make it easier to edit this component
        //_slideCssStyle = "min-height:300px;background-color:#eee;" + _slideCssStyle;
        _autoPlay = false; // turn off auto play while in edit mode.
    }

    List list = new List(slingRequest, new PageFilter());
    if (list != null && !list.isEmpty())
    {
        slideCount = list.size();
        // first shove all slides into a map in order to calculate distinct ids
        Iterator<Page> items = list.getPages();
        String pfx = "cqc-" + Text.getName(resource.getPath()) + "-";
        while (items.hasNext())
        {
            Slide slide = new Slide(items.next());
            String name = pfx + slide.name;
            int idx = 0;
            while (slides.containsKey(name))
            {
                name = pfx + slide.name + (idx++);
            }
            slide.name = name;
            // prepend context path to img
            slide.img = request.getContextPath() + slide.img;
            slides.put(name, slide);
        }
    }
    else if( listFrom.equals("container") )
    {
        slideCount = containerSlideCount;
        for( int i=0; i < slideCount; i++)
        {
            slides.put("slide"+i,  new Slide("slide"+i));
        }
    }


    // We have slides, so let's build the component
    if( slideCount > 0)
    {
%>

<div id="carousel-${currentNode.identifier}"
     class="carousel slide <%=_cssClass%>"
     style="<%=_cssStyle%>"
     data-interval="${!_autoPlay?'false':playSpeed}" <%if (_pauseHover){%>data-pause="hover"<%}%>>
    <% if( _showIndicators ) { %>
    <ol class="carousel-indicators pull-right">
        <c:forEach var="slide" varStatus="loop" items="<%= slides.values() %>">
            <li data-target="#carousel-<%=currentNode.getIdentifier()%>" data-slide-to="${pageScope.loop.index}" class=""></li>
        </c:forEach>
    </ol>
    <% } %>

    <div class="carousel-inner">
        <c:forEach var="slide" varStatus="loop" items="<%= slides.values() %>">
            <div id="${slide.name}" class="item ${pageScope.loop.index==0?'active':''}">

                <c:choose>
                    <c:when test="${slide.page != null }">

                        <c:choose>
                            <c:when test="${!empty slide.img}">
                                <a href="${slide.path}.html" title="${slide.title}">
                                    <img src="http://twitter.github.com/bootstrap/assets/img/bootstrap-mdo-sfmoma-03.jpg" alt="">
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div style="<%=_slideCssStyle%>"></div>
                            </c:otherwise>
                        </c:choose>

                        <% if( _showOverlay ){%>
                        <div class="carousel-caption">
                            <h4>${slide.title}</h4>
                            <p>${slide.desc}</p>
                            <a href="${slide.path}.html">Read More</a>
                        </div>
                        <%}%>
                    </c:when>
                    <c:otherwise>
                        <div class="<%=_slideCssClass%>" style="<%=_slideCssStyle%>">
                            <cq:include path="${slide.name}" resourceType="foundation/components/parsys"/>
                        </div>
                        <% if( _showOverlay ){%>
                        <div class="carousel-caption">
                            <cq:include path="${slide.name}-caption" resourceType="foundation/components/parsys"/>
                        </div>
                        <%}%>
                    </c:otherwise>
                </c:choose>

            </div>
        </c:forEach>
    </div>
    <%-- defines the controls --%>
    <% if( _showControls ) { %>
        <a class="left carousel-control" href="#carousel-<%=currentNode.getIdentifier()%>" data-slide="prev">&lsaquo;</a>
        <a class="right carousel-control" href="#carousel-<%=currentNode.getIdentifier()%>" data-slide="next">&rsaquo;</a>
    <%}%>
</div>

<%
}
else
{
    if (WCMMode.fromRequest(request) == WCMMode.EDIT)
    {
        //if we don't have any slides defined, and we are in edit mode - so this default carousel
%>
<div id="myCarousel" class="carousel slide">
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- Carousel items -->
    <div class="carousel-inner">
        <div class="active item">
            <img src="http://dummyimage.com/1024x400&text=Placeholder" alt="">
            <div class="carousel-caption">
                <h4>Placeholder</h4>
                <p>Edit Component To Change</p>
            </div>
        </div>
        <div class="item">
            <img src="http://lorempixel.com/g/1024/400/city" alt="">
            <div class="carousel-caption">
                <h4>Placeholder</h4>
                <p>Edit Component To Change</p>
            </div>
        </div>
        <div class="item">
            <img src="http://lorempixel.com/g/1024/400/animals" alt="">
            <div class="carousel-caption">
                <h4>Placeholder</h4>
                <p>Edit Component To Change</p>
            </div>
        </div>
    </div>
    <!-- Carousel nav -->
    <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
    <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
</div>

<%
        }
    }


%><%!

    /**
     * Container class for slides
     */
    public static final class Slide
    {
        private final Page page;
        private static int counter = 0;
        private String img = "";
        private String title = "";
        private String name = "";
        private String desc = "";
        private String path = "";


        private Slide(String name_)
        {
            name = name_;
            page = null;
        }


        private Slide(Page page)
        {
            this.page = page;
            title = page.getTitle();
            desc = page.getDescription();
            if (desc == null)
            {
                desc = "";
            }
            path = page.getPath();
            // currently we just check if "image" resource is present
            Resource r = page.getContentResource("image");
            if (r != null)
            {
                Image image = new Image(r);
                img = page.getPath() + ".img.png" + image.getSuffix();
            }
            name = page.getName();
        }


        public Page getPage()
        {
            return page;
        }


        public String getImg()
        {
            return img;
        }


        public String getTitle()
        {
            return title;
        }


        public String getName()
        {
            return name;
        }


        public String getDesc()
        {
            return desc;
        }


        public String getPath()
        {
            return path;
        }
    }
%>

