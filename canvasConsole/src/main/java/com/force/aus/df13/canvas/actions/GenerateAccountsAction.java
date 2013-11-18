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

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.force.aus.GrantType;
import com.force.aus.OAuthProperties;
import com.force.aus.OAuthResult;
import com.force.aus.SFIdentity;
import com.force.aus.SFRestHelper;
import com.force.aus.df13.canvas.AppProperties;
import com.force.aus.df13.canvas.DataGenerator;
import com.force.aus.df13.canvas.entity.Account;

/**
 * <p>
 * The BaseOBMAction class instantiates and commits transactions as well as handling the 
 * JPA stuff.
 * </p>
 * @author tsellers@salesforce.com
 *
 */
public class GenerateAccountsAction extends BaseAction {

	/**
	 * serialVersionUID = -3644741437299668608L;
	 */
	private static final long serialVersionUID = -3644741437299668608L;

	private String externalIdFieldName;
	
	@Override
	public String doExecute() {

		if(getCanvasRequest() != null) {
			Map<String, Object> canvasParams = getCanvasRequest().getContext().getEnvironmentContext().getParameters();
		} else {
			
		}
		if(externalIdFieldName != null) {
			DataGenerator dg = new DataGenerator(em);
			try {
				dg.createAccounts(getSFAccounts());
				return SUCCESS;
			} catch (Exception e) {
				addActionError(e.getMessage());
				e.printStackTrace();
			}
		} else {
			addFieldError("externalIdField", "Please ensure you add a value in this field");
		}
		return ERROR;
	}

	public String getExternalIdFieldName() {
		return externalIdFieldName;
	}
	
	public void setExternalIdFieldName(String externalIdFieldName) {
		this.externalIdFieldName = externalIdFieldName;
	}
	
	private List<Account> getSFAccounts() throws IOException, JSONException {
		
		List<Account> accounts = new ArrayList<Account>();
		
		SFRestHelper helper = new SFRestHelper();
		OAuthResult oAuth = null;
		if(getCanvasRequest() == null) {
			logger.debug("Logging in using Properties");
			OAuthProperties oauthProperties = new OAuthProperties();
			oauthProperties.setApiVersion(AppProperties.getPropValue("sforce.api.version"));
			oauthProperties.setHost(AppProperties.getPropValue("sforce.host"));
			oauthProperties.setClientId(AppProperties.getPropValue("sforce.oauth.id"));
			oauthProperties.setClientSecret(AppProperties.getPropValue("sforce.oauth.secret"));
			oauthProperties.setGrantType(GrantType.PASSWORD);
			oauthProperties.setUsername(AppProperties.getPropValue("sforce.user"));
			oauthProperties.setPassword(AppProperties.getPropValue("sforce.pass"));
			oAuth = helper.login(oauthProperties, true);
			
		} else {
			logger.debug("Logging in using a Canvas Request");
			oAuth = new OAuthResult();
			SFIdentity identity = new SFIdentity();
			JSONObject urls = new JSONObject();
			logger.debug("Adding query URL {}", getCanvasRequest().getContext().getLinkContext().getQueryUrl());
			urls.append("query", getCanvasRequest().getContext().getLinkContext().getQueryUrl());
			oAuth.setIdentity(identity);
			oAuth.setAccessToken(getCanvasRequest().getClient().getOAuthToken()); 
		}
		
		return accounts;
		
	}

}
