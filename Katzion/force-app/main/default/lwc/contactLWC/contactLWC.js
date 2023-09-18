import { LightningElement, api} from "lwc";
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import ADDRESS_FIELD from "@salesforce/schema/Contact.MailingAddress";
import CITIZENID_FIELD from "@salesforce/schema/Contact.Citizen_Id__c";
import DRIVERSLICENCE_FIELD from "@salesforce/schema/Contact.Drivers_Licence_Number__c";
import FACEBOOK_FIELD from "@salesforce/schema/Contact.Facebook__c";
import LINKEDIN_FIELD from "@salesforce/schema/Contact.LinkedIn__c";
import LATITUDE_FIELD from "@salesforce/schema/Contact.Latitude__c";
import LONGITUDE_FIELD from "@salesforce/schema/Contact.Longitude__c";
import { NavigationMixin } from 'lightning/navigation';

/**
 * Creates Contact records.
 */
export default class ContactLWC extends LightningElement {
    @api recordId;
    contactObject = CONTACT_OBJECT;
    contactFields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAIL_FIELD, PHONE_FIELD, ADDRESS_FIELD, 
      CITIZENID_FIELD, DRIVERSLICENCE_FIELD, FACEBOOK_FIELD, LINKEDIN_FIELD, LATITUDE_FIELD, LONGITUDE_FIELD];
  
    handleContactCreated(event) {
      console.log(event.detail);
      try {
        //redirect to the view page when Contact is created/updated.
        this[NavigationMixin.Navigate]({
          type: 'standard__recordPage',
          attributes: {
            recordId: event.detail.id,
            actionName: 'view'
          }
        });
      } catch (error) {
        console.log(error);
        console.error(error);
      }
      
    }
}