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

    This is a simple page component using JSP that extends the foundation page component.

--%>

<%@ include file="/apps/universalmind/core/components/global.jsp" %>

<body>
<cq:include path="clientcontext" resourceType="cq/personalization/components/clientcontext"/>

<header>
    <cq:include path="header" resourceType="foundation/components/parsys"/>
</header>

<div class="container-fluid" role="main">
    <cq:include path="content" resourceType="foundation/components/parsys"/>
</div> <!-- /container -->

<footer role=”contentinfo”>
    <cq:include path="footer" resourceType="foundation/components/parsys"/>
</footer>

<cq:include path="timing" resourceType="foundation/components/timing"/>
</body>
<cq:includeClientLib js="universalmind.bootstrap" />
</html>