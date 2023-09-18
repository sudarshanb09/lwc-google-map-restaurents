@isTest
public class NearestRestaurantSearchControllerTest {

    @testSetup static void setup() {
        // Create common test contact
        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Restaurant',
            Email = 'test@test.com.dev',
            Phone = '123435678',
            Citizen_Id__c = '123435678',
            Drivers_Licence_Number__c = '123435678',
            Facebook__c = 'https://www.facebook.com/',
            LinkedIn__c = 'https://www.linkedin.com/',
            Latitude__c = -33.8670522,
            Longitude__c = 151.1957362
        );
        insert testContact;        
    }

    @isTest static void testRestautrantAPICallout() {
        Contact contact = [SELECT Id FROM Contact LIMIT 1];
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        NearestRestaurantSearchController.RestaurantWrapper res = NearestRestaurantSearchController.getNearestRestaurant(contact.Id);
        
        // Verify response received contains fake values
        System.assertEquals(res.contact.Id, contact.Id, 'Contact not matched');
        String actualValue = res.restaurantResult;
        String expectedValue = '{ "html_attributions": [], "results": [ { "business_status": "OPERATIONAL", "geometry": { "location": { "lat": -33.8587323, "lng": 151.2100055 }, "viewport": { "northeast": { "lat": -33.85739847010727, "lng": 151.2112436298927 }, "southwest": { "lat": -33.86009812989271, "lng": 151.2085439701072 }, }, }, "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/bar-71.png", "icon_background_color": "#FF9E67", "icon_mask_base_uri": "https://maps.gstatic.com/mapfiles/place_api/icons/v2/bar_pinlet", "name": "Cruise Bar", "opening_hours": { "open_now": false }, "photos": [ { "height": 608, "photo_reference": "Aap_uECvJIZuXT-uLDYm4DPbrV7gXVPeplbTWUgcOJ6rnfc4bUYCEAwPU_AmXGIaj0PDhWPbmrjQC8hhuXRJQjnA1-iREGEn7I0ZneHg5OP1mDT7lYVpa1hUPoz7cn8iCGBN9MynjOPSUe-UooRrFw2XEXOLgRJ-uKr6tGQUp77CWVocpcoG", "width": 1080, }, ], "place_id": "ChIJi6C1MxquEmsR9-c-3O48ykI", "plus_code": { "compound_code": "46R6+G2 The Rocks, New South Wales", "global_code": "4RRH46R6+G2", }, "price_level": 2, "rating": 4, "reference": "ChIJi6C1MxquEmsR9-c-3O48ykI", "scope": "GOOGLE", "types": ["bar", "restaurant", "food", "point_of_interest", "establishment"], "user_ratings_total": 1269, "vicinity": "Level 1, 2 and 3, Overseas Passenger Terminal, Circular Quay W, The Rocks", }]}';
        System.assertEquals(actualValue, expectedValue);
        Test.stopTest();
    }

    public class MockHttpResponseGenerator implements HttpCalloutMock {
            // Implement this interface method
            public HTTPResponse respond(HTTPRequest req) {
                // Optionally, only send a mock response for a specific endpoint
                System.assertEquals('GET', req.getMethod());
                // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{ "html_attributions": [], "results": [ { "business_status": "OPERATIONAL", "geometry": { "location": { "lat": -33.8587323, "lng": 151.2100055 }, "viewport": { "northeast": { "lat": -33.85739847010727, "lng": 151.2112436298927 }, "southwest": { "lat": -33.86009812989271, "lng": 151.2085439701072 }, }, }, "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/bar-71.png", "icon_background_color": "#FF9E67", "icon_mask_base_uri": "https://maps.gstatic.com/mapfiles/place_api/icons/v2/bar_pinlet", "name": "Cruise Bar", "opening_hours": { "open_now": false }, "photos": [ { "height": 608, "photo_reference": "Aap_uECvJIZuXT-uLDYm4DPbrV7gXVPeplbTWUgcOJ6rnfc4bUYCEAwPU_AmXGIaj0PDhWPbmrjQC8hhuXRJQjnA1-iREGEn7I0ZneHg5OP1mDT7lYVpa1hUPoz7cn8iCGBN9MynjOPSUe-UooRrFw2XEXOLgRJ-uKr6tGQUp77CWVocpcoG", "width": 1080, }, ], "place_id": "ChIJi6C1MxquEmsR9-c-3O48ykI", "plus_code": { "compound_code": "46R6+G2 The Rocks, New South Wales", "global_code": "4RRH46R6+G2", }, "price_level": 2, "rating": 4, "reference": "ChIJi6C1MxquEmsR9-c-3O48ykI", "scope": "GOOGLE", "types": ["bar", "restaurant", "food", "point_of_interest", "establishment"], "user_ratings_total": 1269, "vicinity": "Level 1, 2 and 3, Overseas Passenger Terminal, Circular Quay W, The Rocks", }]}');
            res.setStatusCode(200);
            return res;
        }
    }
}
