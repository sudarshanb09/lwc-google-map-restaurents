import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import ADDRESS_FIELD from "@salesforce/schema/Contact.MailingAddress";
import getNearestRestaurant from "@salesforce/apex/NearestRestaurantSearchController.getNearestRestaurant";

export default class NearestRestaurant extends LightningElement {
    @api recordId;
    mapMarkers = [];
    selectedMarkerValue = '';
    
    @wire(getNearestRestaurant, { recordId: "$recordId"})
    wiredRestaurant({error, data}){
        if(data){
            //console.log(data);
            this.loadRestaurants(data);
        } else if(error){
            console.log(error);
        }
    }


    loadRestaurants(restaurantData){
        this.mapMarkers = [];
        this.selectedMarkerValue = '';
        console.log("restaurantData.results");
        let contact ={}
        if(restaurantData.contact){
            contact = restaurantData.contact;
        }
        if(restaurantData.restaurantResult){
            let count = 0;
            let restaurantResult = JSON.parse(restaurantData.restaurantResult);
            (restaurantResult.results).forEach(restaurant => {
                count++;
                if(count <= 15){
                    //console.log(restaurant.vicinity);
                    let address = restaurant.vicinity ? restaurant.vicinity.split(","):[];
                    if(this.selectedMarkerValue == ''){
                        this.selectedMarkerValue = restaurant.place_id;
                    }
                    //console.log(restaurant.name);
                    this.mapMarkers.push({
                        location: {
                            // Location Information
                            City: address? address[address.length -1]: '',
                            Country: contact.MailingCountry,
                            PostalCode: contact.MailingPostalCode,
                            State: contact.MailingState,
                            Street: restaurant.vicinity,
                        },

                        // For onmarkerselect
                        value: restaurant.place_id,

                        // Extra info for tile in list & info window
                        icon: 'standard:account',
                        title: restaurant.name,
                        description: restaurant.vicinity,
                    });
                }
            });
            
        }
        
    }

    handleMarkerSelect(event) {
        this.selectedMarkerValue = event.target.selectedMarkerValue;
    }
}