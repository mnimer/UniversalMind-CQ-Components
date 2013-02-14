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

  Lorem Ipsum Text component.
  A lorem ipsum generator to fill in placeholder text, while mocking up pages

--%>
<%@include file="../../global.jsp"%>
<%@page session="false" %>
<%@ page import="org.apache.commons.httpclient.*" %>
<%@ page import="org.apache.sling.commons.json.JSONException" %>
<%@ page import="org.apache.sling.commons.json.JSONObject" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>
<%@ page import="org.apache.commons.httpclient.HttpMethod" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%
    String  cssClass  =  properties.get("cssClass",  "");
    String  cssStyle  =  properties.get("cssStyle",  "");
    String  textservice  =  properties.get("textservice",  "lipsum.com");
    String  schmipsumSource  =  properties.get("schmipsumSource",  "shakesphere");
    Integer  paragraphs  =  properties.get("paragraphs",  2);
    Integer  words  =  properties.get("wordCount",  200);

    String loremText = null;
    String url = null;
    if( textservice.equalsIgnoreCase("lipsum.com") )
    {
        url = "http://www.lipsum.com/feed/xml?what=paras&start=true&amount=" +paragraphs;
    }
    else if( textservice.equalsIgnoreCase("baconipsum.com") )
    {
        url = "http://baconipsum.com/api/?type=meat-and-filler&start-with-lorem=1&paras=" +paragraphs;
    }
    else if( textservice.equalsIgnoreCase("baseballipsum.apphb.com") )
    {
        url = "http://baseballipsum.apphb.com/api/?startwithlorem=true&paras=" +paragraphs;
    }
    else if( textservice.equalsIgnoreCase("schmipsum.com") )
    {
        url = "http://www.schmipsum.com/ipsum/" +schmipsumSource +"/" +words;
    }
    else
    {
        loremText = "Lorem Ipsum..."; // default text
    }


    if( url != null )
    {
        HttpMethod method = null;
        HttpClient client = new HttpClient();
        try {
            method = new GetMethod(url);
            int statusCode = client.executeMethod(method);
            byte[] responseBody = method.getResponseBody();

            loremText = parseResults(textservice, new String(responseBody));
        }
        catch( Exception jse )
        {
            //do nothing
        }
        finally
        {
            if( method != null )
            {
                method.releaseConnection();
            }
        }
    }
%>


<%!
    public String parseResults(String textservice, String body) throws Exception
    {
        if( textservice.equalsIgnoreCase("lipsum.com") )
        {
            return parseLoremIpsum(body);
        }
        else if( textservice.equalsIgnoreCase("baconipsum.com") )
        {
            return parseArrayResult(body);
        }
        else if( textservice.equalsIgnoreCase("baseballipsum.apphb.com") )
        {
            return parseArrayResult(body);
        }
        else if( textservice.equalsIgnoreCase("schmipsum.com") )
        {
            return parseSchmIpsum(body);
        }

        return "Lorem Ipsum...";
    }

    public String parseLoremIpsum(String body) throws Exception
    {
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

        InputStream is = new ByteArrayInputStream(body.getBytes());
        Document doc = dBuilder.parse(is);

        doc.getDocumentElement().normalize();

        NodeList nList = ((Element)doc.getElementsByTagName("feed").item(0)).getElementsByTagName("lipsum");

        String lorem = nList.item(0).getTextContent();
        return lorem.replaceAll("\n", "<br/><br/>");
    }

    public String parseArrayResult(String body) throws Exception
    {
        if( body.startsWith("[") )
        {
            String[] lines = body.substring(2, body.length() - 2).split("\",\"");

            return StringUtils.join(lines, "<br/><br/>");
        }
        return body;
    }


    public String parseSchmIpsum(String body) throws Exception
    {
        if( body.startsWith("{") )
        {
            JSONObject json = new JSONObject(body);
            String lorem = json.getString("ipsum");
            String[] lines = lorem.split("\\r?\\n");
            return StringUtils.join(lines, "<br/>");
        }
        return body;
    }
%>

<div class="<%=cssClass%>" style="<%=cssStyle%>">
    <p><%=loremText%></p>
</div>