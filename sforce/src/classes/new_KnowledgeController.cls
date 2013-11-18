global with sharing class new_KnowledgeController {

	public new_KnowledgeController() {}
	
	@RemoteAction
	global static String getKnowledge(String objectId) {
		
		ArticleWrapper wrapper = new ArticleWrapper();
		
		try {
			List<KnowledgeArticleVersion> kavs = null;
			
			if(objectId != null && !objectId.equals('') && !objectId.equals('null')) {
				Id objId = Id.valueOf(objectId);
				// determine which type of article is going to be fetched depending on type of object
				if(objId.getSObjectType() == Schema.Case.getSObjectType()) {
					String subject = [select subject from case where id = :objId limit 1].subject;
					kavs = getCaseArticles(subject);
				} else if(objId.getSObjectType() == Schema.Opportunity.getSObjectType()) {
					kavs = getOpptyArticles();
				} 
			}
			// if there are no object related articles, retrieve system help articles
			if(kavs == null) {
				kavs = getSystemHelpArticles();
			}
			
			List<Id> ids = new List<Id>();
			for(KnowledgeArticleVersion kav : kavs) {
				ids.add(kav.knowledgeArticleId);
				wrapper.setSingleArticle(kav);
			}
			if(!ids.isEmpty()) {
            	// get the viewstats for those articles
            	List<KnowledgeArticleViewStat> viewStats = [select id, normalizedscore, parent.id from knowledgearticleviewstat where parent.id in :ids and channel = 'AllChannels'];
            	for(KnowledgeArticleViewStat vs : viewStats) {
            		for(Article a : wrapper.articles) {
                		if(a.knowledgeArticleId == vs.parent.id){
                   			a.viewStat = String.valueOf(Math.roundToLong(vs.normalizedscore / 20) * 20);
                       		break;
                   		}
                	}
            	}
            	wrapper.instruction = 'show';
			} else {
				wrapper.instruction = 'hide';
			}
		} catch (QueryException qe) {
			wrapper.instruction = 'error';
			wrapper.errorMessage = qe.getMessage();
		}

		return JSON.serialize(wrapper);
	} 
		
	private static List<KnowledgeArticleVersion> getOpptyArticles() {
		List<Product__kav> productArticles = [SELECT KnowledgeArticleId FROM Product__kav where publishstatus = 'Online' and language = 'en_US'];
		List<Id> articleIds = new List<Id>();
		for(Product__kav p : productArticles) {
			articleIds.add(p.knowledgeArticleId);
		}	
		return getGenericVersions(articleIds);
	}
	
	private static List<KnowledgeArticleVersion> getCaseArticles(String subject) {
		List<Support__kav> productArticles = [SELECT KnowledgeArticleId FROM Support__kav where publishstatus = 'Online' and language = 'en_US'];
		List<Id> articleIds = new List<Id>();
		for(Support__kav p : productArticles) {
			articleIds.add(p.knowledgeArticleId);
		}	
		return getGenericVersions(articleIds);
	}
	
	private static List<KnowledgeArticleVersion> getSystemHelpArticles() {
		List<Training__kav> productArticles = [SELECT KnowledgeArticleId FROM Training__kav where publishstatus = 'Online' and language = 'en_US'];
		List<Id> articleIds = new List<Id>();
		for(Training__kav p : productArticles) {
			articleIds.add(p.knowledgeArticleId);
		}	
		return getGenericVersions(articleIds);
	}
	
	private static List<KnowledgeArticleVersion> getGenericVersions(List<Id> knowledgeArticleIds) {
	
		return [SELECT KnowledgeArticleId, ArticleNumber,ArticleType,Id,LastPublishedDate,PublishStatus,Summary,Title FROM KnowledgeArticleVersion where publishstatus = 'Online' and knowledgeArticleId in :knowledgeArticleIds];	
	}	
    global class ArticleWrapper {
        public List<Article> articles {get; set;}
        public String message {get; set;}
        public String instruction {get; set;}
        public String errorMessage {get; set;}
        
        public ArticleWrapper() {
        	articles = new List<Article>();
        }
        
        public void setArticles(List<KnowledgeArticleVersion> kavs) {
            for(KnowledgeArticleVersion kav : kavs) {
				articles.add(new Article(kav));	   
            } 
        }
        public void setSingleArticle(KnowledgeArticleVersion kav) {
        	articles.add(new Article(kav));    
        }
    }
    
    global class Article {
        public String title {get; set;}
        public String summary {get; set;}
        public String id {get; set;}
        public String views {get; set;}
        public String publishDate {get; set;}
        public String knowledgeArticleId {get; set;}
        public String viewStat {get ; set;}
        
        public Article(KnowledgeArticleVersion pArticle) {
        	title = pArticle.title; 
            summary = pArticle.summary;
            id = pArticle.id;
            publishDate = pArticle.lastpublisheddate.date().format();
            knowledgeArticleId = pArticle.knowledgeArticleId;
        }

    }
		
}