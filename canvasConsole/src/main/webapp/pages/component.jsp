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
	Orders for <s:property value="accountName"/>
</div>
<div class="detailContainer">
	<table class="orderTable">
			<tr>
			<th>Order ID</th>
			<th>Status</th>
			<th>Total</th>
			<th>Order Date</th>
		</tr>
		<s:iterator value="invoices" status="invoiceStatus">
			<tr>
				<s:if test="#invoiceStatus.even == true"><td class="even orderID"></s:if>
				<s:else><td class="odd orderID"></s:else>
					<s:property value="id"/>
				</td>
				<s:if test="#invoiceStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="status"/>
				</td>			
				<s:if test="#invoiceStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="total"/>
				</td>	
				<s:if test="#invoiceStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="invoiceDate"/>
				</td>	
			</tr>	
		</s:iterator>					
	</table>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		$(".orderID").click(function() {
			var oId = $(this).html().trim();
			var accId = '<s:property value="accountId"/>';
			sr = JSON.parse('<s:property value="canvasJSON" escapeHtml="false"/>');
			Sfdc.canvas.client.publish(sr.client, {name : "consoleDemoEvents.openOrderList", payload : {orderId : oId, accountId : accId}});
		});
	});
</script>
