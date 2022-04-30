import { ProtocolCard } from '../ProtocolCard/protocolCard';


/**
 * A factory class which creates the cards only for the cardTable passed to its constructor
 * */
class CardFactory {

    constructor(cardTable) {
        this.cardTable = cardTable;
        this.protocolList = [];
    }

    /**
     * Populates the table with cards from the protocols list
     * @param {object} cardTable
     */
    populateTable() {
        this.sortProtocols();

        this.protocolList.forEach(x => (x) => {
            let oldCard = this.cardTable.getCard(x.title);

            // If a card for the related protocol does not exist,
            // create both a card and tab.
            if (oldCard === null) {
                let newCard = new ProtocolCard(x.title, x.patientType);
                newCard.addTab(x);
                this.cardTable.addCard(newCard)
            }
             //Otherwise, only create a tab.
            else
            {
                oldCard.addTab(x);
            }
            
        });
    }

    /**
     * Sorts the protocols alphabetically by title 
     */
    sortProtocols() {
        this.protocolList.sort((a, b) => (a.title > b.title) ? 1 : -1);
    }

    /**
     * Adds the protocol to the list
     * @param {any} protocol
     */
    addProtocol(protocol)
    {
        this.protocolList.push(protocol);
    }

    /**
     * Removes all protocols from the list 
     */
    clearProtocolList()
    {
        this.protocolList = [];
    }
}

export { CardFactory };