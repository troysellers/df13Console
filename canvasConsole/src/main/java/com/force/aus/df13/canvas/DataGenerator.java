package com.force.aus.df13.canvas;

import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.persistence.EntityManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.force.aus.df13.canvas.entity.Account;
import com.force.aus.df13.canvas.entity.Invoice;
import com.force.aus.df13.canvas.entity.InvoiceLineItem;
import com.force.aus.df13.canvas.entity.Product;

public class DataGenerator {

	private EntityManager em;
	private Logger logger;
	private String[] statusValues = {"Open","Pending Approval", "On Back Order", "Processing", "Shipped" ,"Cancelled"};
	private int maxNumberOfLineItems = 5;
	private int maxNumberOfDaysInPast = 600;
	private int maxQuantity = 5;
	private int maxNumberOfInvoices = 6;
	
	public DataGenerator(EntityManager em) {
		this.em = em;
		logger = LoggerFactory.getLogger(this.getClass());
	}
	
	public void deleteAccounts() {
		
		deleteInvoices();
		
		logger.debug("Deleting Accounts from the database");
		em.createQuery("delete Account").executeUpdate();
	}
	
	public void deleteProducts() {
		
		deleteInvoices();
		
		logger.debug("Deleting Products from the datase");
		em.createQuery("delete Product");
	}
	
	public void deleteInvoices() {
		
		logger.debug("Deleting invoice line items");
		em.createQuery("delete InvoiceLineItem").executeUpdate();
		
		logger.debug("Deleting invoices");
		em.createQuery("delete Invoice").executeUpdate();
	}
	
	public void createAccounts(List<Account> accounts) {
		
		if(accounts != null && accounts.size() > 0) {
			logger.debug("Writing {} accounts to the database", accounts.size());
			em.persist(accounts);
			em.flush();
			createInvoices();
		}
			
	}
	
	public void createProducts(List<Product> products) {
		
		if(products != null && products.size() > 0) {
			logger.debug("Writing {} product records to the database", products.size());
			em.persist(products);
			em.flush();
			createInvoices();
		} else {
			logger.debug("Null or empty product list detected, nothing to persist");
		}
	}
	
	public void createInvoices() {
		
		List<Account> accounts = em.createQuery("from Account").getResultList();
		List<Product> products = em.createQuery("from Product").getResultList();
		Random r = new Random();
		for(Account a : accounts) {
			Set<Invoice> invoices = new HashSet<Invoice>();
			for(int i=0 ; i<=r.nextInt(maxNumberOfInvoices) ; i++) {
				invoices.add(createInvoice(a, products));
			}
			a.setInvoices(invoices);
		}
		em.persist(accounts);
		
	}
	
	private Invoice createInvoice(Account a, List<Product> products) {
		Invoice i = new Invoice();
		
		i.setAccount(a);
		i.setInvoiceDate(getRandomDate());
		i.setStatus(getRandomStatus());
		i.setLineItems(createLineItems(products));
		
		return i;
	}
	
	private Date getRandomDate() {
		
		Random r = new Random();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_YEAR, -r.nextInt(maxNumberOfDaysInPast));
		return cal.getTime();
		
	}
	
	private String getRandomStatus() {
		
		Random r = new Random();
		int index = r.nextInt(statusValues.length + 1);
		if(index > 0)
			index--;
		if (index > statusValues.length)
			index = statusValues.length;
		return statusValues[index];
	}
	
	private Set<InvoiceLineItem> createLineItems(List<Product> products) {
		
		Set<InvoiceLineItem> lineItems = new HashSet<InvoiceLineItem>();
		Random r = new Random();
		
		for(int i=0 ; i <= r.nextInt(maxNumberOfLineItems); i++) {
			InvoiceLineItem li = new InvoiceLineItem();
			
			li.setProduct(products.get(r.nextInt(products.size())));
			li.setQuantity(r.nextInt(maxQuantity));
			lineItems.add(li);
		}
		
		return lineItems;
	}
}
