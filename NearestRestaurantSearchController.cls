public with sharing class NearestRestaurantSearchController {
    
    public static Contact getContact(String recordId) {
        return [
            SELECT MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode,
            MailingLatitude,MailingLongitude,
            Latitude__c, Longitude__c
            FROM Contact
            WHERE Id =: recordId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static RestaurantWrapper getNearestRestaurant(String recordId){
        Contact con = getContact(recordId);
        String API_KEY = 'AIzaSyCHy9TSAWCm_V0b1UO9tFa174py5o14Sng';
        String queryParams = 'keyword=restaurant'
        +'&location='+con.Latitude__c+'%2C'+con.Longitude__c
        //+'&location=26.879590%2C75.733402'
        +'&radius=5000&type=restaurant&key='+API_KEY ;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Google_Place_Search?'+queryParams);
        req.setMethod('GET');
        HttpResponse resp = http.send(req);
        return new RestaurantWrapper(con, resp.getBody());
    }

    public class RestaurantWrapper{
        @AuraEnabled
        public Contact contact;

        @AuraEnabled
        public String restaurantResult;
        public RestaurantWrapper(Contact contact, String restaurantResult){
            this.contact = contact;
            this.restaurantResult = restaurantResult;
        }
    }
}