<%--
  Copyright (c) 2013, salesforce.com, inc.
  All rights reserved.
 
  Redistribution and use in source and binary forms, with or without modification, are permitted provided
  that the following conditions are met:
 
     Redistributions of source code must retain the above copyright notice, this list of conditions and the
     following disclaimer.
 
     Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
     the following disclaimer in the documentation and/or other materials provided with the distribution.
 
     Neither the name of salesforce.com, inc. nor the names of its contributors may be used to endorse or
     promote products derived from this software without specific prior written permission.
 
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE.
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<tiles:importAttribute name="title" scope="request"/>
<html>
	<head>
		<meta charset="utf-8" />
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
<meta http-equiv="pragma" content="no-cache" />

		
		<title><tiles:getAsString name="title"/></title>
		<link href="/css/component.css" rel="stylesheet" type="text/css" />
		<link href="/images/favicon.ico" rel="icon" type="image/x-icon">
		<script src="/js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="/js/canvas-all.js"></script>
	</head>
<body>

<div id="header"></div>
<div id="mainContainer">
	<tiles:insertAttribute name="mainContent"/>
</div>
<div id="footer">
Powered by <a href="http://www.heroku.com"><img src="/images/heroku.png" alt="Heroku" height="20px" align="top"/></a>
</div>
</body>
</html>