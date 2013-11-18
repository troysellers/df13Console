global with sharing class new_SidebarOpportunitiesController {

	public new_SidebarOpportunitiesController() {}

	@RemoteAction
	global static String getOpptiesAsJSON(String objectId) {
		
		ObjectWrapper ow = new ObjectWrapper();
		ow.parentObjectId = objectId;		
	
		if(objectId != null && !objectId.equals('') && !objectId.equals('null')) {

			Id objId = Id.valueOf(objectId);
			List<Opportunity> opportunities = new List<Opportunity>();
			Map<String, Schema.FieldSet> fieldSets = Schema.SObjectType.Opportunity.fieldSets.getMap();
			List<String> fieldLabels = new List<String>();
			List<String> fieldNames = new List<String>();	
			
			// hide the oppty sidebar component if we don't have an account visible
			if(objId == null || objId.getSObjectType() != Schema.SObjectType.Account.getSObjectType()) {
				ow.instruction = 'hide';	
			} else {
				// get the FieldSet name Conosle. Enables Admin configurable cols in this component
				// using this fieldSet we can build a dynamic query for the data
				if(fieldSets.containsKey('Console')) {
					Schema.FieldSet fieldSet = fieldSets.get('Console');
					String query = 'SELECT ';
					for(Schema.FieldSetMember fsm : fieldSet.getFields()) {
						fieldLabels.add(fsm.getLabel());
						fieldNames.add(fsm.getFieldPath());
	            		query += fsm.getFieldPath() + ', ';
	        		}
	        		query += 'Id FROM Opportunity where accountId = \''+objectId+'\'';
	        		System.debug('~~ query ['+query+']');	
	        		try {	
	        			opportunities = (List<Opportunity>)Database.query(query);
	        			ow.instruction = 'show';
	        		} catch (QueryException qe) {
	        			System.debug('~~ query ['+qe.getMessage()+']');
	        			ow.instruction = 'error';
	        			ow.errorMessage = qe.getMessage();	
	        		}
				}
				if(opportunities.isEmpty()) {
					ow.instruction = 'empty';
	 			} 
	
	 			ow.objects = opportunities;
	 			ow.parentObjectId = objectId;
	 			ow.fieldLabels = fieldLabels;
	 			ow.fieldNames = fieldNames;
	 			ow.objectLabelPlural = Schema.Sobjecttype.Opportunity.getLabelPlural();	
			}	
			
		} else {
			ow.instruction = 'hide';
		}
	
		return JSON.serialize(ow);
		
	}
}