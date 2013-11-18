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
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="header">
	Configure the Canvas ERP Application
</div>
<div class="detailContainer">
	<div class="topContainer">
		This page is should be accessed first to populate Accounts and Product data from the Salesforce org you are working in.
		Once that is complete, you should then generate invoices.
	</div>
	<div class="accountForm">
		Accounts (<s:property value="accounts.size"/>)	<br />
		<s:form action="app/generateAccounts">
			<s:textfield name="externalIdFieldName" label="External ID Field Name"/>
			<s:submit />
		</s:form>
	</div>
	<table class="orderTable" title="Accounts">
		<tr id="accountHeader">
			<th width="25%">Name</th>
			<th width="15%">External ID</th>
			<th>Address</th>
		</tr>
		<s:iterator value="accounts" status="accStatus">
			<tr class="accountData">
				<s:if test="#accStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="name"/>
				</td>
				<s:if test="#accStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="externalID"/>
				</td>
				<s:if test="#accStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="street"/>, <s:property value="suburb"/> <s:property value="state"/> <s:property value="country"/> <s:property value="country"/> 
				</td>	
			</tr>							
		</s:iterator>
	</table>
	
Products (<s:property value="products.size"/>)	
	<table class="orderTable" title="Products">
		<tr id="productHeader">
			<th width="20%">Name</th>
			<th width="10%">Product Code</th>
			<th width="15%">Price</th>
			<th>Description</th>
		</tr>
		<s:iterator value="products" status="productStatus">
			<tr class="productData">
				<s:if test="#productStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="productName"/>
				</td>
				<s:if test="#productStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="productCode"/>
				</td>
				<s:if test="#productStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					$<s:property value="price"/>
				</td>					
				<s:if test="#productStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="description"/>
				</td>				
			</tr>							
		</s:iterator>
	</table>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		$("#accountHeader").click(function() {
			$(".accountData").each(function() {
				$(this).toggle();	
			});
		});
		$("#productHeader").click(function() {
			$(".productData").each(function() {
				$(this).toggle();	
			});	
		});
	});
</script>
