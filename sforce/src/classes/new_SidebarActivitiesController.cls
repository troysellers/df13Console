global with sharing class new_SidebarActivitiesController {


	public new_SidebarActivitiesController() { }
	
	@RemoteAction
	global static String getTasks(String objectId) {
		
		ObjectWrapper ow = new ObjectWrapper();
		ow.parentObjectId = objectId;
		
		if(objectId != null && !objectId.equals('') && !objectId.equals('null')) {
			Id objId = Id.valueOf(objectId);
			List<SObject> sObjects = new List<SObject>();
			Map<String, Schema.FieldSet> fieldSets = Schema.SObjectType.Task.fieldSets.getMap();
			List<String> fieldLabels = new List<String>();
			List<String> fieldNames = new List<String>();
			
			if(objId == null || objId.getSObjectType() != Schema.SObjectType.Account.getSObjectType())
				ow.instruction =  'hide';
			else {
				if(fieldSets.containsKey('Console')) {
					Schema.FieldSet fieldSet = fieldSets.get('Console');
					String query = 'SELECT ';
					for(Schema.FieldSetMember fsm : fieldSet.getFields()) {
						fieldLabels.add(fsm.getLabel());
						fieldNames.add(fsm.getFieldPath());
	            		query += fsm.getFieldPath() + ', ';
	        		}
	        		query += 'Id FROM Task where whatId = \''+objectId+'\'';
	        		System.debug('~~ query ['+query+']');	
	        		try {	
	        			sObjects = Database.query(query);
	        			ow.instruction = 'show';
	        		} catch (QueryException qe) {
	        			//if nothing is returned we want to say empty
	        			System.debug('~~ query ['+qe.getMessage()+']');
	        			ow.instruction = 'error';
	        			ow.errorMessage = qe.getMessage();
	        		}
				}
				if(sObjects.isEmpty()) {
					ow.instruction = 'empty';
		 		} 
		 		// populate fields so page can render dynamically
		 		ow.objects = sObjects;
		 		ow.fieldLabels = fieldLabels;
		 		ow.fieldNames = fieldNames; 		
		 		ow.objectLabelPlural = Schema.Sobjecttype.Task.getLabelPlural();			
			} 
		} else {
			ow.instruction = 'hide';
		}
		return JSON.serialize(ow);	
	}
	

	
}