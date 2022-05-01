import { CardTable } from './CardTable/CardTable';

window.onload(() => {
    let container = document.getElementById('card-table-container');
    if (container) {
        let cardTable = new CardTable();
        container.appendChild(cardTable);
    }
});