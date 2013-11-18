public with sharing class CanvasOrdersController {


	private Account acc;
	
	public String parameters {get; set;}
	public CanvasOrdersController(ApexPages.StandardController controller) {
		acc = (Account)controller.getRecord();
		parameters = '{mode:\'component\', accId: \''+acc.customer_id__c+'\'}';	
	}
}