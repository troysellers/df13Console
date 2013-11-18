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
package com.force.aus.df13.canvas.interceptors;

import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import canvas.CanvasRequest;
import canvas.SignedRequest;

import com.force.aus.df13.canvas.AppProperties;
import com.force.aus.df13.canvas.actions.BaseAction;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class SignedRequestInterceptor extends AbstractInterceptor {
	
	/**
	 * serialVersionUID = -1982649488945628380L
	 */
	private static final long serialVersionUID = -1982649488945628380L;
	private Logger logger;
	private static String REQUEST_KEY_SIGNED_REQUEST = "signed_request";


	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		logger = LoggerFactory.getLogger(this.getClass());
		logger.debug("Are we checking for the Signed Request?");

		HttpServletRequest request = ServletActionContext.getRequest();
		BaseAction action = (BaseAction)invocation.getAction();
		
		String signedRequest = request.getParameter(REQUEST_KEY_SIGNED_REQUEST);
		CanvasRequest canvasRequest = null;
		String canvasJSON = null;
		if (signedRequest != null) {
			logger.debug("We have a SignedRequest {}", signedRequest);
			// process signed request
			canvasRequest = processSignedRequest(signedRequest);
			canvasJSON = processSignedRequestJSON(signedRequest);
			
		} else {
			logger.error("No Signed Request");
			
			//return "noSignedRequest";
		}
		
		action.setCanvasRequest(canvasRequest);
		action.setCanvasJSON(canvasJSON);
		action.setSigned_request(signedRequest);
		return invocation.invoke();

	}
	
	private CanvasRequest processSignedRequest(String signedRequest) {
		CanvasRequest canvasRequest = null;
		if (signedRequest != null && !signedRequest.equals("")) {
			String canvasAppSecret = System.getenv(AppProperties.CANVAS_APP_SECRET);
			if(canvasAppSecret == null) 
				canvasAppSecret = AppProperties.getPropValue(AppProperties.CANVAS_APP_SECRET);
			 canvasRequest = SignedRequest.verifyAndDecode(signedRequest, canvasAppSecret);
			logOutCanvasDetails(canvasRequest);
		}
		return canvasRequest;
	}
	
	private String processSignedRequestJSON(String signedRequest) {
		String canvasAppSecret = System.getenv(AppProperties.CANVAS_APP_SECRET);
		if(canvasAppSecret == null) 
			canvasAppSecret = AppProperties.getPropValue(AppProperties.CANVAS_APP_SECRET);
		String json = SignedRequest.verifyAndDecodeAsJson(signedRequest, canvasAppSecret);
		logger.debug("We have as JSON [{}]", json);
		return json;
	}	
	
	private void logOutCanvasDetails(CanvasRequest canvasRequest) {
		
		logger.debug("Algorithm {}", canvasRequest.getAlgorithm());
		logger.debug("Client ID {}", canvasRequest.getClient().getClientId());
		logger.debug("Instance ID {}", canvasRequest.getClient().getInstanceId());
		logger.debug("Instance URL {}", canvasRequest.getClient().getInstanceUrl());
		logger.debug("OAuth Token {}", canvasRequest.getClient().getOAuthToken());
		logger.debug("Target Origin {}", canvasRequest.getClient().getTargetOrigin());
		logger.debug("Dimension - Height {}", canvasRequest.getContext().getEnvironmentContext().getDimensions().getHeight());
		logger.debug("Dimension - Width {}", canvasRequest.getContext().getEnvironmentContext().getDimensions().getWidth());
		logger.debug("Location URL {}", canvasRequest.getContext().getEnvironmentContext().getLocationUrl());
		logger.debug("API Version {}", canvasRequest.getContext().getEnvironmentContext().getSystemVersion().getApiVersion());
		logger.debug("Season {}", canvasRequest.getContext().getEnvironmentContext().getSystemVersion().getSeason());
		logger.debug("UI Theme {}", canvasRequest.getContext().getEnvironmentContext().getUiTheme());
		
		Map<String, Object> canvasParameters = canvasRequest.getContext().getEnvironmentContext().getParameters();
		Iterator<String> it = canvasParameters.keySet().iterator();
		while(it.hasNext()) {
			String key = it.next();
			logger.debug("Parameter ["+key+"] value ["+canvasParameters.get(key).toString()+"]");
		}
		
		logger.debug("URL - Chatter Feed Item {}", canvasRequest.getContext().getLinkContext().getChatterFeedItemsUrl());
		logger.debug("URL - Chatter Feeds {}", canvasRequest.getContext().getLinkContext().getChatterFeedsUrl());
		logger.debug("URL - Chatter Groups {}", canvasRequest.getContext().getLinkContext().getChatterGroupsUrl());
		logger.debug("URL - Chatter Users {}", canvasRequest.getContext().getLinkContext().getChatterUsersUrl());
		logger.debug("URL - Enterprise {}", canvasRequest.getContext().getLinkContext().getEnterpriseUrl());
		logger.debug("URL - Metadata {}", canvasRequest.getContext().getLinkContext().getMetadataUrl());
		logger.debug("URL - Partner {}", canvasRequest.getContext().getLinkContext().getPartnerUrl());
		logger.debug("URL - Query {}", canvasRequest.getContext().getLinkContext().getQueryUrl());
		logger.debug("URL - Recent Items {}", canvasRequest.getContext().getLinkContext().getRecentItemsUrl());
		logger.debug("URL - Rest {}", canvasRequest.getContext().getLinkContext().getRestUrl());
		logger.debug("URL - Search {}", canvasRequest.getContext().getLinkContext().getSearchUrl());
		logger.debug("URL - SObject {}", canvasRequest.getContext().getLinkContext().getSobjectUrl());
		logger.debug("URL - User {}", canvasRequest.getContext().getLinkContext().getUserUrl());
		logger.debug("Currency ISO Code {}", canvasRequest.getContext().getOrganizationContext().getCurrencyISOCode());
		logger.debug("Org Name {}", canvasRequest.getContext().getOrganizationContext().getName());
		logger.debug("Org ID {}", canvasRequest.getContext().getOrganizationContext().getOrganizationId());
		logger.debug("Currency ISO Code {}", canvasRequest.getContext().getUserContext().getCurrencyISOCode());
		logger.debug("User - Email {}", canvasRequest.getContext().getUserContext().getEmail());
		logger.debug("User - Firstname {}", canvasRequest.getContext().getUserContext().getFirstName());
		logger.debug("User - Full Name {}", canvasRequest.getContext().getUserContext().getFullName());
		logger.debug("User - Language {}", canvasRequest.getContext().getUserContext().getLanguage());
		logger.debug("User - Lastname {}", canvasRequest.getContext().getUserContext().getLastName());
		logger.debug("User - Locale {}", canvasRequest.getContext().getUserContext().getLocale().toString());
		logger.debug("User - Profile ID {}", canvasRequest.getContext().getUserContext().getProfileId());
		logger.debug("URL - Profile Photo {}", canvasRequest.getContext().getUserContext().getProfilePhotoUrl());
		logger.debug("URL - Profile Thumbnail {}", canvasRequest.getContext().getUserContext().getProfileThumbnailUrl());
		logger.debug("User - Role ID {}", canvasRequest.getContext().getUserContext().getRoleId());
		logger.debug("User - Timezone {}", canvasRequest.getContext().getUserContext().getTimeZone());
		logger.debug("User - username {}", canvasRequest.getContext().getUserContext().getUserName());
		logger.debug("User - Type {}", canvasRequest.getContext().getUserContext().getUserType());
		logger.debug("Issued At {}", canvasRequest.getIssuedAt());
		logger.debug("User - ID {}", canvasRequest.getUserId());
	}
}
