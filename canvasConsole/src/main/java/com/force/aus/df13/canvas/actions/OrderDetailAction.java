/**
 * Copyright (c) 2013, salesforce.com, inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided
 * that the following conditions are met:
 *
 *    Redistributions of source code must retain the above copyright notice, this list of conditions and the
 *    following disclaimer.
 *
 *    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
 *    the following disclaimer in the documentation and/or other materials provided with the distribution.
 *
 *    Neither the name of salesforce.com, inc. nor the names of its contributors may be used to endorse or
 *    promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package com.force.aus.df13.canvas.actions;

import java.util.List;

import com.force.aus.df13.canvas.entity.Account;
import com.force.aus.df13.canvas.entity.Invoice;
/**
 * HomePageAction retrieves all the locally stored Outbound Messages that have been received.
 * Each message that is received by the webservice is persisted to a local dbase, allowing
 * users to view them via this action
 * <p>
 * The BaseOBMAction class instantiates and commits transactions as well as handling the 
 * JPA stuff.
 * </p>
 * @author tsellers@salesforce.com
 *
 */
public class OrderDetailAction extends BaseAction {

	/**
	 * serialVersionUID = -3644741437299668608L;
	 */
	private static final long serialVersionUID = -3644741437299668608L;

	private String orderNumber;
	private String accountId;
	
	private Invoice invoice;
	
	@Override
	public String doExecute() {
		logger.debug("We seem to have a successful execution here [{}-{}]", this.getClass(), getSigned_request());
		if(getCanvasRequest() != null) {
			orderNumber = String.valueOf(getCanvasRequest().getContext().getEnvironmentContext().getParameters().get("orderNumber"));
			accountId = (String)getCanvasRequest().getContext().getEnvironmentContext().getParameters().get("accId");
			
		}
		
		invoice = (Invoice)em.createQuery("select i from Invoice i where i.account.externalID = :accountId and i.id = :orderNumber")
						.setParameter("accountId", accountId)
						.setParameter("orderNumber", Long.valueOf(orderNumber))
						.getSingleResult();
		
		invoice.calculateInvoiceTotal();
		
		logger.debug("We have Account [{}] and Order [{}]", accountId, orderNumber);		
		return SUCCESS;
	}

	public Invoice getInvoice() {
		return invoice;
	}
	
	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	

}
