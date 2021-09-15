/*
 *  Author: Vincent Futrell
 *  Date Last Modified: 03/24/2021
 *  
 *  File Contents:
 *  This file contains the method to seed the SQL database with initial Data
 */
using EMT_WebPortal.Models;
using EMT_WebPortal.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EMT_WebPortal.Data
{
    public class Protocol_Seeding
    {
        /// <summary>
        /// Seeds the database context
        /// </summary>
        /// <param name="context"></param>
        public static void SeedDatabase(EMTManualContext context) 
        {
            //Seed medication table
            var medications = new Medication[]
            {
                new Medication{Name="Acetaminophen(Tylenol)", Action="An analgesic/antipyretic that has weak anti-inflammatory activity and no effects on platelets or bleeding time. Acetaminophen acts both centrally and peripherally via multiple enzymatic processes. The most significant appears to be peroxidase inhibition which yields COX-2 inhibitor-like effects.",
                Indication="Fever. Minor Pain", Contradiction="Hypersensitivity, Known liver disease(relative)", Precaution="Do not administer if used in the last 4 hours.", AdverseEffects="Gastric Irritation(rare)", AdultDosage="PO 650-1000mg, single dose only", ChildDosage="15mg/kg PO/Rectal, single dose only. Max 650mg"}
            };

            context.Medications.AddRange(medications);
            context.SaveChanges();


            //Seed Guideline table
            var guidelines = new Guideline[]
            {
                new Guideline{Name="General Patient Care Guidelines", Background="These guidelines were created to provide direction to each level of certified provider in caring for all types of patients. All of these directions, dosages and provisions are subject to change with a later notice or revision of the guidelines. The OLMC physician will always be the final word on treatment in the field. If there are ever any discrepancies between the guidelines and the OLMC physician these should be documented and brought to the attention of the physician at the receiving hospital. If the explanation is not sufficient, the provider should bring the issue to their medical director or the BEMSP for review.",
                Checklist ="Assess your patient prior to choosing the appropriate protocol to follow, "+
                    "More than one protocol may apply, "+"If conflicts arise between treatment guidelines, contact OLMC for clarification, " +
                    "Providers may provide treatment up to the level of their certification only, "+"Air Medical Transport Service personnel function under their own clinical guidelines, " +
                    "Contact the receiving hospital and OLMC as soon as clinically possible for each patient, "+"OLMC physician may change your treatment plan, "+
                    "Any variations to a guideline by the OLMC or physician should be clarified to ensure that the provider has properly characterized the situation, "+
                    "The OLMC Physician has the final word on treatment once contact is made, "+"OLMC physician must approve usage of dosages in excess of the guideline" }
            };
            context.Guidelines.AddRange(guidelines);
            context.SaveChanges();

            //Seed protocol table
            var protocols = new Protocol[]
            {
                new Protocol{Name="AIRWAY AND TRACHEOSTOMY MANAGEMENT", Certification="All", GuidelineId=1, PatientType=1, Chart=null, HasAssociatedMedication=false, Medications=null,
                OtherInformation="Focused history and physical exam: " +
                "Assess ABC’s for evidence of current apnea, airway reflex compromise or difficulty in ventilatory effort, " +
                "Assess medical conditions, burns or traumatic injuries that may have or will compromise the airway, "+
                "Continuous cardiac, EtCO2, blood pressure, and pulse oximetry monitoring, when available, "+
                "Obtain a 12-lead EKG when available",
                TreatmentPlan= "Provide basic airway maneuvers to all compromised airways, i.e. jaw-thrust, airway adjuncts, and oxygen, "+
                    "Identify and treat underlying reversible medical conditions (narcotic overdose, hypoglycemia, etc.), "+
                    "Provide supplemental oxygen and assisted ventilation as needed for the patient to maintain an oxygen saturation 90-94% and EtCO2 of 35-45, "+
                    "Always ensure proper care of the cervical spine during airway treatment per the Spinal Motion Restriction (SMR) Protocol, "+
                    "Keep NPO. Stop any GI Feedings and do not use GI tube during resuscitation except to vent tube if assisted ventilations being delivered, "+
                    "Infants and young children are primary nose breathers. Suction oral and nasal passages as needed to keep clear, "+
                    "BVM is the preferred method of ventilation below the age of 10 years old, "+
                    "Tracheostomy/Home Ventilator: " +
                    "Primary caretakers and families are your best resource for understanding the equipment they are using," +
                    "Disconnect the ventilator and assist ventilations with BVM if the patient is apneic, unresponsive, or has severe respiratory distress. (Disconnecting a vent poses a very HIGH risk for body fluid exposure and can be dangerous to the patient if done incorrectly, don appropriate PPE, and see appendix for more details), " +
                    "If unable to ventilate, suction the tracheostomy, then reattempt ventilatory efforts, " +
                    "If still unable to ventilate, attempt traditional BVM," +
                    "If there is difficulty ventilating a tracheostomy patient, consider “D.O.P.E.” (Dislodged ? Obstruction ? Pneumothorax ? Equipment failure ?)",
                OLMCRequired = true},

                new Protocol{Name="AIRWAY AND TRACHEOSTOMY MANAGEMENT", Certification="EMT", GuidelineId=1, PatientType=2, Chart=null, HasAssociatedMedication=false, Medications=null,
                 OtherInformation=null, TreatmentPlan= "Ventilate with BVM when apneic or exhibiting respiratory distress. Consider a nasal or oral airway when not contraindicated (facial fractures, intact gag response, etc.), "+
                     "Avoid hyperventilation: maintain a ventilatory rate of 10-12 breaths per minute", OLMCRequired = false },

                new Protocol{Name="AIRWAY AND TRACHEOSTOMY MANAGEMENT", Certification="EMT", GuidelineId=1, PatientType=3, Chart=null, HasAssociatedMedication=false, Medications=null,
                OtherInformation=null, TreatmentPlan="Ventilate with BVM when apneic or exhibiting respiratory distress. Consider a nasal or oral airway when not contraindicated (facial fractures, intact gag response, etc.), "+
                    "Avoid hyperventilation - recommended pediatric ventilatory rates:, " +
                    "Infant (0-12 month): 25 breaths per minute, " +
                    "1 - 3 yrs: 20 breaths per minute, " +
                    "4 - 6 yrs: 15 breaths per minute, " +
                    "> 6 years: 12(Same as adult)",
                OLMCRequired = true
                }
            };

            context.Protocols.AddRange(protocols);
            context.SaveChanges();

            //Seed User table
            var users = new User[] 
            {
                new User{Name="Test User", Admin=false, Certification="EMT" },
                new User{Name="Test Admin", Admin=true, Certification="None"},
                new User{Name="Test Team Lead", Admin=false, Certification="PARA"}
            };
            context.Users.AddRange(users);
            context.SaveChanges();

            var phoneNumbers = new PhoneNumber[]
            {
                new PhoneNumber{hospitalName="General Hospital", numberString="555-555-5555"}
            };
            context.PhoneNumbers.AddRange(phoneNumbers);
            context.SaveChanges();

        }
    }
}
