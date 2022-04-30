import { CardFactory } from './cardFactory';
import { WebWorker } from '../WebWorker/webWorker';

class CardTable extends HTMLElement
{
    constructor() {
        super();

        this.cardFactory = new CardFactory(this);
        this.webWorker = new WebWorker();
        this.cardList = [];

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
    getCard(title)
    {
        return this.cardList.find(card => {
            return card.title === tile;
        });
    }
}