<%@taglib prefix="s" uri="/struts-tags" %>


<div class="header">
	Order Detail - Order_# <s:property value="invoice.id"/>
</div>
<div class="detailContainer">

	<div class="topContainer clearfix">
		<div class="addressDetails">
			<span class="value"><s:property value="invoice.account.name"/></span>
			<br />
			<span class="value"><s:property value="invoice.account.street"/></span>
			<br />
			<span class="value"><s:property value="invoice.account.suburb"/>, <s:property value="invoice.account.state"/> <s:property value="invoice.account.postcode"/></span>
			<br />		
		</div>
		<div class="invoiceDetails">
			<div class="labels">
				<span class="label">Invoice Total</span><br />
				<span class="label">Invoice Date</span><br />
				<span class="label">Invoice Status</span>
			</div>
			<div class="values">
				<span class="value">: $<s:property value="invoice.total"/></span><br />
				<span class="value">: <s:property value="invoice.invoiceDate"/></span><br />
				<span class="value">: <s:property value="invoice.status"/></span><br />			
			</div>
		</div>
	</div>
	<table class="orderTable">
		<tr>
			<th>Product</th>
			<th>Qty</th>
			<th>Line Item Price</th>
			<th>Total</th>
		</tr>
		<s:iterator value="invoice.lineItems" status="lineItemStatus">
			<tr>
				<s:if test="#lineItemStatus.even == true"><td class="even"></s:if>
				<s:else><td class="odd"></s:else>
					<s:property value="product.productName"/>
				</td>
				<s:if test="#lineItemStatus.even == true">
					<td class="even">
				</s:if>
				<s:else>
					<td class="odd">
				</s:else>
				<s:property value="quantity"/>
				</td>
				<s:if test="#lineItemStatus.even == true">
					<td class="even">
				</s:if>
				<s:else>
					<td class="odd">
				</s:else>
				$<s:property value="lineItemPrice"/>
				</td>
				<s:if test="#lineItemStatus.even == true">
					<td class="even">
				</s:if>
				<s:else>
					<td class="odd">
				</s:else>
				$<s:property value="lineItemTotal"/>
				</td>									
			</tr>
		</s:iterator>
	</table>

</div>



