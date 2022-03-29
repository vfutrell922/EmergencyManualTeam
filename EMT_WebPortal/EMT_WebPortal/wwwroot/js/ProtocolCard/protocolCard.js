
import {
    TitleBar
} from './titleBar.js';

import {
    TabArea
} from './tabArea.js';

class ProtocolCard extends HTMLElement {

    constructor(title, patientType) {

        super();

        this.titleBar = new TitleBar(title, patientType);
        this.tabArea = new TabArea();
        this._title = title;
        this._patientType = patientType;

        let protocolCard = document.createElement("div");


        protocolCard.appendChild(this.titleBar);
        protocolCard.appendChild(this.TabArea);

        return ProtocolCard;
    }
}


customElements.define('protocol-card', ProtocolCard);

export { ProtocolCard };