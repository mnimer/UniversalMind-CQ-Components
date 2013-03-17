<%@include file="../../global.jsp"%>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0" %>
<%@page session="false" %>
<%@ page import="com.day.text.Text" %>
<%@ page import="javax.jcr.Session" %>
<%@ page import="javax.jcr.Node" %>
<%@ page import="javax.jcr.NodeIterator" %>
<%@ page import="javax.jcr.nodetype.NodeType" %>
<%@ page import="com.day.cq.wcm.api.Page" %>
<%@ page import="org.apache.jackrabbit.commons.iterator.NodeIteratorAdapter" %>
<%@ page import="java.util.ArrayList" %>
<%--cq:includeClientLib css="universalmind.bootstrap" /--%>
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

<cq:defineObjects/>
<%
    Session session = slingRequest.getResourceResolver().adaptTo(Session.class);

    String  brand  =  (String)properties.get("brand", "Title");
    Boolean navbarInverse =  properties.get("navbarInverse",  false);
    Boolean navbarFixed =  properties.get("navbarFixed",  false);
    Boolean pullRight =  properties.get("pullRight",  false);
    Boolean navbarCollapsable =  properties.get("navbarCollapsable",  true);
    String  cssClass  =  (String)properties.get("cssClass",  "");
    String  cssStyle  =  (String)properties.get("cssStyle",  "");
    String  listFrom  =  (String)properties.get("listFrom");
    Integer menuLevel  =  properties.get("menulevel", 1);
    String parentPage  =  (String)properties.get("parentPage");
    String[] pages  =  properties.get("pages",  String[].class);

    // Style
    String cssClasses = "navbar ";
    if( navbarInverse )
    {
        cssClasses += "navbar-inverse ";
    }
    if( navbarFixed )
    {
        cssClasses += "navbar-fixed-top ";
    }

    if( cssClass != null && cssClass.length() > 0 )
    {
        cssClasses += cssClass +" ";
    }



    // links
    NodeIterator childNodeIterator = null;
    if( listFrom!=null && listFrom.equalsIgnoreCase("children") )
    {
        Node root = session.getNode(parentPage);
        childNodeIterator = root.getNodes();
    }
    else if( listFrom!=null &&  listFrom.equalsIgnoreCase("static") )
    {
        ArrayList nodeList = new ArrayList();
        for( int i=0; i < pages.length; i++)
        {
            nodeList.add( session.getNode(pages[i]) );
        }

        childNodeIterator = new NodeIteratorAdapter(nodeList);
    }
%>


<div class="<%=cssClasses%>" style="<%=cssStyle%>">
    <div class="navbar-inner">
        <div class="container">
            <%if( navbarCollapsable ){ %>
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <%}%>

            <% if (brand != null )
            {
                long absParent = currentStyle.get("absParent", currentPage.getDepth());
                String home = Text.getAbsoluteParent(currentPage.getPath(), (int) absParent);
            %>
                <a class="brand" href="<%=home%>.html"><%=brand%></a>
            <%}%>

            <div class="nav-collapse  <%if( navbarCollapsable ){ %>collapse<%}%>" role=”navigation”>
                <ul class="nav <%= pullRight? "pull-right": "" %>" >
                    <% if( childNodeIterator != null )
                    {
                        while( childNodeIterator.hasNext() )
                        {
                            Node node = childNodeIterator.nextNode();

                            Resource res = resourceResolver.getResource(node.getPath());
                            Page pageRes = res.adaptTo(Page.class);

                            //todo: list children, to get sub menu
                            //pageRes.listChildren(new PageFilter());

                            if( pageRes != null )
                            {
                    %>
                        <li><a href="<%=pageRes.getPath() +".html"%>"><%= pageRes.getTitle()%></a></li>
                    <%
                            }
                        }
                    }%>
                </ul>
            </div>
        </div>
    </div>
</div>