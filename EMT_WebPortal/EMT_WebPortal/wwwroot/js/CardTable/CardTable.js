import { CardFactory } from './cardFactory.js';
//import { WebWorker } from '../WebWorker/webWorker';

class CardTable extends HTMLElement
{
    constructor() {
        super();

        this.cardFactory = new CardFactory(this);
        // this.webWorker = new WebWorker();
        this.cardList = [];

        let protocols = [
            { id: 0, title: 'title1', patientType: 'Adult', certificationLevel: 'ALL' },
            { id: 1, title: 'title1', patientType: 'Adult', certificationLevel: 'EMT' },
            { id: 2, title: 'title1', patientType: 'Adult', certificationLevel: 'AEMT' },
            { id: 3, title: 'title1', patientType: 'Adult', certificationLevel: 'PARA' },
            { id: 0, title: 'title1', patientType: 'Pediatric', certificationLevel: 'ALL' },
            { id: 1, title: 'title1', patientType: 'Pediatric', certificationLevel: 'EMT' },
            { id: 2, title: 'title1', patientType: 'Pediatric', certificationLevel: 'AEMT' },
            { id: 3, title: 'title1', patientType: 'Pediatric', certificationLevel: 'PARA' },
        ];
        this.cardFactory.setProtocolList(protocols);
        this.cardFactory.populateTable();

        this.id = 'CardTable';
        this.classList = ('card-table');
    }

    /**
     * Adds newCard to the cardTable
     * @param {any} newCard
     */
    addCard(newCard)
    {
        this.cardList.push(newCard);
        this.appendChild(newCard);
    }

    /**
     * Returns the card with a matching title, or undefined.
     * @param {any} title
     */
    getCard(title, patientType)
    {
        let theCard = this.cardList.find(card => (card.title === title && card.patientType === patientType));
        return theCard;
    }
}

customElements.define('card-table', CardTable);

export { CardTable };