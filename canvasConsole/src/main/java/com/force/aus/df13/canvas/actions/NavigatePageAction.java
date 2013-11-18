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

import java.util.Map;

import com.force.aus.df13.canvas.AppProperties;
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
public class NavigatePageAction extends BaseAction {

	/**
	 * serialVersionUID = -3644741437299668608L;
	 */
	private static final long serialVersionUID = -3644741437299668608L;
	private String mode;
	
	
	@Override
	public String doExecute() {
		
		logger.debug("We seem to have a successful execution here [{}-{}-{}]", getMode(), this.getClass(), getSigned_request());
		
		if(getCanvasRequest() != null) {
			Map<String, Object> canvasParams = getCanvasRequest().getContext().getEnvironmentContext().getParameters();
			logger.debug("Canvas navigation parameter ["+(String)canvasParams.get(AppProperties.getPropValue(AppProperties.CANVAS_NAVIGATION_URL_PARAM))+"]");
			if(canvasParams.containsKey(AppProperties.getPropValue(AppProperties.CANVAS_NAVIGATION_URL_PARAM))) {
				return (String)canvasParams.get(AppProperties.getPropValue(AppProperties.CANVAS_NAVIGATION_URL_PARAM));
			}
		} else {
			return mode;
		}
		throw new RuntimeException("Unable to determine navigation");
	}
	
	public String getMode() {
		return this.mode;
	}
	
	public void setMode(final String mode) {
		this.mode = mode;
	}
	
}
