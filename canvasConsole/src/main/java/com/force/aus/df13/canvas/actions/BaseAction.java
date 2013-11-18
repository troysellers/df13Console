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

import javax.persistence.EntityManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import canvas.CanvasRequest;

import com.force.aus.df13.canvas.listeners.EMFListener;
import com.opensymphony.xwork2.ActionSupport;

/**
 * BaseOBMAction handles common action tasks. Manages transactions and creation
 * and closing of EntityManager. Also provides method wrappers for JPA queries.
 * Instantiates and handles most of the logging.
 * 
 * @author tsellers@salesforce.com
 * 
 */
public abstract class BaseAction extends ActionSupport /*implements SessionAware*/ {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8515642582004576369L;
	protected EntityManager em;
	protected Logger logger;
	private String pageName;
//	private Map<String, Object> session;
	private String signed_request;
	private String canvasJSON;
	private CanvasRequest canvasRequest;
	
	public String execute() {
		logger = LoggerFactory.getLogger(this.getClass());
		logger.debug("Executing Action {}", this.getClass());
		
		em = EMFListener.createEntityManager();
		em.getTransaction().begin();
		// call method provided concrete by implementation classes
		String action = doExecute();
		em.getTransaction().commit();
		em.close();

		logger.debug("Action {} complete, returning {}", this.getClass(), action);

		return action;
	}


	
//	@Override
//	public void setSession(Map<String, Object> session) {
//		this.session = session;
//	}
	
	/**
	 * Method for concrete action classes to implement
	 * 
	 * @return
	 */
	public abstract String doExecute();

	/**
	 * Get an EntityManager from the EMFListener class.
	 * 
	 * @return
	 */
	protected EntityManager getEntityManager() {
		return EMFListener.createEntityManager();
	}

	/**
	 * Return an un-typed list from executing the JPA getResultList() query.
	 * 
	 * @param query
	 * @return
	 */
	protected List doListQuery(String query) {

		logger.debug("About to do ListQuery {}", query);
		List retVal = em.createQuery(query).getResultList();

		return retVal;

	}

	/**
	 * Returns an Object from executing the JPA getSingleResult() query.
	 * 
	 * @param query
	 * @return
	 */
	protected Object doSingleQuery(String query) {

		logger.debug("About to do SingleQuery {}", query);
		Object obj = em.createQuery(query).getSingleResult();

		return obj;
	}

	/**
	 * Returns int that is the result of a JPA executeUpdate() query.
	 * 
	 * @param query
	 * @return
	 */
	protected int doExecuteQuery(String query) {

		logger.debug("About to execute query {}", query);
		int retVal = em.createQuery(query).executeUpdate();

		return retVal;

	}

	/*
	 * The signed request is processed and stored on the session
	 * via a Struts Interceptor. 
	 */
	public void setSigned_request(String signed_request) {
		this.signed_request = signed_request;
	}
	
	public void setCanvasRequest(CanvasRequest canvasRequest) {
		this.canvasRequest = canvasRequest;
	}
	
	public CanvasRequest getCanvasRequest() {
		return this.canvasRequest;
	}

	public final String getPageName() {
		return pageName;
	}

	public final void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getSigned_request() {
		return signed_request;
	}

	public String getCanvasJSON() {
		return canvasJSON;
	}

	public void setCanvasJSON(String canvasJSON) {
		this.canvasJSON = canvasJSON;
	}	

	
}
