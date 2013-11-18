public with sharing class new_SidebarMilestoneController {


	public String violatedTopicName { 
		get {
			return 'Violated_Case_Milestone';
		} set;
	}
	
	public String warningTopicName {
		get {
			return 'Warning_Case_Milestone';
		} set;
	}

	private Decimal apiVersion {
		get {
			if(apiVersion == null) {
				ApexClass apexClass = [select apiVersion from ApexClass where Name = 'new_SidebarMilestoneController'];
				apiVersion = apexClass.apiVersion;
			}
			return apiVersion;
		} set;
	}

	public new_SidebarMilestoneController() {	
	}
	/*
		If the PushTopic is not available, create it.
	*/
	public void createNewTopics() {
		List<PushTopic> pushTopics = [select id, name from PushTopic];
		boolean violatedExists = false;
		boolean warningExists = false;
		
		for(PushTopic pt : pushTopics) {
			
			if(pt.Name.equals(violatedTopicName)) {
				violatedExists = true;
			}
			if(pt.Name.equals(warningTopicName)) {
				warningExists = true;
			}
		}
		List<PushTopic> newTopics = new List<PushTopic>();
		if(!violatedExists) {
			PushTopic violationTopic = new PushTopic();
			violationTopic.name = violatedTopicName;
			violationTopic.query = 'select id, casenumber, subject from case where Case_Milestone_Violation__c = true';
			violationTopic.ApiVersion = apiVersion;
			newTopics.add(violationTopic);
		}
		
		if(!warningExists) {
			PushTopic warningTopic = new PushTopic();
			warningTopic.name = warningTopicName;
			warningTopic.query = 'select id, casenumber, subject from case where Case_Milestone_Warning__c = true';
			warningTopic.apiVersion = apiVersion;
			newTopics.add(warningTopic);
		}
		
		if(!newTopics.isEmpty()) {
			insert newTopics;
		}		
	}


}